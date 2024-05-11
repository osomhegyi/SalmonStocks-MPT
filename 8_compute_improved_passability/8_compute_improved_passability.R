#..........................function to determine the budget allocated to each population.........................
## function to determine the budget allocated using weights
budget_allocated_fcn <- function(budget,weight){
  weight=weight %>% unlist()
  budget_allocated <- budget * weight
  return(budget_allocated)
}

# budget_allocated_df = map_df(.x=weights_list,~budget_allocated_fcn(budget,.x)) # run the function to create a dataframe of allocated budgets

#............................function to determine number of barriers to be removed..........................................
## run the while loop within a function and call it 'while_fcn'. Doing this so we can run the function through purrr with many budget allocations.
while_fcn <- function(budget_allocated,barrier_list) {

  i = 1
  used_b = 0
  
  while(used_b <= budget_allocated && i <= length(barrier_list$cost)) { #stop running if used_b is greater than budget_allocated
    used_b = barrier_list$cost[[i]] + used_b
    index_choice=i-1
    i = i + 1
  }
  
  
  qc <- nrow(barrier_list)
  
  rows_to_change <- min(index_choice, nrow(barrier_list)) ## to make sure the index choice isn't longer that the number of barriers
  df = barrier_list
  ## if else statment: if the rows to change is greater than zero then those rows will be updated in a new column called pass_score_invest where the passability scores will change to one. If there are no rows to change then the new column will have the same scores.  
  if (rows_to_change > 0) { 
    df$pass_score_invest = df$pass_score  
    df$pass_score_invest[1:rows_to_change] <- 1
  } else {
    df$pass_score_invest = df$pass_score
  }
  return(df)
}

#............................function to compute improved passability..........................................
bpassage_invest_compute_fcn <- function(df) {
  
  # name dataframe
  df <- df
  
  # identify number of stream levels in population
  r <- length(unique(df$strm_lev)) # number of levels in a population
  r_true_lev <- unique(df$strm_lev) # a vector of the values of each of those levels
  
  # create a vector for level and level_weight that is the length of r
  bpass_strm_lev_v <- numeric(r) # vector for stream level with length r
  w_strm_lev_v <- numeric(r) # vector for stream level weight with length r
  
  # initialize before entering for loop
  bpassage <- 0
  y <- 0
  
  # Calculate y (summation) mini for loop. `y` is defined outside of the next for loop below because it is a constant that equation.
  for (i in 1:r) {
    temp_y <- sum(1/i)
    y <- y + temp_y
  }
  
  # iterate over stream level
  for (i in 1:r) {
    
    # identify the value for the true stream level for i
    true_lev <- r_true_lev[i]
    
    # filter for just the level we want
    temp_lev_df <- df %>% 
      filter(strm_lev == true_lev)
    
    # count the number of barriers within stream level i
    n_barrier_strm_lev <- temp_lev_df %>% 
      summarise(count = n()) %>%
      pull(count) # keep it a vector
    
    # identify number of stream ids within the stream level
    sr <- length(unique(temp_lev_df$strm_id)) # number of id's in the level
    sr_true_id <- unique(temp_lev_df$strm_id) # vector of the values of those stream id's
    
    # create a vector for stream_id and stream_id_weight that is the length of sr
    bpass_strm_id_v <- numeric(sr)
    
    # compute weight by stream level
    strm_wgt <- 1 / (i * y)
    w_strm_lev_v[i] <- strm_wgt
    
    # initialize before entering next for loop
    prod_pass_strm_id <- 0
    w_strm_id <- 0
    strm_lev_passability <- 0
    
    # iterate over stream id within stream level
    for (j in 1:sr) {
      
      # identify the value for the true stream id for j
      true_id <- sr_true_id[j]
      
      # filter for just the data we want
      temp_id_df <- df %>% 
        filter(strm_lev == true_lev & strm_id == true_id)
      
      # identify number of barriers in the stream id
      n_barrier_strm_id <- temp_id_df %>% 
        summarise(count = n()) %>%
        pull(count) # keep it a vector
      
      # compute the product of all pass scores within the same id
      prod_pass_strm_id <- prod(temp_id_df$pass_score_invest)
      
      # compute weight for stream id j
      w_strm_id <- n_barrier_strm_id / n_barrier_strm_lev # weight component at id level
      
      # compute passability for stream id j
      id_passability <- prod_pass_strm_id * w_strm_id
      
      # update vector for passability of j
      bpass_strm_id_v[j] <- id_passability
      
    }
    
    # sum the passabilities across all ids within a stream level
    bpass_strm_lev <- sum(bpass_strm_id_v)
    
    # compute passability for each stream level
    bpass_strm_lev_v[i] <- bpass_strm_lev * w_strm_lev_v[i]
    
  }
  
  #bpassage for the population
  bpassage <- data.frame(sum(bpass_strm_lev_v))
  
  return(bpassage)
  
}

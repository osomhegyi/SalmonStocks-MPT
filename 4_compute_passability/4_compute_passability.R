# .................................compute passability before investment.....................................................................
bpassage_base_compute_fcn <- function(df) {
  
  # name dataframe
  df <- df
  
  # identify number of stream levels in population
  r <- length(unique(df$strm_lev)) # number of levels in a population
  r_true_lev <- unique(df$strm_lev) # a vector of values of each of those levels
  
  # create a vector for level and level_weight (wr) that is the length of r
  bpass_strm_lev_v <- numeric(r) # vector for stream level with length r
  w_strm_lev_v <- numeric(r) # vector for stream level weight with length r
  
  # initialize before entering for loop
  bpassage <- 0
  y <- 0
  
  # calculate y (summation) mini for loop. `y` is defined outside of the next for loop below because it is a constant that equation.
  for (i in 1:r) {
    temp_y <- sum(1/i)
    y <- y + temp_y
  }
  
  # iterate over stream level for a given population
  for (i in 1:r) {
    
    # identify the value for the true stream level value for i
    true_lev <- r_true_lev[i]
    
    # filter for the true steam level for i
    temp_lev_df <- df %>% 
      filter(strm_lev == true_lev)
    
    # count the number of barriers within stream level i
    n_barrier_strm_lev <- temp_lev_df %>% 
      summarise(count = n()) %>%
      pull(count) # keep as a vector
    
    # identify number of stream ids within stream level i
    sr <- length(unique(temp_lev_df$strm_id)) # number of id's in the level
    sr_true_id <- unique(temp_lev_df$strm_id) # vector of the values of those stream id's
    
    # create a vector for stream_id and stream_id_weight that is the length of sr
    bpass_strm_id_v <- numeric(sr) # vector for stream level with length sr, as defined above
    
    # compute weight by stream level
    strm_wgt <- 1 / (i * y) # compute weight for stream level i
    w_strm_lev_v[i] <- strm_wgt # assign weight
    
    # initialize before entering next for loop
    prod_pass_strm_id <- 0
    w_strm_id <- 0
    strm_lev_passability <- 0
 
    # iterate over stream id within stream level i
    for (j in 1:sr) {
      
      # identify the value for the true stream id for j
      true_id <- sr_true_id[j]
      
      # filter for the true stream id for j
      temp_id_df <- df %>% 
        filter(strm_lev == true_lev & strm_id == true_id)
      
      # identify number of barriers in the stream id
      n_barrier_strm_id <- temp_id_df %>% 
        summarise(count = n()) %>%
        pull(count) # keep as a vector
      
      # compute the product of all pass scores within the same id
      prod_pass_strm_id <- prod(temp_id_df$pass_score)
      
      # compute weight for stream id j
      w_strm_id <- n_barrier_strm_id / n_barrier_strm_lev # weight for a given stream id
      
      # compute passability for stream id j
      id_passability <- prod_pass_strm_id * w_strm_id
      
      # update vector for passability of j
      bpass_strm_id_v[j] <- id_passability
      
    }
    
    # sum the passabilities across all ids within a stream level
    bpass_strm_lev <- sum(bpass_strm_id_v)
    
    # compute passability for each stream level i
    bpass_strm_lev_v[i] <- bpass_strm_lev * w_strm_lev_v[i]
    
  }
  
  #bpassage for the population
  bpassage <- sum(bpass_strm_lev_v)
  
  return(bpassage)
  
}


# .................................Compute passability for each population..............................
# Apply function to each data frame in the list and combine the results into one dataframe
bpassage_base = map_df(.x=barrier_list,~bpassage_base_compute_fcn(.x))

# Pivot longer
bpassage_base <- bpassage_base %>% 
  pivot_longer(
    cols = c(1:19),
    names_to = "population",
    values_to = "bpassage"
  )

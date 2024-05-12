#.......................... Define the conservation budget for the portfolio .........................
budget = 3500000
budget = 13100000
budget = 23000000

#.......................... Create covariance matrix of the abundance data .........................
cov_matrix <- coho[2:20]
cov_matrix <- cov(cov_matrix)

#.......................... Function to generate portfolio results .........................
# function that will generate esu abundance and esu variance using passability and cost data
optimize_fcn <- function(weight){
  
  # bring in the weights
  weight = weight %>% unlist()
  
  # allocate budgets to each population
  budget_allocated <- pmap_dbl(list(budget, weight),budget_allocated_fcn) 
  
  # use budget allocation to determine how many barriers can be removed
  barriers_mitigated <- pmap(list(budget_allocated,barrier_list),while_fcn) 
  
  # recalculate passability after selected barriers had been removed 
  bpassage_invest <- unlist(map_df(.x=barriers_mitigated,~bpassage_invest_compute_fcn(.x)))
  
  # recalculate carry capacity coefficient after investment
  c_invest <- c_invest_fcn(z_c_df$z, bpassage_invest)
  
  # recalculate carry productivity coefficient after investment
  p_invest <- p_invest_fcn(z_p_df$z, bpassage_invest)
  
  # calculate abundance (S) after investment
  s_invest <- ((p_invest - 1) * c_invest)
  
  # calculate baseline abundance (S)
  s_baseline <- ((z_p_df$p_hat - 1) * z_c_df$c_hat)
  
  # sum all population's abundance after investment to get the total esu return
  esu_returns_invest <- sum(s_invest)
  
  # sum all population's abundance before investment to get the total esu return
  esu_returns_baseline <- sum(s_baseline)
  
  # variance at baseline
  temp_matrix_base <- as.matrix(cov_matrix) %*% as.matrix(s_baseline)
  esu_var_baseline <- t(as.matrix(s_baseline)) %*% temp_matrix_base
  
  # variance after investment
  temp_matrix_invest <- as.matrix(cov_matrix) %*% as.matrix(s_invest)
  esu_var_invest <- t(as.matrix(s_invest)) %*% temp_matrix_invest
  
  # return(s_baseline) # to look at single dataframe
  return(round(data.frame(esu_returns_invest, esu_returns_baseline, esu_var_invest, esu_var_baseline),3))
}

#.......................... Run function to generate portfolio results .........................
portfolios = map_df(.x=weights_list,~optimize_fcn(.x))

#..........................Calculate 'z' constant for each population.........................
## Isolate p_hat and population
p_hat_temp = equilibrium_all %>% ## using the df equilibrium_all that contains the nls results
  mutate(p_hat = map_dbl(coeff, ~.[['p_hat']])) %>% 
  select(population, p_hat) 


## Isolate c_hat and population
c_hat_temp = equilibrium_all %>% ## using the df equilibrium_all that contains the nls results
  mutate(c_hat = map_dbl(coeff, ~.[['c_hat']])) %>%
  select(population, c_hat)


## function to calculate z using p_hat and beta_passage
z_p_fcn <- function(p_hat, bpassage){
  z = p_hat / bpassage
  return(z)
}


## create a dataframe of p_hat, z, and bpassage
z_p_df <- bpassage_base %>% ## bpassage_base contains beta passage for each population
  cbind(p_hat_temp$p_hat) %>% 
  rename(p_hat = 3) %>% 
  mutate(z = pmap_dbl(list(p_hat,bpassage), z_p_fcn)) # use pmat_dbl to calculate the z constant from the productivity coefficient equation


## function to calculate z using c_hat and beta_passage
z_c_fcn <- function(c_hat, bpassage){
  z = c_hat / bpassage
  return(z)
}


## create a dataframe with c_hat, z, and bpassage
z_c_df <- bpassage_base %>% ## bpassage_base contains beta passage for each population
  cbind(c_hat_temp$c_hat) %>% 
  rename(c_hat = 3) %>% 
  mutate(z = pmap_dbl(list(c_hat,bpassage), z_c_fcn)) # use pmat_dbl to calculate the z constant from the carrying capacity coefficient equation
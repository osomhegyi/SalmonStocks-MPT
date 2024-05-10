##..............................Running NLS function for p hat and c hat...................................

## making coho data tidy, including generating the reciprocal form of recruits and abundance.
coho_recruits <- coho %>% 
  pivot_longer(cols = 2:20,
               names_to = 'population',
               values_to = 'abundance') %>% 
  mutate(year = as.numeric(year)) %>% 
  group_by(population) %>% 
  mutate(recruits = lead(abundance)) %>% 
  drop_na() %>% 
  mutate(recruits_flip = 1/ recruits,
         abundance_flip = 1/ abundance)

## define a function to calculate equilibrium abundance based on p_hat (baseline productivity) and c_hat (baseline carrying capacity) output parameters from nls
calculate_equil_abund <- function(abundance, p_hat, c_hat){
  
  ## equation derived from the Beverton Holt population model. this calculates abundance at equilibrium
  y = (p_hat * abundance)/(1 + (abundance/c_hat))
  
  return(y)
}

## function to perform nonlinear least squares (nls) optimization to find baseline productivity and carrying capacity coefficients.
all_nls <- function(coho_recruits){
  
  ## extract intercept and coefficient linear model
  intercept = coefficients(lm(coho_recruits$recruits_flip ~ coho_recruits$abundance_flip, data = coho_recruits))[1]
  coefficient = coefficients(lm(coho_recruits$recruits_flip ~ coho_recruits$abundance_flip, data = coho_recruits))[2]
  
  ## creating initial guess vector values for p_hat and c_hat
  guess_p = 1 / coefficient
  guess_c = 1 / (intercept * (1 / coefficient))
  
  ## perform nls optimization to calculate abundance function
  nls_result <- nls(recruits ~ calculate_equil_abund(abundance, p_hat, c_hat),
                    data = coho_recruits,
                    start = list(p_hat = guess_p, c_hat = guess_c), ## guess vectors
                    control = nls.control(minFactor = 1/8000, maxiter = 500, tol = 1e-03))
  return(nls_result)
}

## apply the all_nls function to every population to get separate p_hat and c_hat for each
equilibrium_all <- coho_recruits %>% 
  #filter(population!="tahkenitch") %>% 
  nest() %>% 
  mutate(nls_model = map(data, ~all_nls(.x))) %>% 
  mutate(coeff = map(nls_model, ~coefficients(.x))) ## storing the coefficients

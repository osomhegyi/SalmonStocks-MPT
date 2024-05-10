### Summary
This README summarizes the main purpose of the 5_compute_z_constant.R script. The user will run all lines to code to generate the z constants for the productivity and carrying capacity impact equation.

#### Variables
- `p_hat_temp`: data frame that contain the column of the names of each population (population) and it’s baseline productivity coefficient (p_hat)
- `c_hat_temp`: data frame that contains the columns the name of each population (population) and it’s baseline productivity coefficient (c_hat)
- `z_p_fcn`:  function that calculates the z constant of the productivity equation using productivity coefficient (p_hat) and the passability value for a population (bpassage) 
- `z_p_df`: data frame that contain a column of the name of population (population), total passability of the population (bpassage), productivity coefficient of the population (p_hat), and the calculated z constant of the population (z).
- `z_c_fcn`: function that calculates the z constant of the productivity equation using carrying capacity coefficient (c_hat) and the passability value for a population (bpassage)
- `z_c_df`: data frame that contain a column of the name of population (population), total passability of the population (bpassage), carrying capacity coefficient of the population (c_hat), and the calculated z constant of the population (z).

#### Workflow
1. Run code lines 3 - 11. The data frames p_hat_temp and c_hat_temp both contain a column of its respective coefficient that will be used to calculate the z constant. The z constant is calculated and will be treated as a constant going forward that will not change. It is generated to help back calculate the new productivity and carrying capacity after investment later on in this project. 
2. Run code lines 15 - 25. The `z_p_fcn` generates the new z constant for each population and is stored in the `z_p_df` data frame along with the baseline passability value and  baseline productivity coefficient of the population. We use cbind to add a column from the previously generated `p_hat_temp` dataframe with the baseline coefficient in order to use pmap across the coefficient and passability values. 
3. Run code lines 29 - 39. The `z_c_fcn` generates the new z constant for each population and is stored in the `z_c_df` data frame along with the baseline passability value and  baseline carrying capacity coefficient of the population. We use cbind to add a column from the previously generated `p_hat_temp` dataframe with the baseline coefficient in order to use pmap across the coefficient and passability values.

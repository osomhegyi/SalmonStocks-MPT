### Summary
- This README summarizes the 2_nls.R script. The user will run all lines of code to generate results from the non-linear least squares regression analysis. 
 
#### Variables
- `coho_recruits`:   adult coho spawner abundance with coefficients 'recuits_flip' and 'abundance_flip' needed for nls analysis
- `calculate_equil_abundance`:  function to calculate equilibrium abundance 
- `all_nls`:  function to perform nonlinear least squares to find baseline productivity and carrying capacity coefficients 
- `equilibrium_all`:  dataframe that holds the output of all_nls function using coho_recuits data

#### Workflow
1. Run code lines 4 - 13. The dataframe `coho_recuits` contains the columns year, population, abundance, recruits, recuits_flip, and abundance_flip. The columns 'recuits_flip' and 'abundance_flip' are needed to calculate the baseline productivity and carrying capacity coefficients needed for the nls regression. We need recruits or the number of fish that are mature enough to leave to the ocean and return the following year. We use lead(abundance) and assume the amount of salmon that left to the ocean for a given year is equal to the amount that returned the year prior. 
2. Run code lines 16 - 22. `calculate_equil_abund` is used to calculate the abundance of salmon at equilibrium. The variables needed are salmon abundance, baseline productivity coefficient (p_hat), and baseline carrying capacity coefficient (c_hat). 
3. Run code lines 25 - 41. This `all_nls` function is used to run the nls regression model on the recruits and abundance values to estimate the baseline productivity and carrying capacity for each population in the ESU. To run nls we need to run a linear regression on the recruits_flip variables as a function of the abundance_flip variable and extract the intercept and coefficient values of that model. We then give nls guess vectors to train the model to generate a more accurate output. Lastly, we run the nls function on the recruits values as a function of the calculated equilibrium abundance using the desired dataframe, guess vectors, and the controls.
4. Run code lines 44 - 48. We then run the `all_nls` function on the 'coho_recuits' dataframe, mutate a column 'nls_model' to store the results of the nls model, and mutate another column 'coeff' to store the coefficients of the nls model. 


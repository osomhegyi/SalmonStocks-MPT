### Summary
This readme summarizes the 9_compute_portfolios.R script. The user will run all code lines to generate the final portfolio results. The code is set up to generate portfolios for 1 budget at a time, therefore the user must run their desired budget.

#### Variables
- `budget`: a vector of the overall conservation budget to be invested across the populations in the ESU.
- `cov_matrix`: covariance matrix of the coho annual population data. 
- `optimize_fcn`: function to calculate the portfolio abundance and variance before and after conservation investment.
- `portfolios`: dataframe containing the simulated portfolio results from the `optimize_fcn`.

#### Workflow
1. Run code lines 2, 3, or 4. Select the appropriate budget for the scenario you would like to run.
2. Run code lines 7 - 8. Create the covariance matrix of the coho abundance data.
3. Run code lines 12 - 54. The `optimize_fn` is used to simulate portfolio results. The optimize function brings many of the functions created in the previous steps, to simulate portfolio results. The function input is a list of weights, as created in the `7_weights.R` script. Within the function, the inputted list of weights is sequentially passed through the budget_allocated_fcn, the while_fcn, the bpassage_invest_fcn, the c_invest_fcn, and the p_invest_fcn to generate the ESU abundance before and after conservation investment. Matrix math is used to compute the ESU variance before and after conservation investment, using the covariance matrix `cov_matrix` from the original coho abundance data and the matrix of population portfolio abundance outputs, shown as s_baseline and s_invest.
4. Run code line 57. Generate portfolio results as a dataframe called `portfolios` using purr::map_df() to pass the list of portfolio weights into the `budget_allocated_fcn`. 

#### Moving Forward
If the user would like to apply this framework using an alternative conservation budget, they may input any defined conserved budget into code lines 2, 3, or 4. This alternative budget should be defined prior to running the `optimize_fcn`.

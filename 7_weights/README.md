### Summary
This readme summarizes the 7_weights.R  script. The user will run all code lines to generate randomly distributed weights allocated across the ESU. 

#### Variables
- `abundance_data`: dataframe that contains columns of each population's salmon abundance
`raw`: data frame that contains randomly distributed weights using the sampling function rdirichlet. each row is 1 portfolio with each column belonging to 1 population in the portfolio.
- `rounded`: data frame that contains randomly distributed weights that have been rounded to 2 decimal places using the sampling function rdirichlet. each row is 1 portfolio with each column belonging to 1 population in the portfolio.
- `diff`: data frame that contains the difference between the values of the raw and rounded weights. this was done to help ensure that all weight allocations summed to 1.
`final_check`: data frame that contains all portfolios where all randomly distributed weights sum to 1.00
- `weights`: renaming `final_check` and will be used as `weights` going forward
- `weights_list`: list of the weights data frame. A list is needed for the model to treat each row and column together as one portfolio 

#### Workflow
1. Run code lines 3 - 9. These lines of code generate portfolios the length of the coho abundance data. Here we use rdrichlet() that uses Dirichlet distribution to generate weights for each population. All populations are given an equal probability of receiving an allocation of the budget denoted by a value of 1.
2. Run code line 12. This line of code generates the weights used for the equity portfolios. Here all populations are given an equal chance of receiving a portion with the exception of populations Salmon, Siletz, and Yaquina who were given a higher probability of receiving a budget allocated. These three populations were given a value of 3 instead of a 1.
3. Run code lines 15 - 18. This code renames the columns of the `raw` data frame to the name of each population. We then round the weights generated to 2 decimal places. 
Run code lines 22 - 23. The data frame `diff` contains the difference of the raw weights and the rounded weights. Due to our weights being rounded we needed to still ensure that the weights still sum to 1. Because of this we include a Quality Control section in the code. The `diff` data frame takes the difference of the raw and rounded values for each portfolio generated and sum the weights together in a column named `sum`.
4. Run code lines 26 - 28. This for loop takes the sum of the weights from the `diff` data frame and adds that value to the highest weighted population. This will account for the difference in the rounded values. 
5. Run code lines 31 - 34. The data frame `final_check` contains all portfolios where all the weights given to each population sum to 1. Not all portfolios from the original `raw` data frame will be included. It is important to note that the total number of rows in the `final_check` data frame will be the amount of portfolios that will be used moving forward. This concludes the Quality Control section
6. Run code lines 39 - 44. The data frame `final_check` will be renamed to `weights` and will be referred to as `weights` in this project. The column names in this data frame are also changed to the population names. `weights_list` transforms the `weights` dataframe into a list. This will allow our model to iterate through each row and treat it as a portfolio.
7. Run code lines 49 - 52 to use the weights that have already been generated. This line of code will read in the data `all_weights.csv` and the `all_weights_ej.csv`. Both of these files contain the weights generated for the standard and equity portfolios. 
Run code line 55 to transform the weights dataframe into a list.

#### Moving Forward
If the user would like to generate different portfolio weights, they can use rdirichlet() in code line 9 to randomly generate a new set of weights. If the user would like to prioritize specific populations for equity, the user can adjust the vector code line 12 to upweight specific populations. If the user would like to change the number of portfolios to be generated, they can edit code line 3 by setting a specific value. If the user would like to subset the `weights` dataframe to look at fewer portfolios, they can run like 55 to create a subset of the dataframe.

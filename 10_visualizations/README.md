### Summary
This README summarizes the main purpose of the 10_visualization folder. The user will run all lines of code in each script to generate the final efficiency frontier plots for the three budgets of $23 million, $13.1 million, and $3.5 million. Included is bonus lollipop plot that the user may use to compare the budget allocated across the ESU.

### Workflow
`23_Million_budget.R`, `13.1_million_budget.R`, and `3.5_million_budget.R`

- To generate the plots in each script with the previously generated portfolios, the user must run the code lines to read in the portfolio data. If the user is running this analysis from scratch with newly generated weights then skip this step. Run the next lines of code to generate the efficiency frontier from the cloud of portfolio points. Lastly, run the ggplot code lines to generate the final plots for this analysis. 

`lollipop.R`

- To generate the lollipop plot the user may use the example portfolio provided at the top of script compare the budget allocated across the ESU or a specific portfolio they would like to explore. Run the next ggplot code lines to generate the plot. The lollipop plot will run as long as the data set used to generate it has two columns 'population' and 'budget_allocated'.  

### Summary
- This README summarizes the 6_compute_p_and_c_invest.R script. The user will run all code lines to generate the functions that will calculate the productivity and carrying capacity of each population in the ESU after investment. 

#### Variables
- `p_invest_fcn`: function to calculate impact on productivity after investment using the productivity z constant (z) and the new passability values after investment for each population (bpassage)
- `c_invest_fcn`: function to calculate impact on productivity after investment using the carrying capacity z constant (z) and the new passability values after investment for each population (bpassage)

#### Worflow
1. Run code lines 4 - 7. The function `p_invest_fcn` will calculate the new productivity coefficient after investment. Since passability of a population directly impacts the productivity of that  population we use the new passability values that are recalculated after we estimate the amount of barriers that can be removed determined by a budget allocated.
2. Run code lines 11 - 14. The function `c_invest_fcn` will calculate the new productivity coefficient after investment. Since passability of a population directly impacts the productivity of that  population we use the new passability values that are recalculated after we estimate the amount of barriers that can be removed determined by a budget allocated.

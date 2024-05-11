### Summary
- This README summarizes the 4_compute_passability.R script. The user will run all code lines to generate base passability values for each population in the ESU before conservation investment. Stream passability for pacific salmon is directly influenced by the number of barriers within a watershed and the location of said barriers within the watershed. Therefore, this function computes the passability for each population within the ESU using the identified steam level, stream ID, and passability of each individual barrier located within a given watershed.

#### Variables
- `bpassage_base_compute_fcn`: function to compute the base passability for each population in the ESU.
- `bpassage_base`: the output of the bpassage_base_combute_fcn that holds the passability values for each population prior to conservation investment.

#### Workflow
1. Run code lines 2 - 98. The `bpassage_base_compute_fcn` is used to compute the base passability value for each population in the ESU before conservation investment. The function input is a dataframe that includes the variables stream level, stream ID, and barrier passability value for each barrier within the watershed. The data is sorted sequentially by stream level, stream ID, and barrier passability. For each individual salmon population, the `bpassage_base_compute_fcn` function iterates across each stream level and across each stream ID within a stream level to determine the specific weight and passibility associated with each stream ID within a stream level. We expect barriers that are located closer to the mouth of a watershed to have greater influence on stream passability for pacific salmon, as opposed to barriers located higher up in the watershed. Therefore, to account for this in our calculation of stream passability, each barrier within a stream id and stream level receives a weight, based on the location of the barrier within the watershed.
2. Run code line 103. This results in a dataframe of the passability values for each population within the ESU. Using purrr::map_df(), we run the function `bpassage_base_compute_fcn` and input a list of dataframes.
3. Run code lines 106 - 111. The data frame `bpassage_base` is pivoted longer, for improved readability.




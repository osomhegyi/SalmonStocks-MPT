### Summary
- This README summarizes the 3_barrier_data.R script. The user will run all lines of code to generate population specific barrier data for the ESU.
 
#### Variables
- `alsea_barriers` -  dataframe that holds barrier specific data for the alsea population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost). 

- `beaver_barriers` - dataframe that holds barrier specific data for the beaver population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `coos_barriers` -  dataframe that holds barrier specific data for the coos population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `coquille_barriers` - dataframe that holds barrier specific data for the coquille population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `floras_barriers` - dataframe that holds barrier specific data for the floras population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `lower_umpqua_barriers` - dataframe that holds barrier specific data for the  lower umpqua population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `necanicum_barriers` - dataframe that holds barrier specific data for the necanicum population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `nehalem_barriers` - dataframe that holds barrier specific data for the nehalem population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `nestucca_barriers` - dataframe that holds barrier specific data for the nestucca population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `north_umpqua_barriers` - dataframe that holds barrier specific data for the north umpqua population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `salmon_barriers` - dataframe that holds barrier specific data for the salmon population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `siletz_barriers` - dataframe that holds barrier specific data for the siltez population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `siltcoos_barriers` - dataframe that holds barrier specific data for the sitcoos population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `siuslaw_barriers` - dataframe that holds barrier specific data for the siuslaw population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `sixes_barriers` - dataframe that holds barrier specific data for the sixes population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `south_umpqua_barriers` - dataframe that holds barrier specific data for the south umpqua population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `tenmile_barriers` - dataframe that holds barrier specific data for the tenmile population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `tillamook_barriers` - dataframe that holds barrier specific data for the tillamook population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `yaquina_barriers` - dataframe that holds barrier specific data for the yaquina population where every barrier has a specific barrier_id. Each barrier has information regarding its passability for salmon (pass_score), a stream specific id (strm_id), a specific stream level (strm_lev), and the cost to remove that barrier (cost).

- `barriers_list` - list that contains all 19 population barrier datasets 

#### Workflow
1. Run code lines 4 - 158. Each of these data frames are population specific barrier data generated from the GIS modelbuilder. Each dataframe contains ranked barriers based on the location and passability of each barrier. 
2. Run code lines 161 - 197. This results in a list with each population’s barrier data called `barriers_list`. This needs to be a list moving forward to allow for each iteration of our model to keep all populations together in one portfolio. 

#### Moving Forward
- If the user has obtained additional or updated barrier information, that data can be applied in this script before generating the `barriers_list` object.

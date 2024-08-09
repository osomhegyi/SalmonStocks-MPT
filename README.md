## Redesigning Modern Portfolio Theory to Improve Spatial Recovery Planning for Oregon Coast Coho Salmon

#### Description
The purpose of this repository is to present the code for the 2024 University of California, Santa Barbara Bren School of Environmental Science & Management Master’s Group Project: Redesigning Modern Portfolio Theory to Improve Spatial Recovery Planning for Oregon Coast Coho Salmon. More information on the project can be found on the [Bren School Group Project Page](https://bren.ucsb.edu/projects/redesigning-modern-portfolio-theory-improve-spatial-recovery-planning-oregon-coast-coho). The data needed to run this code can be downloaded from [DRYAD](https://doi.org/doi:10.5061/dryad.pvmcvdntm). To run this analysis the user will need to clone this repository to their local drive and download the data. The user will then need to add the 'data' folder to their cloned repository without changing any naming systems.

To start the user must run each folder and its contents in chronological order starting with folder `01_abundance`.

*Contributors*

Alicia Canales: Data Manager
Bren School of Environmental Science & Management
University of California, Santa Barbara
aliciacanales@bren.ucsb.edu

Olivia Somhegyi: Co-Project Manager
Bren School of Environmental Science & Management
University of California, Santa Barbara
oliviasomhegyi@bren.ucsb.edu

Jaden Husser: Communications Manager
Bren School of Environmental Science & Management
University of California, Santa Barbara
jadenhusser@bren.ucsb.edu

Stephanie Luu: Co-Project Manager, Financial Manager
Bren School of Environmental Science & Management
University of California, Santa Barbara
s_luu@bren.ucsb.edu

### Folder Directory
`01_abundance` - code for reading in Oregon Coast coho salmon data. The resulting data frame `coho` contains annual abundance from 1994 - 2019 and will be used throughout this project. 

`02_nls` - code for running non linear least square regression on the coho abundance data. The resulting data frame `equilibrium_all` contains the results of the nls regression for each population and will be used to estimate improved productivity and carrying capacity coefficients.

`03_barriers` - code for reading in population specific barrier output data from GIS modelbuilder. The resulting list `barriers_data` contains barrier data for each population in the ESU and will be used to calculate the passability of the ESU.   

`04_compute_passability` - code for the passability function that generates baseline passability for each population in the ESU. The resulting data frame `bpassage_base` will be used to calculate the baseline productivity and carrying capacity coefficients for each population. 

`05_compute_z_constant` - code for generating the z constant for both the productivity and carrying capacity equations. The resulting data frames `z_p_df` and `z_c_df` each contain the z constant for their respective impact on abundance equations.

`06_compute_p_and_c_invest` - code for the functions `p_invest_fcn` and `c_invest_fcn` to calculate improved productivity and carrying capacity coefficients after investment.

`07_weights` - code for generating a random distribution of weights that will be given to each population for multiple portfolios. The resulting list `weights_list` contains weights distributed to each population for every portfolio and will be used to determine each population’s budget allocation.

`08_compute_improved_passability` - code to calculate improved passability values for each population in a portfolio based on the amount of budget allocated, the cost to remove a barrier, and the prioritization of barriers to remove. The prioritization of barriers are ranked by stream level, stream ID, and its passability value.

`09_compute_portfolios` - code to run the optimize function to compute many portfolios using the functions generated from the above scripts. The resulting data frame named `portfolios` contains the total returns and total variance of the ESU after investment for every portfolio generated.  

`10_visualizations` - code to generate the efficiency frontier plots for each budget ($23 Million, $13.1 Million, and $3.5 Million) and lollipop plot to further analyze budget allocations within a portfolio. 

#..........................Create randomized weight allocations for standard and equity portfolios.........................

n = 60000

# raw population abundance data
abundance_data <- coho[2:20]

# Generate portfolio weights for all populations. here all populations have an equal chance of receiving a portion of the budget
raw <- rdirichlet(n,rep(1,ncol(abundance_data))) 

# Generate equity portfolio weights for all populations. here all populations have a chance of receiving a portion of the budget, however the populations who were allocated a 3 have 3x the probability of receiving a budget allocation 
# raw <- rdirichlet(n,c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 1, 1, 1, 1, 1, 3))

# naming the columns with the population names
colnames(raw) <- names(abundance_data) 

# round to two decimals
rounded<-round(raw,2) 


#...........QC: ensure we are only using weights that add up to 1...............
diff<-as.data.frame(raw - rounded) %>% # Take the difference at each element
  mutate(sum=rowSums(across(everything()))) # Sum across rows

# for loop to add the sum to highest weighted stream
for(i in 1:nrow(abundance_data)){
  rounded[i,which.max(rounded[i,])]<-rounded[i,which.max(rounded[i,])]+diff$sum[i]
}

# Check to make sure weights still add up to 1 for rounded dataframe
final_check <- as.data.frame(rounded) %>% 
  mutate(sum = rowSums(across(everything()))) %>% 
  filter(sum == 1.00) %>% ## filter for only portfolios that sum to 1
  select(-sum)
#............................End of QC..........................................


# Making the final_check df into the weights that will be used going forward
weights <- final_check

# Renaming column names 
colnames(weights) <- names(abundance_data) 

weights_list <- split(weights,seq(nrow(weights)))


#..........................To use our previously simulated weights..............
# dataframe that contains all weights generated for standard portfolios
weights <- read.csv(here('data', 'standard_weights', 'all_weights.csv')) 

# dataframe that contains all weights generated for equity portfolios
equity_weights <- read.csv(here('data', 'ej_weights', 'all_weights_ej.csv'))

# subset weights dataframe for `x` rows
# weights_subset <- weights[2, ]

# turning the weights or equity_weights into a list
weights_list <- split(weights,seq(nrow(weights)))

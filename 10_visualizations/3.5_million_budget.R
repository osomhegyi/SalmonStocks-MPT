#.......................Visualization for $3.5 Million...........................
# baseline portfolio abundance and variance
baseline_point <- data.frame(x = 1.95539e+18, y = 186948.6)

# reading in data for $3.5 million budget
portfolios_3.5_1 <- read_csv(here('data', 'output','portfolios','3.5_million', 'standard_portfolios','portfolios_3.5_1_map.csv'))
portfolios_3.5_2 <- read_csv(here('data', 'output', 'portfolios', '3.5_million', 'standard_portfolios','portfolios_3.5_2_map.csv'))
portfolios_3.5_3 <- read_csv(here('data', 'output', 'portfolios', '3.5_million', 'standard_portfolios','portfolios_3.5_3_map.csv'))
portfolios_3.5_4 <- read_csv(here('data', 'output', 'portfolios', '3.5_million', 'standard_portfolios','portfolios_3.5_4_map.csv'))
portfolios_3.5_5 <- read_csv(here('data', 'output', 'portfolios', '3.5_million', 'standard_portfolios','portfolios_3.5_5_map.csv'))
portfolios_3.5_6 <- read_csv(here('data', 'output', 'portfolios', '3.5_million', 'standard_portfolios','portfolios_3.5_6.1_map.csv'))

# all portfolios for the $3.5 million budget in one data frame
combined_3.5 <- rbind(portfolios_3.5_1,
                      portfolios_3.5_2,
                      portfolios_3.5_3,
                      portfolios_3.5_4,
                      portfolios_3.5_5,
                      portfolios_3.5_6) 

# giving each portfolio a name 
combined_3.5 <- combined_3.5 %>% 
  mutate('portfolio' = paste("portfolio", 1:nrow(combined_3.5), sep = " "),
         'Budget' = '$3.5 million')

# removing outliers 
combined_3.5 <- combined_3.5[-c(1:7), ]

# generating the efficiency frontier using cummax again without the outliers
eff_front_3.5<- combined_3.5 %>% 
  arrange(esu_var_invest) %>% 
  subset(esu_returns_invest==cummax(esu_returns_invest))

# reading in the ej portfolios with the subsetted weights 5 and can be added to plot_13
ej_portfolios_3.5 <- read_csv(here('data', 'output', 'portfolios', '3.5_million', 'equity_portfolios','portfolios_3.5_5_ej_map.csv'))

# standard plot for $3.5 Million
plot_3.5 <- ggplot(combined_3.5, aes(x = esu_var_invest, y = esu_returns_invest)) +
  geom_point(colour = 'gray', size = 2, alpha = 1/10) +
  geom_line(data = eff_front_3.5, aes(x = esu_var_invest, y = esu_returns_invest), color = '#ff6b65ff', size = 1.2) +
  geom_point(data = baseline_point, aes(x, y), color = "black", size = 3) +
  geom_segment(aes(x = 1.96e+18,
                   y = 186950,
                   xend = 1.956e+18,
                   yend = 186950),
               color = "black",
               linetype = "solid",
               arrow = arrow(length = unit(0.3, "cm"))) +
  geom_text(x = 1.964e+18, y = 186950, label = "Baseline Portfolio", size = 5, check_overlap = T, color = 'black') +
  labs(x = 'ESU Variance', y = 'ESU Abundance') +
  xlim(1.954e+18, 1.99e+18) + 
  scale_y_continuous(limits = c(186500, 189000), labels = scales::comma) +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 15),
        axis.title = element_text(size = 15))
plot_3.5

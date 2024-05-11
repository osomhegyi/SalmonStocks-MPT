#.......................Visualization for $13.1 Million...........................
# baseline portfolio abundance and variance
baseline_point <- data.frame(x = 1.95539e+18, y = 186948.6)

# reading in data for $13.1 million
portfolios_13_1 <- read_csv(here('data', 'output', 'portfolios', '13.1_million', 'standard_portfolios','portfolios_13.1_1_map.csv'))
portfolios_13_2 <- read_csv(here('data', 'output', 'portfolios', '13.1_million', 'standard_portfolios', 'portfolios_13.1_2_map.csv'))
portfolios_13_3 <- read_csv(here('data', 'output', 'portfolios', '13.1_million', 'standard_portfolios', 'portfolios_13.1_3_map.csv'))
portfolios_13_4 <- read_csv(here('data', 'output', 'portfolios', '13.1_million', 'standard_portfolios', 'portfolios_13.1_4_map.csv'))
portfolios_13_5 <- read_csv(here('data', 'output', 'portfolios', '13.1_million', 'standard_portfolios', 'portfolios_13.1_5_map.csv'))
portfolios_13_6 <- read_csv(here('data', 'output', 'portfolios', '13.1_million', 'standard_portfolios', 'portfolios_13.1_6.1_map.csv'))

# all portfolios for the $13.1 million budget in one data frame
combined_13 <- rbind(portfolios_13_1,
                     portfolios_13_2,
                     portfolios_13_3,
                     portfolios_13_4,
                     portfolios_13_5,
                     portfolios_13_6) 

# giving each portfolio a name 
combined_13 <- combined_13 %>% 
  mutate('portfolio' = paste("portfolio", 1:nrow(combined_23), sep = " "),
         'Budget' = '$13 million')

# generating the efficiency frontier using cummax
eff_front_13 <-combined_13 %>% 
  arrange(esu_var_invest) %>% 
  subset(esu_returns_invest==cummax(esu_returns_invest))

# reading in the ej portfolios with the subsetted weights 5 and can be added to plot_13
ej_portfolios_13_5 <- read_csv(here('data', 'output','portfolios', '13.1_million', 'equity_portfolios','portfolios_13.1_5_ej_map.csv'))

# Standard plot for $13.1 Million
plot_13 <- ggplot(combined_13, aes(x = esu_var_invest, y = esu_returns_invest)) +
  geom_point(colour = 'gray', size = 2, alpha = .5) +
  geom_line(data = eff_front_13, aes(x = esu_var_invest, y = esu_returns_invest), color = '#ff6b65ff', size = 1.2) +
  geom_point(data = baseline_point, aes(x, y), color = "black", size = 1.5) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = c('', '5.0e+19', '1.0e+20', '1.5e+20')) +
  geom_segment(aes(x = 1.58e+19,
                   y = 187118.2,
                   xend = 4.1e+18,
                   yend = 187118.2),
               color = "black",
               linetype = "solid",
               arrow = arrow(length = unit(0.3, "cm"))) +
  geom_text(x = 3e+19, y = 187118.2, label = "Baseline Portfolio", size = 5, check_overlap = T, color = 'black') +
  labs(x = 'ESU Variance', y = 'ESU Abundance') +
  theme_minimal()+
  theme(axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 15),
        axis.title = element_text(size = 15))
plot_13

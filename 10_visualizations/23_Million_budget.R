#.......................Visualization for $23 Million...........................
## baseline portfolio abundance and variance
baseline_point <- data.frame(x = 1.95539e+18, y = 186948.6)

# Reading in data for $23 million budget
portfolios_23_1 <- read_csv(here('data', 'output', 'portfolios', '23_million', 'standard_portfolios','portfolios_23_1_map.csv')) 
portfolios_23_2 <- read_csv(here('data', 'output', 'portfolios', '23_million', 'standard_portfolios', 'portfolio_2_23.csv'))
portfolios_23_3 <- read_csv(here('data', 'output', 'portfolios', '23_million', 'standard_portfolios', 'portfolios_23_3_map.csv')) 
portfolios_23_4 <- read_csv(here('data', 'output', 'portfolios', '23_million', 'standard_portfolios', 'portfolios_23_4_map.csv'))
portfolios_23_5 <- read_csv(here('data', 'output', 'portfolios', '23_million', 'standard_portfolios', 'portfolios_23_5_map.csv')) 
portfolios_23_6 <- read_csv(here('data', 'output', 'portfolios', '23_million', 'standard_portfolios', 'portfolios_23_6.1_map.csv'))

# all portfolios for the $23 million budget in one data frame
combined_23 <- rbind(portfolios_23_1,
                     portfolios_23_2,
                     portfolios_23_3,
                     portfolios_23_4,
                     portfolios_23_5,
                     portfolios_23_6)

# giving each portfolio a name 
combined_23 <- combined_23 %>%
  mutate('portfolio' = paste("portfolio", 1:nrow(combined_23), sep = " "),
         'Budget' = '$23 million')

# generating the efficiency frontier using cummax
eff_front_23 <-combined_23 %>% 
  arrange(esu_var_invest) %>% 
  subset(esu_returns_invest==cummax(esu_returns_invest)) 

# reading in the ej portfolios with the subsetted weights 5
ej_portfolios_23_5 <- read_csv(here('data', 'output','portfolios', '23_million', 'equity_portfolios','portfolios_23_5_ej_map.csv'))

# standard plot for $23 million budget
plot_23 <- ggplot(combined_23, aes(x = esu_var_invest, y = esu_returns_invest)) +
  geom_point(colour = 'gray', size = 2, alpha = .5) +
  geom_line(data = eff_front_23, aes(x = esu_var_invest, y = esu_returns_invest), color = '#ff6b65ff', size = 1.2) + ## salmon pink
  geom_point(data = baseline_point, aes(x, y), color = "black", size = 1.5) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = c('', '5.0e+19', '1.0e+20', '1.5e+20', '2.0e+20')) +
  geom_segment(aes(x = 2e+19,
                   y = 187118.2,
                   xend = 5e+18,
                   yend = 187118.2),
               color = "black",
               linetype = "solid",
               arrow = arrow(length = unit(0.3, "cm"))) +
  geom_text(x = 4e+19, y = 187118.2, label = "Baseline Portfolio", size = 5, check_overlap = T, color = 'black') +
  labs(x = 'ESU Variance', y = 'ESU Abundance') +
  theme(legend.position = "none") +
  theme_minimal() +
  theme(text=element_text(family="sans")) +
  theme(axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 15),
        axis.title = element_text(size = 15))
plot_23

#...............Visualization for $23 Million w Equity Portfolios...............
colors <- c('Standard Portfolios' = 'gray', 'Equity Portfolios' = '#1F3D0C')
equity_plot_23 <- ggplot() +
  geom_point(data = combined_23, aes(x = esu_var_invest, y = esu_returns_invest, color = 'Standard Portfolios'), size = 2, alpha = .5) +
  geom_line(data = eff_front_23, aes(x = esu_var_invest, y = esu_returns_invest), color = '#ff6b65ff', size = 1.2) +
  geom_point(data = ej_portfolios_23_5, aes(x = esu_var_invest, y = esu_returns_invest, color = 'Equity Portfolios'), alpha = .5) +
  geom_point(data = baseline_point, aes(x, y), color = "black", size = 1.5) +
  scale_color_manual(values = colors) +
  scale_x_continuous(labels = c('', '5.0e+19', '1.0e+20', '1.5e+20', '2.0e+20')) +
  scale_y_continuous(labels = scales::comma) +
  geom_segment(aes(x = 2e+19,
                   y = 187118.2,
                   xend = 4.1e+18,
                   yend = 187118.2),
               color = "black",
               linetype = "solid",
               arrow = arrow(length = unit(0.3, "cm"))) +
  labs(x = 'ESU Variance', y = 'ESU Abundance') +
  annotate("text", x = 4.2e+19, y = 187118.2, label = "Baseline Portfolio", size = 5, color = 'black')+
  theme_minimal() +
  guides(color = guide_legend(override.aes = list(size = 2.5))) +
  theme(legend.title = element_blank()) +
  theme(text = element_text(family="sans"),
        legend.position = c(.78, .24),
        title = element_text(size = 13),
        legend.text = element_text(size = 15),
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 15),
        axis.title = element_text(size = 15))
equity_plot_23

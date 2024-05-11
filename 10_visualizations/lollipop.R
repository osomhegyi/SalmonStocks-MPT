#...............................Lollipop Plot..................................

# data wrangling for 1 example portfolio's budget allocated
weights <- read.csv(here('data', 'output','weights','standard_weights', 'all_weights.csv')) 

# made weights into list for function
weights_list <- list(weights[1,])

# bringing in bpassage_base just because it readily has all populations nicely formatted
portfolio_1 <- bpassage_base %>% 
  select(population) %>% 
  mutate(budget_allocated = budget_allocated_fcn(23000000, weights_list)) # using a budget of $23 million using the first row of weights

# lollipop plot
portfolio_1 %>% 
  ggplot(aes(x = fct_reorder(population, budget_allocated), #fct_reorder lets us set the order of the first value, by the second value ($ invested)
             y = budget_allocated)) +
  ggalt::geom_lollipop() +
  ggtitle("Portfolio 1") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_y_continuous(labels = function(x) paste0('$',x / 1000000, "M")) +
  labs(y = 'Budget Allocated') +
  xlab(NULL) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title = element_text(size = 15)) +
  theme(plot.subtitle = element_text(hjust = 0.5)) +
  theme(axis.text.x = element_text(size = 13),
        axis.text.y = element_text(size = 12.5)) +
  coord_flip()


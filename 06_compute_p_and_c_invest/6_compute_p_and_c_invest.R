#..........................calculate 'p_invest' and 'c_invest' using 'bpassage' after investment.........................

## function to calculate impact on productivity after investment
p_invest_fcn <- function(z,bpassage){
  p_invest = z * bpassage ## bpassage contains passability of each population after investment 
  return(p_invest)
}


## function to calculate impact on capacity after investment
c_invest_fcn <- function(z,bpassage){
  c_invest = z * bpassage ## bpassage contains passability of each population after investment
  return(c_invest)
}

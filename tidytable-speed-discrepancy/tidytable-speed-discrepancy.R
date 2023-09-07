library(tidytable)
library(data.table)

bench::mark(
  tidytable = {
    iris_tt <- tidytable(iris) %>% 
      mutate(species_avg = sum(Petal.Length),
             .by = Species) %>% 
      mutate(individual_ratio = Petal.Width / species_avg) %>% 
      select(individual_ratio, Species)
  },
  datatable = {
    iris_dt <- data.table(iris)
    
    iris_dt[, species_avg := sum(Petal.Length), by = Species]
    iris_dt[, `:=`(individual_ratio = Petal.Width / species_avg)]
    iris_dt[,.(individual_ratio, Species)]
  },
  check = F
)

cars <- tbl_df(mtcars)

t1 <- cars %>% 
  mutate(cyl = factor(cyl))

contrasts(t1$cyl) <- contr.sum

# https://stackoverflow.com/questions/45140783/how-to-transform-a-string-into-a-factor-and-sets-contrasts-using-dplyr-magrittr
t2 <- cars %>% 
  mutate(cyl = factor(cyl)) %>% 
  do({function(X) {contrasts(X$cyl) <- contr.sum; return(X)}}(.))

# alternatively, this is less typing but I don't know what's going on in arguments
# x, value, contrast coding. beats me why ok to leave value blank
t3 <- cars %>% 
  mutate(cyl = `contrasts<-`(factor(cyl), , contr.sum))

lm(mpg ~ cyl, data = t1) %>% summary

lm(mpg ~ factor(cyl), data = mtcars) %>% summary

mtcars %>% 
  mutate(cyl = factor(cyl)) %>% 
  lm(mpg ~ cyl, data = ., contrasts = list(cyl = contr.sum)) %>% 
  summary

mtcars %>% 
  mutate(cyl = factor(cyl)) %>% 
  lm(mpg ~ cyl, data = ., contrasts = list(cyl = contr.sum)) %>% 
  summary

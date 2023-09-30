---
title: "Project #1: Part #2"
author: "Magret Adekunle"
date: "`r Sys.Date()`"
output: pdf_document
urlcolor: blue
---
<!-- The author of this template is Dr. Gordan Zitkovic.-->
<!-- The code chunk below contains some settings that will  -->
<!-- make your R code look better in the output pdf file.  -->
<!-- If you are curious about what each option below does, -->
<!-- go to https://yihui.org/knitr/options/ -->
<!-- If not, feel free to disregard everything ...  -->
```{r echo=FALSE, warning=FALSE, include=FALSE}
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.align="center",
  fig.pos="t",
  strip.white = TRUE
)
```
<!-- ... down to here. -->

---

Before embarking on this project, go to [Wikipedia: the Monty Hall problem](https://en.wikipedia.org/wiki/Monty_Hall_problem). This Wikipedia entry contains the description of the original Monty Hall problem as well as its analysis and variations. 

---

## PART I
Code represent **one round** of the original Monty Hall game. More precisely,the code:

- "choose" at random behind which door the prize will be,

- "choose" at random the door that the contestant picks,

- choose which door the host will open,

- determine whether it was optimal to **switch** or **stick** for this particular round and return this determination. 

# *Solution*
``` {r}

round = function() {
  prize_door = sample(1:3, 1)
  contestant_first_pick = sample(1:3, 1)
  door_to_open = setdiff(1:3, c(contestant_first_pick, prize_door))
  # choose a door to open if multiple options
  if (length(door_to_open) > 1) {
    door_to_open = sample(door_to_open, 1)
  }
  switched_door = setdiff(1:3, c(contestant_first_pick, door_to_open))
  if (prize_door == contestant_first_pick) {
    return ("stick")
  } 
  if (prize_door == switched_door) {
    return ("switch")
  }
}
```


## PART II
Code repeats 100 rounds of the Monty Hall game. For which proportion of these rounds was it optimal to **switch**?

# *Solution*
```{r}
nRounds = function(n) {
optimalCount = 0
for (x in 1:n) {
  # print(paste("Round", x))
  decision = round()
  if(decision == "switch") {
    optimalCount <- optimalCount + 1
  }
}
return (optimalCount / n)
}

proportion = nRounds(100) * 100
print(paste("It was optiomal to switch for ", proportion, "% of rounds"))
```

## PART III
Code  repeats $n$ rounds of the Monty Hall game for $n=100, 110, 120, ..., 10000$. For each $n$, the code records the proportion of individual rounds for which it was optimal to **switch**. 

Code will also plot this recorded proportion as a function of $n$. 

# *Solution*
```{r}
library(ggplot2)

x <- c()
y <- c()

for (i in seq(100, 10000, by = 10)) {
  switchOptimal = nRounds(i)
  x <- c(x, i)
  y <- c(y, switchOptimal)
}

# Plot optimalCountList
  
# Create dataframe
df <- data.frame(x = x, y = y)

# Create plot
p<-ggplot(df, aes(x = x, y = y)) + 
    geom_point(size = 3) + ylim(0,1) +
    labs(x = "Round", y = "Switch", title = "Plot of Optimal Rounds")
 
# Display plot
print(p)
```

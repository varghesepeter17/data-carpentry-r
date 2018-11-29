# Plotting

library(tidyverse)

interview_plot <- ggplot(data=interviews_plotting,aes(x=no_membrs, y=number_items))+
  geom_point()

# or

interview_plot <- ggplot(data=interviews_plotting,aes(x=no_membrs, y=number_items))
interview_plot+ geom_point(alpha=0.5)

## grey points on top of each otehr makes the color black. So jitter is used

interview_plot+ geom_jitter(alpha=0.5)

interview_plot+ geom_jitter(alpha=0.5, color = 'blue')

interview_plot+ geom_jitter(aes(color=village), alpha=0.5)

ggplot(data=interviews_plotting, aes(x=village, y=rooms))+
  geom_jitter(aes(color=respondent_wall_type))

ggplot(data=interviews_plotting, aes(x=respondent_wall_type, y=rooms))+
  geom_boxplot(alpha=0)+
  geom_jitter(alpha=0.5, color='tomato')



install.packages("tidyverse")
library(tidyverse)
install.packages("plotly")
library(plotly)

# View of table
View(titanic_data_cleaned)
# Structure of Table
str(titanic_data_cleaned)

#Bar plot for survived passengers
ggplot(titanic_data_cleaned, aes(x = as.factor(survived))) +
  geom_bar(width = 0.5,fill = 'Yellow') +
  xlab("Survived") +
  ylab("Count") +
  geom_text(stat='count', aes(label=stat(count)))+
  ggtitle("Count of Survived Passengers")

#Bar plot for count of  Survived passengers
ggplot(titanic_data_cleaned, aes(x = survived)) +
  geom_bar(width=0.5, fill = "coral") +
  geom_text(stat='count', aes(label=stat(count)), vjust=-0.5) +
  ggtitle("Count of Survived Passengers")
   theme_classic()

#Bar plot for Survived passengers by gender.
ggplot(titanic_data_cleaned, aes(x = survived, fill=sex)) +
  geom_bar(position = position_dodge()) +
  geom_text(stat='count', 
            aes(label=stat(count)), 
            position = position_dodge(width=1), vjust=-0.5)+
  ggtitle("Count of Survived Passengers by gendre")
  theme_classic()
  
  
#Bar plot for passenger survival by class
ggplot(titanic_data_cleaned, aes(x = survived, fill=pclass)) +
  geom_bar(position = position_dodge()) +
  geom_text(stat='count', 
            aes(label=stat(count)), 
            position = position_dodge(width=1), 
            vjust=-0.5)+
  ggtitle("Passenger survival by class")
  theme_classic()

  #Bar plot for count of passengers by class
ggplot(titanic_data_cleaned, aes(x = pclass)) +
  geom_bar(fill = 'blue',position = position_dodge()) +
  geom_text(stat='count', 
            aes(label=stat(count)), 
           fill='blue', position = position_dodge(width=1), 
            vjust=-0.5)+
  ggtitle("Count of Passengers by Class")

#Scatter plot for passengers via Age vs fare by class status
ggplot(titanic_data_cleaned, aes(x = age, y = fare)) +
  geom_point(color = 'orange') +
  facet_grid(. ~ pclass) +
  xlab("Age") +
  ylab("Fare") +
  ggtitle("Age vs. Fare by class Status")

#Age vs Fare by Pclass
ggplot(titanic_data_cleaned, aes(x = age, y = fare, color = as.factor(pclass))) +
  geom_point(size = 2) +
  scale_color_manual(values = c("1" = "red", "2" = "orange", "3" = "green")) +
  xlab("Age") +
  ylab("Fare") +
  ggtitle("Age vs. Fare by Passenger Class") +
  labs(color = "Passenger Class")


#stacked bar plot of survival by passenger class
ggplot(titanic_data_cleaned, aes(x = pclass, fill =survived)) +
  geom_bar(position = "fill") +
  xlab("Passenger Class") +
  ylab("Proportion") +
  labs(fill = "Survived") +
  ggtitle("Survival Proportions by Passenger Class")

# Create a scatter plot of Age vs. Fare coloured by Embarkation
ggplot_scatter <- ggplot(titanic_data_cleaned, aes(x = age, y = fare, color = embarked)) +
  geom_point() +
  xlab("Age") +
  ylab("Fare") +
  ggtitle("Scatter Plot of Age vs. Fare by Embarkation") +
  theme_classic()

#Density plot for age
ggplot(titanic_data_cleaned, aes(x = age)) +
  geom_density(fill='coral')
ggtitle("Density Plot for Age")


# Calculate counts and percentages for interactive plot
titanic_summary <- titanic_data_cleaned %>%
  group_by(pclass, survived) %>%
  summarise(count = n()) %>%
  mutate(percentage = count / sum(count) * 100, 
         survival_status = ifelse(survived == 1, "Survived", "Did Not Survive"))

# Convert to data frame
titanic_summary <- as.data.frame(titanic_summary)

# Create the interactive stacked bar plot
plot <- plot_ly(titanic_summary, 
                x = ~pclass, 
                y = ~percentage, 
                type = 'bar', 
                color = ~as.factor(survived),
                text = ~paste('Status:', survival_status, '<br>Percentage:', round(percentage, 2), '%'),
                hoverinfo = 'text',
                textposition = 'auto') %>%
  layout(barmode = 'stack',
         xaxis = list(title = 'Passenger Class'),
         yaxis = list(title = 'Percentage'),
         title = 'Survival Proportions by Passenger Class',
         legend = list(title = list(text = 'Survival Status')))

plot

# Filter the dataframe for passengers who embarked at Southampton
southampton_data <- titanic_data_cleaned %>%
  filter(embarked == "S")

#scatter plot for passengers by Age, fare, survival rate and place of Embarkment
ggplot(titanic_data_cleaned, aes(x = age, y = fare, color = (survived))) +
  geom_point(size = 1) +
  scale_color_manual(values = c("0" = "red", "1" = "green"), labels = c("0" = "No", "1" = "Yes")) +
  facet_grid(survived ~ embarked) +
  xlab("Age") +
  ylab("Fare") +
  ggtitle("Age vs. Fare by Survival Status and Embarked") +
  labs(color = "Survived")

#Survival rate by age histogram chart
  ggplot(titanic_data_cleaned, aes(x = age, fill = survived)) +
  geom_histogram() +
    ggtitle("survival rate by age chart")
  theme_classic() 
  
  #box plot for age distribution by survival status
  ggplot(titanic_data_cleaned, aes(x = survived, y = age)) +
    geom_boxplot() +
    xlab("Survived") +
    ylab("Age") +
    ggtitle("Age Distribution by Survival Status")
  theme_classic()

  #Bar chart for survival count by gender and class
  ggplot(titanic_data_cleaned, aes(x= sex, fill = survived))+
  geom_bar(width = 0.4 )+
    facet_wrap(~ pclass)+
    labs(title = "Survival rates Sex and Passenger class", x = NULL, y = "Passenger Count")
  theme_test()
  
  #Scatter plot by Age,fare and Embarked
  ggplot(titanic_data_cleaned, aes (x = age, y = fare, color= embarked))+
    geom_point()+
    geom_smooth(method = "lm", col = "blue")
  facet_grid(. ~ embarked)+
    xlab("age")+
    ylab("fare")+
    ggtitle("age and fare by embarkation")

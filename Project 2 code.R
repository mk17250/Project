# MA317 Group Project # 
Data_0 <- read.csv("C:/Users/Home/OneDrive/practical_w3/LifeExpectancyData1 .csv", header=TRUE)
Data1 
class(Data1)

install.packages("DataExplorer")
library(DataExplorer)
require(DataExplorer)
library(dsEssex)
require(dsEssex)
require(dplyr)  
require(tidyverse)
library(caTools)  
require(caTools) 
library(ISLR)
require(ISLR)
library(ggplot2)
require(ggplot2)
library(corrr)
library(cluster)


# Data Analysis # 

summary(Data1)
complete.cases(Data1)
Data1[Data1 == "NA"] = NA

# change factors to numbers in Data1 # 

for(i in 3:ncol(Data1)){
  Data1[,i] = as.numeric(Data1[,i])
}
sort(colSums(is.na(Data1)), decreasing = TRUE)
sort(round(colSums(is.na(Data1)/nrow(Data1)*100), digits = 1), decreasing = TRUE)
sort(round(colSums(is.na(Data1)/nrow(Data1)*100), digits = 1), decreasing = TRUE)
sort(colSums(is.na(Data1)), decreasing = TRUE)
sort(round(colSums(is.na(Data1)/nrow(Data1)*100), digits = 1), decreasing = TRUE)
Data_i = Data1


summary(Data1)
complete.cases(Data1)
Data1
table(Data1)

# sorting and splitting the data # 
Data2 <- Data1 %>%
  arrange(Data1$SP.DYN.LE00.IN)
summary(Data2)
str(Data2)
plot_str(Data2)
plot_missing(Data2)
plot_correlation(Data2, type = "continuous")

?plot_correlation

Data3 <- data.frame(Data2$Country.Name, Data2$SP.DYN.LE00.IN, Data2$NY.GDP.PCAP.PP.CD, Data2$NY.GDP.MKTP.KD.ZG, Data2$EG.ELC.ACCS.ZS, Data2$SP.POP.GROW, Data2$SP.POP.TOTL, Data2$SH.XPD.CHEX.GD.ZS, Data2$SH.XPD.CHEX.PC.CD)
colnames(Data3) <- c("Country_Name", "Average_Life_Expectancy", "GDP_Per_Capita", "GDP_Anual_Growth", "Pop_Access_To_Elec", "Anual_Pop_Growth", "Country_Pop_Total", "Health_Spend_GDP", "Health_Spend_Per_Capita" )
summary(Data3$`GDP Per Capita %`)
tidyr::complete(Data3)
summary (Data3)

# Analysis based off of the correlation table direction # 
# Analyses data by Income Per Cap # 
kmeans(Data3$`GDP_Per_Capita`, 3, 3)
set.seed(1)
kmeans(Data3$`GDP_Per_Capita`, centers = 3, nstart = 25)
                   
# k means results used to split # 
low_income <- Data3[ which(Data3$GDP_Per_Capita <=16000), ]
med_income <- Data3[ which(Data3$GDP_Per_Capita > 16000 & Data3$GDP_Per_Capita <=45000), ]
high_income <- Data3[ which(Data3$GDP_Per_Capita > 45000), ]
summary(low_income)
summary(med_income)
summary(high_income)

# Looking at the summary of the information, income per capita does have a correlation with life expectancy #
# The average (median age) increases significantly between the 3 groups # 
# Low income median is 69.85 / med income is 76.07 / high income is 81.65 #  

# Analysis of health spend per capita # 
kmeans(Data3$Health_Spend_Per_Capita, 3, 3)
set.seed(1)
kmeans(Data3$Health_Spend_Per_Capita, centers = 3, nstart = 25)

# K means results used to split #
low_spend <- Data3[ which(Data3$Health_Spend_Per_Capita < 3500), ]
med_spend <- Data3[ which(Data3$Health_Spend_Per_Capita > 3500 & Data3$Health_Spend_Per_Capita < 6500), ]
high_spend <- Data3[which(Data3$Health_Spend_Per_Capita > 6500), ]
summary(low_spend)
summary(med_spend)
summary(high_spend)

# Analysis shows that spend on health car per capita also has a correlation with life expectancy # 
# Countries that spend more have a life expectancy average of more than 10 years higher than those of low spend countries # 
# Low spend median = 72.78 years / Med spend = 81.77 / High spend  = 82.76 # 

# Analysis of 
kmeans(Data3$Pop_Access_To_Elec, 3, 3)
set.seed(1)
kmeans(Data3$Pop_Access_To_Elec, centers = 3, nstart = 25)

# K means results used to split #
low_access <- Data3[ which(Data3$Pop_Access_To_Elec < 20), ]
med_access <- Data3[ which(Data3$Pop_Access_To_Elec > 20 & Data3$Pop_Access_To_Elec < 60), ]
high_access <- Data3[which(Data3$Pop_Access_To_Elec > 60), ]
summary(low_access)
summary(med_access)
summary(high_access)

# Analysis of the summary again shows that electricity access has an impact on the life expectancy #
# So far the analysis shows that length of life is higher in developed, wealthier countries with good access to utilities and health care #
# Low access life expectancy = 61.21 years / mid = 62.97 (63) years / good access = 75.25 years



# Garaph's #
# Interactive Plot for Country and Average Life Expectancy # 
a <- ggplot(Data3) +
  aes(x= reorder(Country_Name, -Average_Life_Expectancy), y=Average_Life_Expectancy) +  
  geom_point(colour = "#0c4c8a") +
  labs(title = "Average Life Expectancy By Country",
       x = "Country",
       y = "Average Life Expectancy In Years") +
  expand_limits(y = c(45, 90))+
  theme(axis.text.x = element_blank())  
  ggplotly(a)

# graph 2 # 
b <- ggplot(Data3) +
  aes(x=Country_Name, y=GDP_Per_Capita) +  
  geom_point(colour = "#0c4c8a") +
  labs(title = "Average Income Per Capita By Country",
      x = "Country",
      y = "Average Income Per Capita In Dollars (By Thousands)") +
  expand_limits(y = c(0, 130))+
  theme(axis.text.x = element_blank())  
  ggplotly(b)

# graph 3 #   
     
x<- Data3[,3]
y<- Data3[,2]
n<- length(x)
s.xx <- (sum(x^2) - n * (mean(x))^2)
s.xx
s.xy <- (sum(x*y) - n * (mean(x) * mean(y)))
s.xy
b <- s.xy / s.xx
a <- mean(y) - b * mean(x)
c(a,b)
lm(formula <- y~x)
relation <- lm(y~x)
print(summary(relation))
y_hat <- a + (b*x)
ssr<- sum((y-y_hat)^2)

c <- plot(x,y,main ="Relationship of Income to Life Span",xlab ="Income In $",
          ylab ="Life Expentancy In Years", col = "black", type = "p") 
abline(lm(y~x), col = "blue")

# ggplot lm graph # 
Life_Expectancy <- y
Income_Per_Cap <- x

d <- ggplot(Data3, aes(Income_Per_Cap, Life_Expectancy)) +
     geom_point(colour = "#0c4c8a")+
     labs(title = "Relationship Between Life Expectancy And Income Per Capita",
        x = "Income in $",
        y = "Average Life Expectancy") +
    geom_smooth(method = 'lm') 
ggplotly(d)



# The linear regression model shows that there is a correlation between life expectancy and income # 


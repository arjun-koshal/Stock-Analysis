# Step 1. Import all the packages that we will be utilizing in this program.

library(tidyquant)
library(dplyr)
library(ggplot2)

# Step 2. I decided to import the stock data directly from Yahoo finance, rather
# than creating 6 CSV files. I decided to use the internet to view how this
# would be possible and figured out the tidyquant package allows us to use the
# stock symbol directly from Yahoo finance. Quantmod stores the symbols with their
# own names, however, we can bypass that by setting the warnings to false.

options("getSymbols.warning4.0"=FALSE)
options("getSymbols.yahoo.warning"=FALSE)

# Step 3. Pick which stocks I want to display graphically. I decided to take
# the top 6 stocks from the S&P 500 and display them. I picked the time frame
# 2015 to 2020 as I felt that was the best option. At the bottom, I displayed the
# head of the prices and it was noticeable that only the Apple stock was being
# shown, therefore I had to change it so that we could see every stock,
# not only just the Apple Stock.

tickers = c("AAPL", "MSFT", "AMZN", "FB", "GOOGL", "TSLA")
prices <- tq_get(tickers,
           from = "2015-01-01",
           to = "2020-01-01",
           get = "stock.prices")
head(prices)

# Step 4. I decided to group the stock data by each different company, as that was
# definitely the clearest way of showing all the data. The slice function lets
# us view the first row of each different stock (or symbol in this case).

prices %>%
  group_by(symbol) %>%
slice(1)

# Step 5.Plot all the stocks in different colors, based on their respective symbol
# I decided to plot based on full year ($Y) as it was the most clear and concise
# method. I needed to use the facet_wrap function as we learned in class to make 
# the data fit to their stock prices. Because the Amazon stock was in the thousands
# range, and Microsoft was in the hundreds range, the function facet_wrap allowed 
# the y axis to alter among the different visualizations.

prices %>%
  ggplot(aes(x=date,y=adjusted,color=symbol)) +
  geom_line() +
  facet_wrap(~symbol,scales='free_y') +
  theme_classic() +
  labs(x='Date (in Years)',
       y="Adjusted Price ($)",
       title="6 Stocks in the S&P 500",
       subtitle="Chart of the Prices for the Past 5 Years") +
  scale_x_date(date_breaks="year",
               date_labels="%Y") +
  labs(color="Stock Name") +
  scale_color_manual(name="Stock Name",
                     labels=c("Apple",
                              "Amazon",
                              "Facebook",
                              "Google",
                              "Microsoft",
                              "Tesla"),
                     values=c("AAPL"="red",
                              "AMZN"="orange",
                              "FB"="yellow",
                              "GOOGL"="green",
                              "MSFT"="blue",
                              "TSLA"="purple"))


# MySQL-Stock-Price-Project
SQL project to determine if we should BUY, SELL or HOLD stock of Indian Companies.

## Problem Introduction
Two of India's biggest stock exchanges BSE and NSE, collectively clear trades combining to greater than 40,000 crores every day. As you might already be aware, a lot of trading happens on the basis of technical and fundamental analysis.

One of the most basic technical analysis used by a lot of stock traders is the Moving Average Method. Moving average use the past data to smoothen the price curve. For the purpose of this assignment, we will be using 20 Day and 50 Day moving averages.

When the shorter-term moving average crosses above the longer-term moving average, it is a signal to BUY, as it indicates that the trend is shifting up. This is known as a Golden Cross.

On the opposite when the shorter term moving average crosses below the longer term moving average, it is a signal to SELL, as it indicates the trend is shifting down. It is sometimes referred to as the Death Cross.

Please note that it is important that the Moving Averages Cross each other in order to generate a signal. Merely being above or below is not sufficient to generate a signal.

When the signal is neither buy nor sell, it is classified as hold. If you already own the stock, keep it and if you don't then don't buy it now.

##### Results Expected
The dataset provided here has been extracted from the NSE website. The Stock price data provided is from 1-Jan-2015 to 31-July-2018 for six stocks Eicher Motors, Hero, Bajaj Auto, TVS Motors, Infosys and TCS.

1. Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. (This has to be done for all 6 stocks)

2. Create a master table containing the date and close price of all the six stocks. (Column header for the price is the name of the stock)

3. Use the table created in Part(1) to generate buy and sell signal. Store this in another table named 'bajaj2'. Perform this operation for all stocks.

4. Create a User defined function, that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.


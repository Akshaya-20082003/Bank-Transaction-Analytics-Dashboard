---ADVANCED QUERIES---   

												

                                    -- 1. Monthly Spend per Customer

SELECT CustomerID, MONTH(TransactionDate) AS Month, SUM(Amount) AS Total
FROM Transactions_Bank
GROUP BY CustomerID, MONTH(TransactionDate);



                                    -- 2. Category-wise Total Spend

SELECT M.Category, SUM(T.Amount) AS Total
FROM Transactions_Bank T
JOIN Merchants_Master M ON T.MerchantID = M.MerchantID
GROUP BY M.Category;



                                    -- 3. Highest Spending Customer

SELECT TOP 1 CustomerID, SUM(Amount) AS TotalSpent
FROM Transactions_Bank
GROUP BY CustomerID
ORDER BY TotalSpent DESC;



                                   -- 4. % Share of Each Payment Mode

SELECT Mode, 
       SUM(Amount) * 100.0 / (SELECT SUM(Amount) FROM Transactions_Bank) AS Percentage
FROM Transactions_Bank
GROUP BY Mode;


                                   -- 5. Suspicious Transactions > ₹10,000

SELECT * FROM Transactions_Bank WHERE Amount > 10000;



                                  -- 6. CASE: High, Medium, Low Spenders

SELECT CustomerID, SUM(Amount) AS TotalSpent,
       CASE 
           WHEN SUM(Amount) > 10000 THEN 'High'
           WHEN SUM(Amount) > 5000 THEN 'Medium'
           ELSE 'Low'
       END AS SpendCategory
FROM Transactions_Bank
GROUP BY CustomerID;



                                -- 7. Count of Each Transaction Type per City

SELECT City, TransactionType, COUNT(*) AS Count
FROM Transactions_Bank
GROUP BY City, TransactionType;



                                 -- 8. Most Used Merchant

SELECT TOP 1 MerchantID, COUNT(*) AS Usage
FROM Transactions_Bank
GROUP BY MerchantID
ORDER BY Usage DESC;



                                  -- 9. Gender-wise Total Spending

SELECT C.Gender, SUM(T.Amount) AS Total
FROM Customers_Bank C
JOIN Transactions_Bank T ON C.CustomerID = T.CustomerID
GROUP BY C.Gender;



                                  -- 10. Merchant Revenue by City

SELECT M.City, M.MerchantName, SUM(T.Amount) AS Revenue
FROM Transactions_Bank T
JOIN Merchants_Master M ON T.MerchantID = M.MerchantID
GROUP BY M.City, M.MerchantName;



                                   -- 11. Customer Age Groups and Spending

SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18–25'
        WHEN Age BETWEEN 26 AND 35 THEN '26–35'
        ELSE '36+'
    END AS AgeGroup,
    SUM(Amount) AS TotalSpent
FROM Customers_Bank C
JOIN Transactions_Bank T ON C.CustomerID = T.CustomerID
GROUP BY 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18–25'
        WHEN Age BETWEEN 26 AND 35 THEN '26–35'
        ELSE '36+'
    END;



                                 -- 12. Top Customers with More Than 3 Transactions

SELECT CustomerID, COUNT(*) AS TxnCount
FROM Transactions_Bank
GROUP BY CustomerID
HAVING COUNT(*) > 3;



                                    -- 13. Day-wise Total Spending

SELECT DATENAME(WEEKDAY, TransactionDate) AS DayName, SUM(Amount) AS Total
FROM Transactions_Bank
GROUP BY DATENAME(WEEKDAY, TransactionDate);



                                  -- 14. Average Spend per Mode

SELECT Mode, AVG(Amount) AS AvgSpend
FROM Transactions_Bank
GROUP BY Mode;



                                    -- 15. Running Total per Customer

SELECT CustomerID, TransactionDate, Amount,
       SUM(Amount) OVER (PARTITION BY CustomerID ORDER BY TransactionDate) AS RunningTotal
FROM Transactions_Bank;

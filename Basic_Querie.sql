--- BASIC QUERIES ---



							 -- 1. All Transactions

SELECT * FROM Transactions_Bank;


                           -- 2. Total Transactions by Each Customer

SELECT CustomerID, COUNT(*) AS TotalTransactions
FROM Transactions_Bank
GROUP BY CustomerID;


                           -- 3. All Credit Transactions

SELECT * FROM Transactions_Bank WHERE TransactionType = 'Credit';



                           -- 4. All Debit Transactions

SELECT * FROM Transactions_Bank WHERE TransactionType = 'Debit';



                          -- 5. UPI Based Transactions

SELECT * FROM Transactions_Bank WHERE Mode = 'UPI';



                           -- 6. Total Amount Spent by Each Customer

SELECT CustomerID, SUM(Amount) AS TotalSpent
FROM Transactions_Bank
GROUP BY CustomerID;



                            -- 7. City-wise Transaction Count

SELECT City, COUNT(*) AS TxnCount
FROM Transactions_Bank
GROUP BY City;



                           -- 8. Merchant-wise Spend

SELECT M.MerchantName, SUM(T.Amount) AS Total
FROM Transactions_Bank T
JOIN Merchants_Master M ON T.MerchantID = M.MerchantID
GROUP BY M.MerchantName;



                           -- 9. Count of Customers from Each City

SELECT City, COUNT(*) FROM Customers_Bank GROUP BY City;



                           -- 10. Cards Issued by Bank

SELECT IssuerBank, COUNT(*) FROM Cards_Master GROUP BY IssuerBank;



                           -- 11. Female Customers Who Live in Mumbai

SELECT * FROM Customers_Bank WHERE Gender = 'F' AND City = 'Mumbai';



                              -- 12. Customer using HDFC Credit Card

SELECT C.CustomerName, CM.CardType, CM.IssuerBank 
FROM Customers_Bank C
JOIN Cards_Master CM ON C.CustomerID = CM.CustomerID
WHERE CM.IssuerBank = 'HDFC';



                                -- 13. Top 3 High Amount Transactions

SELECT TOP 3 * FROM Transactions_Bank ORDER BY Amount DESC;



                                 -- 14. All Food Category Merchants

SELECT * FROM Merchants_Master WHERE Category = 'Food';



                                   -- 15. Distinct Payment Modes

SELECT DISTINCT Mode FROM Transactions_Bank;



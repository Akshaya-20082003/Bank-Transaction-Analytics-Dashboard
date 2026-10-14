                   --Customers_Bank--

CREATE TABLE Customers_Bank (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Gender CHAR(1),
    Age INT,
    City VARCHAR(50)
);

                   --Cards_Master--

CREATE TABLE Cards_Master (
    CardID INT PRIMARY KEY,
    CardType VARCHAR(10),           -- 'Debit' or 'Credit'
    IssuerBank VARCHAR(100),
    CustomerID INT FOREIGN KEY REFERENCES Customers_Bank(CustomerID)
); 

                   --Merchants_Master--

CREATE TABLE Merchants_Master (
    MerchantID INT PRIMARY KEY,
    MerchantName VARCHAR(100),
    Category VARCHAR(50),              -- Shopping, Food, Travel, etc.
    City VARCHAR(50)
);

                    --Transactions_Bank--

CREATE TABLE Transactions_Bank (
    TransactionID INT PRIMARY KEY,
    TransactionDate DATE,
    CustomerID INT FOREIGN KEY REFERENCES Customers_Bank(CustomerID),
    CardID INT FOREIGN KEY REFERENCES Cards_Master(CardID),
    MerchantID INT FOREIGN KEY REFERENCES Merchants_Master(MerchantID),
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(10),               -- 'Credit' / 'Debit'
    Mode VARCHAR(50),                          -- 'UPI', 'NetBanking', etc.
    City VARCHAR(50)
);




                                        ---INSERT STATEMENTS--
										
                        --Customers_Bank--


INSERT INTO Customers_Bank VALUES 

(1,   'Priya  Mehta',     'F',    29,    'Mumbai'),
(2,   'Aman   Verma',     'M',    35,    'Delhi'),
(3,   'Neha   Sharma',    'F',    42,    'Bangalore'),
(4,   'Rohit  Singh',     'M',    31,    'Chennai'),
(5,   'Isha   Gupta',     'F',    27,    'Pune');


                         --Cards_Master--


INSERT INTO Cards_Master VALUES 

(101,    'Credit',     'HDFC',    1),
(102,    'Debit',      'SBI',     2),
(103,    'Credit',     'ICICI',   3),
(104,    'Debit',      'Axis',    4),
(105,    'Credit',     'Kotak',   5);


                           --Merchants_Master--


INSERT INTO Merchants_Master VALUES 

(201,     'Amazon',      'Shopping',    'Mumbai'),
(202,     'Zomato',      'Food',        'Delhi'),
(203,     'MakeMyTrip',  'Travel',      'Bangalore'),
(204,     'Flipkart',    'Shopping',    'Chennai'),
(205,     'Swiggy',      'Food',        'Pune');


                           --Transactions_Bank--


INSERT INTO Transactions_Bank VALUES 

(1001,    '2025-07-01',    1,    101,    201,    2500.00,      'Debit',     'UPI',           'Mumbai'),
(1002,    '2025-07-02',    2,    102,    202,    12000.00,     'Credit',    'NetBanking',    'Delhi'),
(1003,    '2025-07-03',    3,    103,    203,    800.00,       'Debit',     'POS',           'Bangalore'),
(1004,    '2025-07-03',    1,    101,    202,    1500.00,      'Debit',     'UPI',           'Mumbai'),
(1005,    '2025-07-04',    4,    104,    201,    3000.00,      'Debit',     'POS',           'Chennai'),
(1006,    '2025-07-05',    5,    105,    204,    2000.00,      'Debit',     'UPI',           'Pune'),
(1007,    '2025-07-06',    1,    101,    205,    500.00,       'Credit',    'NetBanking',    'Mumbai'),
(1008,    '2025-07-07',    2,    102,    201,    9500.00,      'Debit',     'POS',           'Delhi'),
(1009,    '2025-07-08',    3,    103,    203,    12500.00,     'Credit',    'NetBanking',    'Bangalore'),
(1010,    '2025-07-09',    4,    104,    204,    700.00,       'Debit',     'UPI',           'Chennai');




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

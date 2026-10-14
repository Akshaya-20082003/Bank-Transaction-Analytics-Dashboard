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
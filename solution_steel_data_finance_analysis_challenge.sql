-- 1. What are the names of all the customers who live in New York? 

SELECT CONCAT(FirstName, ' ', LastName) AS [Customer Name], City
FROM Customers
WHERE City = 'New York';


-- 2. What is the total number of accounts in the Accounts table?

-- Option 1
SELECT COUNT(*) AS [Total Accounts]
FROM Accounts;

-- Option 2
SELECT COUNT(DISTINCT AccountID) as [Total Accounts]
FROM Accounts;


-- 3. What is the total balance of all checking accounts?

SELECT SUM(Balance) AS [Total Balance]
FROM Accounts
WHERE AccountType = 'Checking';


-- 4. What is the total balance of all accounts associated with customers who live in Los Angeles?

SELECT 
      a.AccountType AS [Account Type]
    , SUM(a.Balance) AS [Total Balance] 
FROM Accounts a 
JOIN Customers c ON a.CustomerID = c.CustomerID
WHERE City = 'Los Angeles'
GROUP BY a.AccountType
ORDER BY [Total Balance];


-- 5. Which branch has the highest average account balance?

SELECT TOP 1
      b.BranchName AS [Branch Name]
    , AVG(a.Balance) AS [Average Balance]
FROM Branches b 
JOIN Accounts a ON a.BranchID = b.BranchID
GROUP by b.BranchName
ORDER BY [Average Balance] DESC;


-- 6. Which customer has the highest current balance in their accounts?

SELECT TOP 1 
      a.CustomerID AS [Customer ID]
    , CONCAT(c.FirstName, ' ', c.LastName) AS [Customer Name]
    , SUM(a.Balance) AS [Total Balance]
FROM Accounts a 
JOIN Customers c ON a.CustomerID = c.CustomerID
GROUP BY a.CustomerID, CONCAT(c.FirstName, ' ', c.LastName)
ORDER BY [Total Balance] DESC;


-- 7. Which customer has made the most transactions in the Transactions table?

SELECT TOP 1 
      CONCAT(c.FirstName, ' ', c.LastName) AS [Customer Name]
    , COUNT(DISTINCT t.TransactionID) AS [Total Transactions]
FROM Accounts a 
JOIN Customers c ON a.CustomerID = c.CustomerID
JOIN Transactions t ON a.AccountID = t.AccountID
GROUP BY CONCAT(c.FirstName, ' ', c.LastName)
ORDER BY [Total Transactions] DESC


-- 8.Which branch has the highest total balance across all of its accounts?

SELECT TOP 1
      b.BranchName AS [Branch Name]
    , SUM(a.Balance) AS [Total Balance]
FROM Branches b 
JOIN Accounts a ON b.BranchID = a.BranchID
GROUP BY b.BranchName
ORDER BY [Total Balance] DESC;


-- 9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?

SELECT TOP 1
      CONCAT(c.FirstName, ' ', c.LastName) AS [Customer Name]
    , SUM(a.Balance) AS [Total Balance]
FROM Accounts a 
JOIN Customers c ON a.CustomerID = c.CustomerID
WHERE a.AccountType IN ('savings', 'checking')
GROUP BY CONCAT(c.FirstName, ' ', c.LastName)
ORDER BY [Total Balance] DESC;

-- 10. Which branch has the highest number of transactions in the Transactions table? 

SELECT TOP 1
      b.BranchName AS [Branch Name]
    , COUNT(DISTINCT t.TransactionID) AS [Total Transactions]
FROM Branches b 
JOIN Accounts a on b.BranchID = a.BranchID
JOIN Transactions t ON t.AccountID = a.AccountID
GROUP BY b.BranchName
ORDER BY [Total Transactions] DESC;
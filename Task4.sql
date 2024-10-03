use hsbank
SELECT * FROM Customers
SELECT * FROM Accounts
-- Retrieve the customer(s) with the highest account balance
SELECT c.customer_id, a.balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
WHERE a.balance = (
    SELECT MAX(balance)
    FROM Accounts
);

-- Average account balance for customers with more than one account
SELECT AVG(a.balance) AS average_balance
FROM Accounts a
JOIN (
    SELECT customer_id
    FROM Accounts
    GROUP BY customer_id
    HAVING COUNT(account_id) > 1
) AS multi_account_customers ON a.customer_id = multi_account_customers.customer_id;

-- Retrieve accounts with transactions whose amounts exceed the average transaction amount
SELECT DISTINCT a.account_id, a.balance
FROM Accounts a
JOIN Transactions t ON a.account_id = t.account_id
WHERE t.amount > (
    SELECT AVG(amount)
    FROM Transactions
);

-- Identify customers who have no recorded transactions
SELECT c.customer_id
FROM Customers c
LEFT JOIN Accounts a ON c.customer_id = a.customer_id
LEFT JOIN Transactions t ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;

-- Calculate the total balance of accounts with no recorded transactions
SELECT SUM(a.balance) AS total_balance
FROM Accounts a
LEFT JOIN Transactions t ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;

-- Retrieve transactions for accounts with the lowest balance
SELECT t.transaction_id, t.amount, t.transaction_date, a.account_id
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
WHERE a.balance = (
    SELECT MIN(balance)
    FROM Accounts
);

-- Identify customers who have accounts of multiple types
SELECT c.customer_id
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT a.account_type) > 1;

-- Calculate the percentage of each account type out of the total number of accounts
SELECT a.account_type,
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Accounts) AS percentage
FROM Accounts a
GROUP BY a.account_type;

-- Retrieve all transactions for a customer with a given customer_id
SELECT t.transaction_id, t.amount, t.transaction_date
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
WHERE a.customer_id = 1;

-- Calculate the total balance for each account type, including a subquery within the SELECT clause
SELECT a.account_type,
       SUM(a.balance) AS total_balance,
       (SELECT SUM(balance) FROM Accounts) AS overall_total_balance
FROM Accounts a
GROUP BY a.account_type;

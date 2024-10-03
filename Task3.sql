use hsbank
 -- Find the Average Account Balance for All Customers

SELECT 
    AVG(balance) AS average_balance
FROM 
    Accounts;

-- Retrieve the Top 5 Highest Account Balances
SELECT TOP 10 
    account_id,
    balance
FROM 
    Accounts
ORDER BY 
    balance DESC

-- Total Deposits for All Customers on a Specific Date
SELECT * FROM Transactions
SELECT SUM(amount) AS total_deposits
FROM transactions
WHERE transaction_type = 'deposit'
AND transaction_date = '2024-09-25';

-- Oldest and Newest Customers
SELECT 
	MIN(created_at) AS oldest_customer, MAX(created_at) AS newest_customer
FROM 
	customers;

-- Retrieve Transaction Details Along with Account Type
SELECT t.transaction_id, t.amount, t.transaction_date, a.account_type
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id;

-- List of customers along with their account details

SELECT c.customer_id, c.customer_name, a.account_id, a.account_balance, a.account_type
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id;


-- Transaction details along with customer information for a specific account
SELECT t.transaction_id, t.amount, t.transaction_date, c.customer_name
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
WHERE a.account_id = 'account_id';

-- Identify customers with more than one account
SELECT c.customer_id, c.customer_name, COUNT(a.account_id) AS account_count
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(a.account_id) > 1;

-- Calculate the difference in transaction amounts between deposits and withdrawals
SELECT 
    SUM(CASE WHEN transaction_type = 'deposit' THEN amount ELSE 0 END) - 
    SUM(CASE WHEN transaction_type = 'withdrawal' THEN amount ELSE 0 END) AS balance_difference
FROM transactions;

Average daily balance for each account over a specified period
SELECT 
    account_id, 
    AVG(daily_balance) AS average_daily_balance
FROM (
    SELECT 
        account_id, 
        transaction_date, 
        SUM(amount) AS daily_balance
    FROM transactions
    WHERE transaction_date BETWEEN '2024-01-01' AND '2024-12-31'  -- Replace with your period
    GROUP BY account_id, transaction_date
) AS daily_balances
GROUP BY account_id;

-- Total balance for each account type
SELECT a.account_type, SUM(a.account_balance) AS total_balance
FROM accounts a
GROUP BY a.account_type;

-- Accounts with the highest number of transactions ordered by descending
SELECT a.account_id, COUNT(t.transaction_id) AS transaction_count
FROM accounts a
JOIN transactions t ON a.account_id = t.account_id
GROUP BY a.account_id
ORDER BY transaction_count DESC;

-- Customers with high aggregate account balances along with their account types
SELECT c.customer_id, c.customer_name, a.account_type, SUM(a.account_balance) AS total_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.customer_name, a.account_type
HAVING total_balance > 10000;  -- Replace with your threshold

-- Identify and list duplicate transactions based on amount, date, and account
SELECT amount, transaction_date, account_id, COUNT(*) AS duplicate_count
FROM transactions
GROUP BY amount, transaction_date, account_id
HAVING COUNT(*) > 1;

USE hsbank

-- 1. Insert at least 10 sample records into each of the following tables.   
INSERT INTO Customers (customer_id, first_name, last_name, DOB, email, phone_number, address) VALUES
(1, 'John', 'Doe', '1985-04-15', 'john.doe@example.com', '1234567890', '123 Elm St, Springfield'),
(2, 'Jane', 'Smith', '1990-07-22', 'jane.smith@example.com', '0987654321', '456 Oak St, Springfield'),
(3, 'Alice', 'Johnson', '1982-11-30', 'alice.johnson@example.com', '1122334455', '789 Pine St, Springfield'),
(4, 'Bob', 'Brown', '1975-02-18', 'bob.brown@example.com', '2233445566', '321 Maple St, Springfield'),
(5, 'Charlie', 'Davis', '1995-03-10', 'charlie.davis@example.com', '3344556677', '159 Cedar St, Springfield'),
(6, 'Eve', 'White', '1988-09-25', 'eve.white@example.com', '4455667788', '753 Birch St, Springfield'),
(7, 'Frank', 'Miller', '1970-12-14', 'frank.miller@example.com', '5566778899', '246 Spruce St, Springfield'),
(8, 'Grace', 'Wilson', '1980-05-05', 'grace.wilson@example.com', '6677889900', '369 Willow St, Springfield'),
(9, 'Henry', 'Moore', '1992-06-20', 'henry.moore@example.com', '7788990011', '852 Fir St, Springfield'),
(10, 'Isabel', 'Taylor', '1983-10-30', 'isabel.taylor@example.com', '8899001122', '963 Chestnut St, Springfield');

SELECT * FROM Customers

INSERT INTO Accounts (account_id, customer_id, account_type, balance) VALUES
(1, 1, 'savings', 1500.50),
(2, 1, 'current', 2500.00),
(3, 2, 'savings', 3000.75),
(4, 3, 'zero', 0.00),
(5, 4, 'current', 1200.00),
(6, 5, 'savings', 3500.25),
(7, 6, 'current', 500.00),
(8, 7, 'savings', 700.00),
(9, 8, 'zero', 0.00),
(10, 9, 'savings', 2200.00);

SELECT * FROM Accounts

INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES
(1, 1, 'deposit', 500.00, '2024-09-01 10:00:00'),
(2, 1, 'withdrawal', 200.00, '2024-09-05 14:30:00'),
(3, 2, 'transfer', 1000.00, '2024-09-10 09:15:00'),
(4, 3, 'deposit', 1500.00, '2024-09-15 11:45:00'),
(5, 4, 'withdrawal', 100.00, '2024-09-20 16:00:00'),
(6, 5, 'deposit', 700.00, '2024-09-25 08:00:00'),
(7, 6, 'withdrawal', 250.00, '2024-09-26 09:30:00'),
(8, 7, 'deposit', 500.00, '2024-09-27 10:15:00'),
(9, 8, 'transfer', 150.00, '2024-09-28 11:00:00'),
(10, 9, 'deposit', 800.00, '2024-09-29 12:45:00');


SELECT * FROM Transactions

-- Write SQL queries For
-- retrieve the name, account type and email of all customers.

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
	-- c.first_name,
	-- c.last_name,
    a.account_type,
    c.email
FROM 
    Customers c
JOIN 
    Accounts a ON c.customer_id = a.customer_id;

-- list all transaction corresponding customer. 
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    a.account_type,
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date
FROM 
    Customers c
JOIN 
    Accounts a ON c.customer_id = a.customer_id
JOIN 
    Transactions t ON a.account_id = t.account_id
ORDER BY 
    c.customer_id, t.transaction_date;

--  increase the balance of a specific account by a certain amount. 
SELECT * FROM Accounts
UPDATE Accounts
SET balance = balance + 500
WHERE account_id = 3;
SELECT * FROM Accounts

-- Combine first and last names of customers as a full_name
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name
FROM
	Customers;


INSERT INTO Accounts (account_id, customer_id, account_type, balance) VALUES
(11, 2, 'savings', 0.00);

SELECT *
FROM Accounts
WHERE balance = 0 AND account_type = 'savings';

DELETE FROM Accounts
WHERE balance = 0 AND account_type = 'savings';

SELECT *
FROM Accounts
WHERE balance = 0 AND account_type = 'savings';




SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    email,
    phone_number,
    address
FROM 
    Customers
WHERE 
    address LIKE '%Springfield%';



-- Get the account balance for a specific account. 
SELECT * FROM Accounts
SELECT 
    account_id,
    balance
FROM 
    Accounts
WHERE 
    account_id = 4;

-- List all current accounts with a balance greater than $1,000.
SELECT * FROM Accounts
SELECT 
    account_id,
    customer_id,
    balance
FROM 
    Accounts
WHERE 
    account_type = 'current' AND balance > 1000;


-- All Transaction from specific Acount_id
SELECT 
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_date
FROM 
    Transactions
WHERE 
    account_id = 4;

-- Calculate the interest accrued on savings accounts based on a given interest rate. 
SELECT 
    account_id,
    balance,
    (balance * 2 / 100) AS interest_accrued
FROM 
    Accounts
WHERE 
    account_type = 'savings';

--Identify accounts where the balance is less than a specified overdraft limit

SELECT * FROM Accounts
SELECT 
    account_id,
    customer_id,
	account_type,
    balance
FROM 
    Accounts
WHERE 
    balance < 1000;


-- Find customers not living in a specific city. 
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    email,
    phone_number,
    address
FROM 
    Customers
WHERE 
    address NOT LIKE '%Springfield%';
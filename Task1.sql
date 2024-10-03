CREATE DATABASE hsbank
sp_rename 'hsbank' , 'HMBank'
USE hsbank

CREATE TABLE Customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    DOB DATE,
    email VARCHAR(100 )UNIQUE,
    phone_number VARCHAR(15),
    address VARCHAR(255)
);



CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    account_type VARCHAR(10),
    balance DECIMAL(10, 2),
);



CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(10),
    amount DECIMAL(15, 2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

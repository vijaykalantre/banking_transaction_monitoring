create database project2;
use project2;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    mobile VARCHAR(15)
);
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    transaction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);
INSERT INTO customers VALUES
(1,'Rahul Sharma','Pune','9876543210'),
(2,'Neha Patil','Mumbai','9123456780'),
(3,'Amit Verma','Delhi','9988776655'),
(4,'Sneha Kulkarni','Nagpur','9012345678'),
(5,'Raj Singh','Lucknow','8899776655'),
(6,'Pooja Mehta','Ahmedabad','9871234560'),
(7,'Vikas Rao','Hyderabad','9988123456'),
(8,'Anjali Nair','Kochi','9898989898'),
(9,'Suresh Iyer','Chennai','9765432109'),
(10,'Kiran Deshmukh','Nashik','9123987654'),
(11,'Manoj Kumar','Patna','9001122334'),
(12,'Ritu Malhotra','Delhi','9812345678'),
(13,'Akash Jain','Indore','9876001122'),
(14,'Meena Joshi','Jaipur','9823456712'),
(15,'Arjun Kapoor','Chandigarh','9911223344'),
(16,'Sunita Reddy','Bangalore','9845612378'),
(17,'Prakash Pawar','Kolhapur','9090909090'),
(18,'Deepa Kulkarni','Satara','9011223344'),
(19,'Nikhil Bansal','Noida','9877894561'),
(20,'Ramesh Yadav','Varanasi','9955667788');

INSERT INTO accounts VALUES
(101,1,'Savings',50000),
(102,2,'Savings',120000),
(103,3,'Current',250000),
(104,4,'Savings',40000),
(105,5,'Current',180000),
(106,6,'Savings',90000),
(107,7,'Current',300000),
(108,8,'Savings',65000),
(109,9,'Savings',70000),
(110,10,'Current',210000),
(111,11,'Savings',35000),
(112,12,'Savings',95000),
(113,13,'Current',160000),
(114,14,'Savings',48000),
(115,15,'Current',220000),
(116,16,'Savings',80000),
(117,17,'Savings',55000),
(118,18,'Current',140000),
(119,19,'Savings',62000),
(120,20,'Savings',45000);

INSERT INTO transactions VALUES
(1,101,'Debit',15000,'2024-10-01 10:10:00'),
(2,101,'Credit',20000,'2024-10-01 11:00:00'),
(3,102,'Debit',90000,'2024-10-01 12:30:00'),
(4,102,'Debit',10000,'2024-10-01 13:00:00'),
(5,103,'Debit',120000,'2024-10-01 14:15:00'),
(6,104,'Debit',35000,'2024-10-01 15:20:00'),
(7,105,'Debit',95000,'2024-10-01 16:00:00'),
(8,105,'Credit',50000,'2024-10-01 17:00:00'),
(9,106,'Debit',60000,'2024-10-02 09:30:00'),
(10,107,'Debit',200000,'2024-10-02 10:00:00'),
(11,108,'Credit',30000,'2024-10-02 11:15:00'),
(12,109,'Debit',45000,'2024-10-02 12:40:00'),
(13,110,'Debit',175000,'2024-10-02 13:55:00'),
(14,111,'Debit',20000,'2024-10-02 14:30:00'),
(15,112,'Credit',40000,'2024-10-02 15:10:00'),
(16,113,'Debit',80000,'2024-10-02 16:45:00'),
(17,114,'Debit',30000,'2024-10-02 17:20:00'),
(18,115,'Debit',150000,'2024-10-02 18:00:00'),
(19,116,'Credit',50000,'2024-10-03 09:30:00'),
(20,117,'Debit',55000,'2024-10-03 10:15:00');

#1.Find high-value transactions (> ₹1,00,000)
SELECT *
FROM transactions
WHERE amount > 100000;

#2.Display customer name and city 
SELECT customer_name, city FROM customers;

#3.Display all accounts with balance > 50,000 
SELECT * FROM accounts
WHERE balance > 50000;

#4.Display transactions of type Debit 
SELECT * FROM transactions
WHERE transaction_type = 'Debit';

#5.Customers from Pune or Mumbai 
SELECT * FROM customers
WHERE city IN ('Pune','Mumbai');

#6.Transactions between 50,000 and 1,00,000 
SELECT * FROM transactions
WHERE amount BETWEEN 50000 AND 100000;

#7.Accounts ordered by balance (high to low)
SELECT * FROM accounts
ORDER BY balance DESC;

#8.Unique cities of customers 
SELECT DISTINCT city FROM customers;

#9.Total number of customers 
SELECT COUNT(*) FROM customers;

#10.SELECT COUNT(*) FROM customers;
SELECT account_id, SUM(amount) AS total_amount
FROM transactions
GROUP BY account_id;

#11.Accounts having total transactions > 1,50,000
SELECT account_id, SUM(amount) AS total_amount
FROM transactions
GROUP BY account_id
HAVING SUM(amount) > 150000;

#12.Customer name with account balance
SELECT c.customer_name, a.balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id;

#13.Customer-wise transactions
SELECT c.customer_name, t.transaction_type, t.amount
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id;

#14.Transactions above average amount
SELECT * FROM transactions
WHERE amount > (
    SELECT AVG(amount) FROM transactions
);

#15.Transactions on a specific date
SELECT * FROM transactions
WHERE DATE(transaction_time) = '2024-10-02';

#16.Rank transactions by amount
SELECT transaction_id, amount,
RANK() OVER (ORDER BY amount DESC) AS rnk
FROM transactions;

#17.Top 3 highest transactions 
SELECT *
FROM (
    SELECT transaction_id, amount,
    DENSE_RANK() OVER (ORDER BY amount DESC) AS rnk
    FROM transactions
) t
WHERE rnk <= 3;





















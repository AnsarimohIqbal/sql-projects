-- Q1) List all customer names, cities, and ages.

select 
FullName , city , age 
from customer ;

-- Q2) Retrieve all accounts opened after 2020.

select * from account 
where Open_Date > 2020 ;


-- Q3) Display the top 10 highest account balances.

select * from account 
order by Balance desc 
limit 10 ;


-- Q4 ) Show all transactions above ₹50,000.
select * from transaction 
where Amount > 50000 
order by Amount desc ;

-- Q5) Find all customers who are from ‘Justinberg’.
select * from customer 
where city = "Justinberg" ;


-- Q6) Count how many customers are from each city.

select 
count(cust_id)  as Total_customer ,
city
from customer
group by city ;


-- Q7) Show all customers who are above 40 years old.
select * from customer 
where age > 40 ;

-- Q8) Get all loans that are currently Active.
select * from Loan
where status = "Active" ;

-- Q9) Find all transactions made through the UPI channel
select * from transaction 
where Channel = "UPI" ;

-- Q10) Sort customers alphabetically by their full name 
select * from customer 
order by FullName asc ;


-- Q11) Display each customer’s account type and balance.

select 
customer.FullName,
account.Account_Type,
account.Balance 
from customer 
left join account 
on customer.Cust_ID = account.Cust_ID 
order by FullName asc ;

-- Q12) List all transactions with the customer’s name and city.
 select 
 customer.FullName,city ,
 transaction.Amount 
 from customer 
 left join account 
 on customer.Cust_ID = account.Cust_ID 
 left join  transaction
 on account.Account_ID = transaction.Account_ID ;
 
 
 -- Q13) Show all loans with the customer name and loan type. 
 select 
 customer.FullName ,
 loan.loan_type , loan_amount ,status 
 from customer 
 left join loan 
 on customer.Cust_ID = loan.Cust_ID 
 order by FullName asc ;
 
 -- Q14) Find customers who have both Savings and Current accounts.
 SELECT 
Cust_ID
FROM Account
WHERE Account_Type IN ('Savings', 'Current')
GROUP BY Cust_ID
HAVING COUNT(DISTINCT Account_Type) = 2;

-- Q15) Retrieve all customers who have no loan records.

SELECT
Customer.Cust_ID,
Customer.FullName,
Customer.City,
Customer.Email
FROM Customer
LEFT JOIN Loan
ON Customer.Cust_ID = Loan.Cust_ID
WHERE 
Loan.Cust_ID IS NULL;

-- Q16) Find customers who have made more than 5 transactions.
select * from transaction ;

SELECT 
customer.FullName,
COUNT(transaction.Txn_ID) AS total_transaction
FROM customer
LEFT JOIN account
ON customer.Cust_ID = account.Cust_ID
LEFT JOIN transaction
ON account.Account_ID =transaction.Account_ID
GROUP BY customer.FullName
HAVING COUNT(transaction.Txn_ID) > 5
ORDER BY total_transaction DESC;


-- Q17) Display each customer’s total number of accounts.

SELECT
Customer.Cust_ID,
Customer.FullName,
COUNT(Account.Account_ID) AS Total_Accounts
FROM Customer
LEFT JOIN Account
ON Customer.Cust_ID = Account.Cust_ID
GROUP BY
Customer.Cust_ID,
Customer.FullName
ORDER BY Total_Accounts DESC;

-- Q18) Find accounts where no transactions have been made yet.

SELECT
Account.Account_ID,
Account.Cust_ID,
Account.Account_Type,
Account.Balance
FROM Account
LEFT JOIN Transaction
ON Account.Account_ID = Transaction.Account_ID
WHERE Transaction.Account_ID IS NULL;

-- Q19) Retrieve all customers with multiple accounts (more than one account).
SELECT
Customer.Cust_ID,
Customer.FullName,
Customer.City,
COUNT(Account.Account_ID) AS Total_Accounts
FROM Customer
INNER JOIN Account
ON Customer.Cust_ID = Account.Cust_ID
GROUP BY
Customer.Cust_ID,
Customer.FullName,
Customer.City
HAVING
COUNT(Account.Account_ID) > 1
ORDER BY Total_Accounts DESC;

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 -- Q20) Calculate the total deposit (credit) and total withdrawal (debit) amount per customer
SELECT
    Customer.Cust_ID,
    Customer.FullName,
    SUM(CASE WHEN Transaction.Txn_Type = 'Credit' THEN Transaction.Amount ELSE 0 END) AS Total_Deposit,
    SUM(CASE WHEN Transaction.Txn_Type = 'Debit' THEN Transaction.Amount ELSE 0 END) AS Total_Withdrawal
FROM
    Customer
LEFT JOIN
    Account
    ON Customer.Cust_ID = Account.Cust_ID
LEFT JOIN
    Transaction
    ON Account.Account_ID = Transaction.Account_ID
GROUP BY
    Customer.Cust_ID,
    Customer.FullName
ORDER BY
    Customer.FullName ASC;

-- Q21) Find the average account balance per city.

SELECT
    Customer.City,
    AVG(Account.Balance) AS Average_Balance
FROM
    Customer
JOIN
    Account
    ON Customer.Cust_ID = Account.Cust_ID
GROUP BY
    Customer.City
ORDER BY
    Average_Balance DESC;

-- Q22) Find the top 5 customers by total transaction amount.

SELECT
    Customer.Cust_ID,
    Customer.FullName,
    SUM(`Transaction`.Amount) AS Total_Transaction_Amount
FROM
    Customer
JOIN
    Account
    ON Customer.Cust_ID = Account.Cust_ID
JOIN
    Transaction
    ON Account.Account_ID = Transaction.Account_ID
GROUP BY
    Customer.Cust_ID,
    Customer.FullName
ORDER BY
    Total_Transaction_Amount DESC
LIMIT 5;

-- Q23) For each account, show the latest transaction date.
 SELECT
    Account.Account_ID,
    Account.Cust_ID,
    Account.Account_Type,
    MAX(Transaction.Txn_Date) AS Latest_Transaction_Date
FROM
    Account
LEFT JOIN
    Transaction
    ON Account.Account_ID = Transaction.Account_ID
GROUP BY
    Account.Account_ID,
    Account.Cust_ID,
    Account.Account_Type
ORDER BY
    Account.Account_ID;
    
-- Q24) Calculate the monthly total transaction volume (by Txn_Date)

SELECT
    DATE_FORMAT(Transaction.Txn_Date, '%Y-%m') AS Month,
    COUNT(Transaction.Txn_ID) AS Total_Transactions,
    SUM(Transaction.Amount) AS Total_Amount
FROM
    Transaction
GROUP BY
    DATE_FORMAT(Transaction.Txn_Date, '%Y-%m')
ORDER BY
    Month;
-- Q25) Find the average loan amount by loan type.

SELECT
    Loan.Loan_Type,
    AVG(Loan.Loan_Amount) AS Average_Loan_Amount
FROM
    Loan
GROUP BY
    Loan.Loan_Type
ORDER BY
    Average_Loan_Amount DESC;
-- Q26) Display the rank of each customer by their total account balance.

SELECT
    Customer.Cust_ID,
    Customer.FullName,
    SUM(Account.Balance) AS Total_Balance,
    RANK() OVER (ORDER BY SUM(Account.Balance) DESC) AS Balance_Rank
FROM
    Customer
LEFT JOIN
    Account
    ON Customer.Cust_ID = Account.Cust_ID
GROUP BY
    Customer.Cust_ID,
    Customer.FullName
ORDER BY
    Balance_Rank;

-- Q27) Find customers whose average transaction amount is above ₹50,000.

SELECT
    Customer.Cust_ID,
    Customer.FullName,
    AVG(
    Transaction.Amount) AS Average_Transaction_Amount
FROM
    Customer
JOIN
    Account
    ON Customer.Cust_ID = Account.Cust_ID
JOIN
    Transaction
    ON Account.Account_ID = Transaction.Account_ID
GROUP BY
    Customer.Cust_ID,
    Customer.FullName
HAVING
    AVG(Transaction.Amount) > 50000
ORDER BY
    Average_Transaction_Amount DESC;
    
-- Q28 )Calculate the total number of transactions per transaction channel (UPI, NEFT, etc.).

SELECT
    Transaction.Channel,
    COUNT(Transaction.Txn_ID) AS Total_Transactions,
    SUM(Transaction.Amount) AS Total_Amount
FROM
    Transaction
GROUP BY
    Transaction.Channel
ORDER BY
    Total_Transactions DESC;
    
-- Q29) Find the account with the highest single transaction amount.

SELECT
    
    
    Transaction.Txn_ID,
    Transaction.Account_ID,
    Transaction.Amount AS Highest_Amount,
    Transaction.Txn_Date,
    Transaction.Txn_Type,
    Transaction.Channel,
    Account.Cust_ID,
    Customer.FullName
FROM
    Transaction
JOIN
    Account
    ON Transaction.Account_ID = Account.Account_ID
JOIN
    Customer
    ON Account.Cust_ID = Customer.Cust_ID
ORDER BY
    Transaction.Amount DESC
LIMIT 1;

-- Q30 ) Find customers whose balance is above the average balance of all customers.
SELECT
    Customer.Cust_ID,
    Customer.FullName,
    SUM(Account.Balance) AS Total_Balance
FROM
    Customer
JOIN
    Account
    ON Customer.Cust_ID = Account.Cust_ID
GROUP BY
    Customer.Cust_ID,
    Customer.FullName
HAVING
    SUM(Account.Balance) >
    (
        SELECT AVG(TotalBal)
        FROM
        (
            SELECT
                SUM(Account.Balance) AS TotalBal
            FROM
                Account
            GROUP BY
                Account.Cust_ID
        ) AS x
    )
ORDER BY
    Total_Balance DESC;


-- Q31 ) Show the customer(s) who have taken the largest loan.

SELECT
    Loan.Loan_ID,
    Loan.Cust_ID,
    Customer.FullName,
    Loan.Loan_Type,
    Loan.Loan_Amount
FROM
    Loan
JOIN
    Customer
    ON Loan.Cust_ID = Customer.Cust_ID
WHERE
    Loan.Loan_Amount = (
        SELECT MAX(Loan_Amount) FROM Loan
    );

-- Q32) Find all customers who made transactions only via UPI.

SELECT
    Customer.Cust_ID,
    Customer.FullName
FROM
    Customer
JOIN
    Account
    ON Customer.Cust_ID = Account.Cust_ID
JOIN
    Transaction
    ON Account.Account_ID = Transaction.Account_ID
GROUP BY
    Customer.Cust_ID,
    Customer.FullName
HAVING
    MIN(Transaction.Channel) = 'UPI'
    AND
    MAX(Transaction.Channel) = 'UPI';
-- Q33) Retrieve customers who do not have any transactions in the past 6 months.

SELECT
    Customer.Cust_ID,
    Customer.FullName,
    Customer.City
FROM
    Customer
LEFT JOIN
    Account
    ON Customer.Cust_ID = Account.Cust_ID
LEFT JOIN
    
    Transaction
    ON Account.Account_ID = Transaction.Account_ID
GROUP BY
    Customer.Cust_ID,
    Customer.FullName,
    Customer.City
HAVING
    MAX(Transaction.Txn_Date) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    OR
    MAX(Transaction.Txn_Date) IS NULL;
    
-- Q34) Identify top 5 high-value customers by total credits across all accounts.

SELECT
    Customer.Cust_ID,
    Customer.FullName,
    SUM(Transaction.Amount) AS Total_Credits
FROM
    Customer
JOIN
    Account
    ON Customer.Cust_ID = Account.Cust_ID
JOIN
    Transactio
    ON Account.Account_ID = Transaction.Account_ID
WHERE
    Transaction.Txn_Type = 'Credit'
GROUP BY
    Customer.Cust_ID,
    Customer.FullName
ORDER BY
    Total_Credits DESC
LIMIT 5;
-- Q35) Detect potential fraud — any single transaction above ₹100,000.
SELECT
    Transaction.Txn_ID,
    Transaction.Account_ID,
    Transaction.Txn_Date,
    Transaction.Txn_Type,
    Transaction.Amount,
    Transaction.Channel,
    Account.Cust_ID,
    Customer.FullName
FROM
    Transaction
JOIN
    Account
    ON Transaction.Account_ID = Account.Account_ID
JOIN
    Customer
    ON Account.Cust_ID = Customer.Cust_ID
WHERE
    Transaction.Amount > 100000
ORDER BY
    Transaction.Amount DESC;


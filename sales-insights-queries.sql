-- 1. Show all customer records
SELECT * FROM customers;

-- 2. Show transactions for Chennai market
SELECT * FROM transactions where market_code='Mark001';

-- 3. Show distrinct product codes that were sold in chennai
SELECT distinct product_code FROM transactions where market_code='Mark001';

-- 4. Show transactions in 2020 join by date table
SELECT transactions.*, date.* FROM transactions
INNER JOIN date ON transactions.order_date=date.date
where date.year=2020;

-- 5. Show total revenue in year 2020,
SELECT SUM(transactions.sales_amount)
FROM transactions
INNER JOIN date ON transactions.order_date=date.date
where date.year=2020;

-- 6. Show total revenue in year 2020 in Chennai
SELECT SUM(transactions.sales_amount)
FROM transactions
INNER JOIN date ON transactions.order_date=date.date
where date.year=2020 and transactions.market_code="Mark001";

-- 7. What is the total revenue, total profit across all states?
SELECT
    m.markets_name AS State,
    SUM(t.sales_qty * t.cost_price) AS Revenue,
    SUM(t.sales_qty * (t.sales_amount - t.cost_price)) AS Profit
FROM transactions t
JOIN markets m ON t.market_code = m.markets_code
GROUP BY t.market_code;

-- 8. Which states generate the highest revenue?
SELECT m.markets_name, SUM(t.sales_amount*t.sales_qty) AS Revenue
FROM transactions t JOIN markets m ON t.market_code = m.markets_code
GROUP BY markets_name
ORDER BY Revenue DESC;

-- 9. Which states are running at a loss and need attention?
SELECT m.markets_name, SUM(sales_qty*(t.sales_amount-t.cost_price)) AS Profit
FROM transactions t
JOIN markets m ON t.market_code = m.markets_code
GROUP BY markets_name
HAVING Profit < 0
ORDER BY Profit ASC;

-- 10. Who are the top customers by revenue?
SELECT customer_code, SUM(sales_qty * sales_amount) AS Revenue
FROM transactions
GROUP BY customer_code
ORDER BY Revenue DESC LIMIT 5;
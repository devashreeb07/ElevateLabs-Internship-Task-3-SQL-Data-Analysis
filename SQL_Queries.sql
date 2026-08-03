CREATE DATABASE ecommerce_db;
USE ecommerce_db;
SHOW DATABASES;
SELECT DATABASE();
SHOW TABLES;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;
SELECT * FROM categories;
SELECT * FROM customers;
SELECT customer_name, city FROM customers;
SELECT * FROM products;
SELECT * FROM products ORDER BY price ASC;
SELECT * FROM products ORDER BY price DESC;
SELECT * FROM products WHERE price > 1000;
SELECT * FROM orders WHERE status = 'Delivered';
SELECT * FROM customers WHERE city = 'Chennai';
# Aggregate Functions
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_orders FROM orders;
SELECT AVG(price) AS average_price FROM products;
SELECT MAX(price) AS highest_price FROM products;
SELECT MIN(price) AS lowest_price FROM products;
SELECT SUM(amount) AS total_revenue FROM payments;
SELECT status, COUNT(*) AS total_orders FROM orders GROUP BY status;
SELECT category_id, AVG(price) AS average_price FROM products GROUP BY category_id;
SELECT category_id, AVG(price) AS average_price FROM products GROUP BY category_id HAVING AVG(price) > 2000;

# SQL Joins
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    o.status
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.status
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

SELECT
    c.customer_name,
    o.order_id,
    o.status
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

SELECT
    c.customer_name,
    o.order_id,
    p.amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN payments p
ON o.order_id = p.order_id;

SELECT
    c.customer_name,
    pr.product_name,
    oi.quantity,
    oi.unit_price
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products pr
ON oi.product_id = pr.product_id;

SELECT
    c.customer_name,
    SUM(p.amount) AS total_spent
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;
#sub queries

SELECT product_name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);

SELECT product_name
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM order_items
);

SELECT *
FROM payments
WHERE amount = (
    SELECT MAX(amount)
    FROM payments
);

SELECT c.customer_name, p.amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
WHERE p.amount > (
    SELECT AVG(amount)
    FROM payments
);

# sql views

CREATE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    p.amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id;

SELECT * FROM customer_order_summary;

SELECT *
FROM customer_order_summary
WHERE amount > 5000;

# SQL indexes

CREATE INDEX idx_customer_name
ON customers(customer_name(50));


CREATE INDEX idx_order_date
ON orders(order_date(20));

SHOW INDEXES FROM customers;
SHOW INDEXES FROM orders;

SELECT
    product_id,
    product_name,
    price
FROM products
ORDER BY price DESC
LIMIT 5;

SELECT
    payment_method,
    SUM(amount) AS total_revenue
FROM payments
GROUP BY payment_method
ORDER BY total_revenue DESC;
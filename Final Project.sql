create  database final_project;
use final_project;

#Inner Join for Order Details

SELECT o.order_id, o.order_date, oi.product_id, p.product_name,
       oi.quantity, oi.list_price, oi.discount, oi.total_price
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id;

#Total Sales by Store

SELECT o.store_id, SUM(oi.total_price) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.store_id;

#Top 5 Selling Products

SELECT p.product_id, p.product_name, SUM(oi.quantity) AS total_qty_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_qty_sold DESC
LIMIT 5;

#Customer Purchase Summary
SELECT c.customer_id, c.first_name, c.last_name,
       COUNT(DISTINCT o.order_id) AS total_orders,
       SUM(oi.quantity) AS total_items_purchased,
       SUM(oi.total_price) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name;

#Segment Customers by Total Spend
SELECT c.customer_id, c.first_name, c.last_name,
       SUM(oi.total_price) AS total_spend,
       CASE
           WHEN SUM(oi.total_price) < 1000 THEN 'Low'
           WHEN SUM(oi.total_price) BETWEEN 1000 AND 5000 THEN 'Medium'
           ELSE 'High'
       END AS spend_segment
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name;

#Staff Performance Analysis
SELECT s.staff_id, s.first_name, s.last_name,
       COUNT(DISTINCT o.order_id) AS orders_handled,
       SUM(oi.total_price) AS total_revenue
FROM staffs s
JOIN orders o ON s.staff_id = o.staff_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY s.staff_id, s.first_name, s.last_name
ORDER BY total_revenue DESC;

#Stock Alert Query

SELECT st.store_id, s.store_name, st.product_id, p.product_name, st.quantity
FROM stocks st
JOIN stores s ON st.store_id = s.store_id
JOIN products p ON st.product_id = p.product_id
WHERE st.quantity < 10;

#Customer segmentaion

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.total_price) AS total_spend,
CASE
        WHEN SUM(oi.total_price) < 1000 THEN 'Low'
        WHEN SUM(oi.total_price) BETWEEN 1000 AND 5000 THEN 'Medium'
        ELSE 'High'
    END AS spend_segment
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name;



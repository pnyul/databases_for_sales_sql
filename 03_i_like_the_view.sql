CREATE INDEX customer_sales_product 
ON sales(customer_id, product_id);

CREATE VIEW sales_summary
AS
SELECT
   products.model,
   SUM(sales.quantity) as total_sold
FROM
products, sales
WHERE products.product_id = sales.product_id
GROUP BY products.model
ORDER BY total_sold DESC;

SELECT * FROM sales_summary;
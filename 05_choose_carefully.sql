SELECT
    model, price, ((SELECT SUM(quantity) FROM sales WHERE sales.product_id = products.product_id) * price) AS total_sale_per_model,
    (SELECT quantity FROM inventory WHERE products.product_id = inventory.product_id) AS inventory_per_model,
    (((SELECT SUM(quantity) FROM sales WHERE sales.product_id = products.product_id) * price) / (SELECT quantity FROM inventory WHERE products.product_id = inventory.product_id)) AS sales_inventory_ratio
FROM products
ORDER BY
    sales_inventory_ratio
DESC;
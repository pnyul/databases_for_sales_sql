SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS employee_name, (SELECT position FROM employees WHERE employee_name = CONCAT(employees.first_name, ' ', employees.last_name)) AS position, (DATE_FORMAT((SELECT MAX(sale_date) FROM sales), '%M %Y')) AS month_year,
             CASE 
             WHEN SUM(sales.quantity) / (SELECT SUM(sales.quantity) FROM sales) * 100 < 5 THEN 0
             WHEN SUM(sales.quantity) / (SELECT SUM(sales.quantity) FROM sales) * 100 >= 5 AND SUM(sales.quantity) / (SELECT SUM(sales.quantity) FROM sales) * 100 < 10 THEN 2000
             WHEN SUM(sales.quantity) / (SELECT SUM(sales.quantity) FROM sales) * 100 >= 10 AND SUM(sales.quantity) / (SELECT SUM(sales.quantity) FROM sales) * 100 < 20 THEN 5000 
             WHEN SUM(sales.quantity) / (SELECT SUM(sales.quantity) FROM sales) * 100 >= 20 AND SUM(sales.quantity) / (SELECT SUM(sales.quantity) FROM sales) * 100 < 30 THEN 10000
             WHEN SUM(sales.quantity) / (SELECT SUM(sales.quantity) FROM sales) * 100 >= 30 AND SUM(sales.quantity) / (SELECT SUM(sales.quantity) FROM sales) * 100 < 40 THEN 15000
             ELSE 25000
             END AS employee_bonus
FROM employees, sales
WHERE
employees.employee_id = sales.employee_id
AND
employees.position = 'Sales Associate'
GROUP BY
employee_name;
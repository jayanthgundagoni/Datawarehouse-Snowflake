-- Query to calculate the total number of products ordered per department:
SELECT
    d.department,
    COUNT(*) AS total_products_ordered
FROM
    fact_order_products fop
JOIN
    dim_departments d ON fop.department_id = d.department_id
GROUP BY
    d.department;

-- Query to find the top 5 aisles with the highest number of reordered products:
SELECT
    aisle,
    COUNT(*) AS total_reordered
FROM
    fact_order_products fop
JOIN
    dim_aisles a ON fop.aisle_id = a.aisle_id
WHERE
    fop.reordered = TRUE
GROUP BY 
    a.aisle
ORDER BY
    total_reordered DESC LIMIT 5;

--Query to calculate the average number of products added to the cart per order by day of the week
SELECT
    o.order_dow,
    AVG(fop.add_to_cart_order) AS avg_products_per_order
FROM
    fact_order_products fop
JOIN
    dim_orders o ON fop.order_id = o.order_id
GROUP BY
    o.order_dow;

--Query to identify top 10 users with the highest number of unique products ordered:
SELECT
  u.user_id,
  COUNT(DISTINCT fop.product_id) AS unique_products_ordered
FROM
  fact_order_products fop
JOIN
  dim_users u ON fop.user_id = u.user_id
GROUP BY
  u.user_id
ORDER BY
  unique_products_ordered DESC
LIMIT 10;
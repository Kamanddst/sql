SELECT *
FROM customer


SELECT *
FROM customer
ORDER by customer_last_name, customer_first_name
LIMIT 10


SELECT *
FROM customer_purchases 
WHERE product_id IN (4,9)


SELECT *, (quantity * cost_to_customer_per_qty) as price
FROM customer_purchases
WHERE vendor_id BETWEEN 8 AND 10;

SELECT product_id, product_name,
CASE WHEN product_qty_type = 'unit'
		THEN 'unit'
		ELSE 'bulk'
	END as prod_qty_type_condensed,
	CASE WHEN product_name like '%pepper%'
		THEN 1
		ELSE 0
	END as pepper_flag
FROM product


SELECT *
FROM vendor as v
JOIN vendor_booth_assignments as va
	ON v.vendor_id = va.vendor_id
	ORDER by v.vendor_name, va.market_date
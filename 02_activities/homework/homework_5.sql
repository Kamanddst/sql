-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

	WITH VendorProducts AS (
    SELECT  
		v.vendor_name,
		vi.original_price,
		vi.quantity,
		p.product_name
	  FROM vendor as v
	JOIN vendor_inventory as vi
	on v.vendor_id = vi.vendor_id
	JOIN product as p
	on vi.product_id = p.product_id
),
CustomerCount AS (
    SELECT COUNT(DISTINCT customer_id) AS total_customers
    FROM customer_purchases
)

SELECT 
    vp.vendor_name,
    vp.product_name,
    (5 * cc.total_customers * vp.original_price ) AS total_revenue
FROM 
    VendorProducts AS vp
CROSS JOIN 
    CustomerCount AS cc
GROUP by vp.product_name, vp.vendor_name



	

-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */
DROP TABLE IF EXISTS product_units;
CREATE TEMP TABLE product_units AS 
SELECT 
    *,
    CURRENT_TIMESTAMP AS snapshot_timestamp
FROM 
    product
WHERE 
    product_qty_type = 'unit';
	

/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

	
INSERT  INTO product_units 
VALUES(101, 'ApplePie', '10"', 3,'unit',CURRENT_TIMESTAMP);


-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/


DELETE FROM product_units
WHERE 
    product_name = 'Apple Pie'
    AND snapshot_timestamp < CURRENT_TIMESTAMP;

-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */


ALTER TABLE product_units
ADD current_quantity INT;

WITH last_quantity As(
SELECT 
product_id,
market_date, 
quantity,
ROW_NUMBER() OVER (PARTITION BY product_id ORDER by market_date DESC) as latest_quantity
FROM vendor_inventory as v
)

UPDATE product_units 
Set current_quantity = coalesce((
SELECT 
lq.quantity
FROM last_quantity as lq
WHERE lq.product_id = product_units.product_id and latest_quantity = 1)
,0);



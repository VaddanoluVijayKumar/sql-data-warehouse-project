SELECT
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) >1  OR prd_id IS NULL


--Expectation: NO results
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT*
FROM silver.crm_cust_info

SELECT prd_nm
FROM bronze.crm_prd_info
WHERE  prd_nm != TRIM(prd_nm);

SELECT prd_cost
FROM silver.crm_prd_info
WHERE  prd_cost< 0 OR prd_cost is null;


SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

SELECT*
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT * FROM silver.crm_sales_details

SELECT DISTINCT
sls_sales AS old_sls_sales, 
sls_quantity, 
sls_price AS old_sls_price,
CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
		THEN sls_quantity * ABS(sls_price)
	 ELSE sls_sales
END AS sls_sales,
CASE WHEN sls_price IS NULL OR sls_price <=0 
		THEN sls_sales / NULLIF(sls_quantity, 0) 
	 ELSE sls_price 
END AS sls_price

FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <=0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price


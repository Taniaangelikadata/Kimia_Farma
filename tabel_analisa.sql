CREATE TABLE base_table AS
SELECT
	kft.transaction_id, 
	kft.date, 
	kft.branch_id,
	kfc.branch_name, 
	kfc.kota, 
	kfc.provinsi, 
	kfc.rating AS rating_cabang, 
	kft.product_id, 
	kp.product_name, 
	kft.price, 
	kft.discount_percentage,
	CASE
        WHEN kp.price <= 50000 THEN 0.1
        WHEN kp.price > 50000 AND kp.price <= 100000 THEN 0.15
        WHEN kp.price > 100000 AND kp.price <= 300000 THEN 0.2
        WHEN kp.price > 300000 AND kp.price <= 500000 THEN 0.25
        WHEN kp.price > 500000 THEN 0.3
    END AS persentase_gross_laba,
	kp.price *(1-kft.discount_percentage) AS nett_sales,
	(kp.price * (1 - kft.discount_percentage)) *
    CASE
        WHEN kp.price <= 50000 THEN 0.1
        WHEN kp.price > 50000 AND kp.price <= 100000 THEN 0.15
        WHEN kp.price > 100000 AND kp.price <= 300000 THEN 0.2
        WHEN kp.price > 300000 AND kp.price <= 500000 THEN 0.25
        WHEN kp.price > 500000 THEN 0.3
    END AS nett_profit,
	kft.rating AS rating_transaksi
FROM kf_final_transaction AS kft
JOIN kf_kantor_cabang as kfc on kft.branch_id = kfc.branch_id
JOIN kf_product as kp on kft.product_id = kp.product_id;

SELECT * FROM base_table
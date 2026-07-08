CREATE DATABASE IF NOT EXISTS unir_telco_lab10;
CREATE EXTERNAL TABLE IF NOT EXISTS audit (
  customer_id string,
  region string,
  zone_type string,
  tenure_months int,
  monthly_price double,
  y_true int,
  y_pred int,
  y_score double
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ('separatorChar'=',', 'quoteChar'='"', 'escapeChar'='\\')
STORED AS TEXTFILE
LOCATION 's3://<tu-bucket>/audit/'
TBLPROPERTIES ('skip.header.line.count'='1');

SELECT ROUND(AVG(CASE WHEN y_true = y_pred THEN 1.0 ELSE 0 END), 3) AS accuracy_global
FROM audit;

SELECT region, COUNT(*) AS clientes,
 ROUND(AVG(CASE WHEN y_true = y_pred THEN 1.0 ELSE 0 END), 3) AS accuracy
FROM audit
GROUP BY region
ORDER BY accuracy ASC;

SELECT region,
 SUM(CASE WHEN y_pred=1 AND y_true=0 THEN 1 ELSE 0 END) AS falsos_positivos,
 SUM(CASE WHEN y_pred=0 AND y_true=1 THEN 1 ELSE 0 END) AS falsos_negativos,
 ROUND(AVG(CASE WHEN y_true=1 AND y_pred=1 THEN 1.0 WHEN y_true=1 THEN 0 END), 3) AS recall,
 ROUND(AVG(CASE WHEN y_pred=1 AND y_true=1 THEN 1.0 WHEN y_pred=1 THEN 0 END), 3) AS precision
FROM audit
GROUP BY region
ORDER BY recall ASC;

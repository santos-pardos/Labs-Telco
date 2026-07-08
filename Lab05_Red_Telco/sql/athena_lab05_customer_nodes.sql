CREATE DATABASE IF NOT EXISTS unir_telco_lab5;
CREATE EXTERNAL TABLE IF NOT EXISTS customer_nodes (
  customer_id string,
  access_node_id string,
  region string,
  zone string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ('separatorChar'=',', 'quoteChar'='"', 'escapeChar'='\\')
STORED AS TEXTFILE
LOCATION 's3://<tu-bucket>/graph/customers/'
TBLPROPERTIES ('skip.header.line.count'='1');

SELECT access_node_id, region, COUNT(*) AS clientes
FROM customer_nodes
GROUP BY access_node_id, region
ORDER BY clientes DESC
LIMIT 15;

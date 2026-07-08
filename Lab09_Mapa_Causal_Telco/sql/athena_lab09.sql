CREATE DATABASE IF NOT EXISTS unir_telco_lab9;
CREATE EXTERNAL TABLE IF NOT EXISTS causal (
  customer_id string,
  region string,
  calidad_tecnica double,
  interrupciones_30d int,
  brecha_velocidad_pct double,
  tiempo_resolucion_h double,
  reclamaciones_30d int,
  insatisfaccion double,
  precio_mensual double,
  churn int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ('separatorChar'=',', 'quoteChar'='"', 'escapeChar'='\\')
STORED AS TEXTFILE
LOCATION 's3://<tu-bucket>/causal/'
TBLPROPERTIES ('skip.header.line.count'='1');

SELECT churn,
 ROUND(AVG(calidad_tecnica), 3) AS calidad,
 ROUND(AVG(interrupciones_30d), 2) AS interrupciones,
 ROUND(AVG(brecha_velocidad_pct), 2) AS brecha,
 ROUND(AVG(reclamaciones_30d), 2) AS reclamaciones,
 ROUND(AVG(insatisfaccion), 2) AS insatisfaccion,
 ROUND(AVG(precio_mensual), 2) AS precio
FROM causal
GROUP BY churn;

SELECT region,
 ROUND(AVG(calidad_tecnica), 3) AS calidad,
 ROUND(AVG(interrupciones_30d), 2) AS interrupciones,
 ROUND(AVG(reclamaciones_30d), 2) AS reclamaciones,
 ROUND(AVG(insatisfaccion), 2) AS insatisfaccion,
 ROUND(AVG(churn) * 100, 1) AS pct_churn
FROM causal
GROUP BY region
ORDER BY calidad DESC;

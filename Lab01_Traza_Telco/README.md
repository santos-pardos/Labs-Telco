## SQL Code

```
CREATE EXTERNAL TABLE IF NOT EXISTS network_events (
    event_id            string,
    event_timestamp     string,
    node_id             string,
    region              string,
    event_type          string,
    severity            string,
    duration_seconds    int,
    affected_customers  int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    'separatorChar' = ',',
    'quoteChar'     = '"',
    'escapeChar'    = '\\'
)
STORED AS TEXTFILE
LOCATION 's3://<tu-bucket>/raw/network_events/'
TBLPROPERTIES ('skip.header.line.count' = '1');
```

```
CREATE EXTERNAL TABLE IF NOT EXISTS customers (
    customer_id      string,
    region           string,
    contract_type    string,
    monthly_price    double,
    tenure_months    int,
    signup_date      string,
    active           int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    'separatorChar' = ',',
    'quoteChar'     = '"',
    'escapeChar'    = '\\'
)
STORED AS TEXTFILE
LOCATION 's3://<tu-bucket>/raw/customers/'
TBLPROPERTIES ('skip.header.line.count' = '1');
```



```
CREATE EXTERNAL TABLE IF NOT EXISTS tickets (
    ticket_id          string,
    event_timestamp    string,
    customer_id        string,
    category           string,
    status             string,
    priority           string,
    resolution_hours   string,
    description        string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    'separatorChar' = ',',
    'quoteChar'     = '"',
    'escapeChar'    = '\\'
)
STORED AS TEXTFILE
LOCATION 's3://<tu-bucket>/raw/tickets/'
TBLPROPERTIES ('skip.header.line.count' = '1');
```


```
CREATE EXTERNAL TABLE IF NOT EXISTS call_center_contacts (
    contact_id         string,
    event_timestamp    string,
    customer_id        string,
    channel            string,
    reason             string,
    duration_minutes   double,
    resolved           int,
    agent_id           string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    'separatorChar' = ',',
    'quoteChar'     = '"',
    'escapeChar'    = '\\'
)
STORED AS TEXTFILE
LOCATION 's3://<tu-bucket>/raw/call_center_contacts/'
TBLPROPERTIES ('skip.header.line.count' = '1');
```


```
CREATE EXTERNAL TABLE IF NOT EXISTS network_metrics (
    event_timestamp     string,
    region              string,
    avg_download_mbps   double,
    avg_upload_mbps     double,
    avg_latency_ms      double,
    packet_loss_pct     double,
    active_users        int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    'separatorChar' = ',',
    'quoteChar'     = '"',
    'escapeChar'    = '\\'
)
STORED AS TEXTFILE
LOCATION 's3://<tu-bucket>/raw/network_metrics/'
TBLPROPERTIES ('skip.header.line.count' = '1');
```


```
CREATE EXTERNAL TABLE IF NOT EXISTS complaints (
    complaint_id     string,
    event_timestamp  string,
    customer_id      string,
    region           string,
    channel          string,
    sentiment_label  string,
    text             string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    'separatorChar' = ',',
    'quoteChar'     = '"',
    'escapeChar'    = '\\'
)
STORED AS TEXTFILE
LOCATION 's3://<tu-bucket>/raw/complaints/'
TBLPROPERTIES ('skip.header.line.count' = '1');
```

```
SHOW TABLES IN unir_telco_lab1;
```
```
SELECT COUNT(*) AS total FROM network_events;
SELECT COUNT(*) AS total FROM customers;
SELECT COUNT(*) AS total FROM tickets;
SELECT COUNT(*) AS total FROM call_center_contacts;
SELECT COUNT(*) AS total FROM network_metrics;
SELECT COUNT(*) AS total FROM complaints;
```

```
SELECT event_type,
       severity,
       COUNT(*)                       AS total_eventos,
       ROUND(AVG(duration_seconds), 0) AS duracion_media_seg,
       SUM(affected_customers)        AS total_afectados
FROM   network_events
GROUP BY event_type, severity
ORDER BY total_eventos DESC;
```

```
SELECT region,
       contract_type,
       COUNT(*)                  AS total_clientes,
       ROUND(AVG(monthly_price), 2) AS precio_medio,
       ROUND(AVG(tenure_months), 1) AS antiguedad_media_meses,
       SUM(active)               AS activos
FROM   customers
GROUP BY region, contract_type
ORDER BY region, total_clientes DESC;
```


```
SELECT category,
       priority,
       status,
       COUNT(*) AS total
FROM   tickets
GROUP BY category, priority, status
ORDER BY total DESC
LIMIT 20;
```


```
SELECT ticket_id, category, priority, description
FROM   tickets
WHERE  priority IN ('alta', 'critica')
ORDER BY event_timestamp DESC
LIMIT 10;
```

```
SELECT channel,
       reason,
       COUNT(*)                    AS total_contactos,
       ROUND(AVG(duration_minutes), 1) AS duracion_media_min,
       SUM(resolved)               AS resueltos
FROM   call_center_contacts
GROUP BY channel, reason
ORDER BY total_contactos DESC
LIMIT 20;
```

```
SELECT region,
       ROUND(AVG(avg_download_mbps), 1) AS download_medio,
       ROUND(AVG(avg_latency_ms), 1)    AS latencia_media,
       ROUND(AVG(packet_loss_pct), 3)   AS perdida_media,
       ROUND(MIN(avg_download_mbps), 1) AS download_minimo,
       ROUND(MAX(avg_latency_ms), 1)    AS latencia_maxima
FROM   network_metrics
GROUP BY region
ORDER BY download_medio DESC;
```

```
SELECT region,
       CAST(substr(event_timestamp, 12, 2) AS int) AS hora,
       ROUND(AVG(avg_download_mbps), 1) AS download_medio,
       ROUND(AVG(avg_latency_ms), 1)    AS latencia_media
FROM   network_metrics
GROUP BY region,
         CAST(substr(event_timestamp, 12, 2) AS int)
ORDER BY region, hora;
```

```
SELECT sentiment_label,
       channel,
       COUNT(*) AS total
FROM   complaints
GROUP BY sentiment_label, channel
ORDER BY total DESC;
```

```
SELECT region, channel, sentiment_label,
       substr(text, 1, 200) AS extracto
FROM   complaints
WHERE  sentiment_label = 'negativo'
ORDER BY event_timestamp DESC
LIMIT 10;
```



```
SELECT 'network_events' AS dataset,
       MIN(event_timestamp) AS desde,
       MAX(event_timestamp) AS hasta,
       COUNT(*)             AS filas
FROM   network_events
UNION ALL
SELECT 'tickets',
       MIN(event_timestamp), MAX(event_timestamp), COUNT(*)
FROM   tickets
UNION ALL
SELECT 'call_center_contacts',
       MIN(event_timestamp), MAX(event_timestamp), COUNT(*)
FROM   call_center_contacts
UNION ALL
SELECT 'network_metrics',
       MIN(event_timestamp), MAX(event_timestamp), COUNT(*)
FROM   network_metrics
UNION ALL
SELECT 'complaints',
       MIN(event_timestamp), MAX(event_timestamp), COUNT(*)
FROM   complaints;
```


```
SELECT 'nodos en network_events' AS metrica, COUNT(DISTINCT node_id) AS valor FROM network_events
UNION ALL
SELECT 'clientes en customers', COUNT(DISTINCT customer_id) FROM customers
UNION ALL
SELECT 'clientes en tickets', COUNT(DISTINCT customer_id) FROM tickets
UNION ALL
SELECT 'clientes en contactos', COUNT(DISTINCT customer_id) FROM call_center_contacts
UNION ALL
SELECT 'clientes en complaints', COUNT(DISTINCT customer_id) FROM complaints
UNION ALL
SELECT 'regiones en network_metrics', COUNT(DISTINCT region) FROM network_metrics;
```


```
SELECT t.category,
       c.region,
       c.contract_type,
       COUNT(*) AS total_tickets
FROM   tickets t
JOIN   customers c ON t.customer_id = c.customer_id
GROUP BY t.category, c.region, c.contract_type
ORDER BY total_tickets DESC
LIMIT 25;
```

```
SELECT region,
       severity,
       COUNT(*)                AS eventos,
       SUM(affected_customers) AS total_afectados
FROM   network_events
GROUP BY region, severity
ORDER BY region, severity;
```

```
SELECT c.region,
       cc.channel,
       COUNT(*)                       AS contactos,
       ROUND(AVG(cc.duration_minutes), 1) AS duracion_media
FROM   call_center_contacts cc
JOIN   customers c ON cc.customer_id = c.customer_id
GROUP BY c.region, cc.channel
ORDER BY c.region, contactos DESC;
```

```
DROP TABLE IF EXISTS network_events;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS call_center_contacts;
DROP TABLE IF EXISTS network_metrics;
DROP TABLE IF EXISTS complaints;
DROP DATABASE IF EXISTS unir_telco_lab1;
```



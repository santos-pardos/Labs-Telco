## Code

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

```

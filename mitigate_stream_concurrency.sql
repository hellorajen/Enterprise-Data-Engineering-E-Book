SQL
-- Step 1.1: Enable Row-Level Concurrency on the Core Silver Tables
ALTER TABLE silver.hub_customer SET TBLPROPERTIES (
  'delta.enableRowLevelConcurrency' = 'true',
  'delta.isolationLevel' = 'WriteSerializable'
);

-- Step 1.2: Idempotent Micro-Batch Merge Strategy for High-Frequency Ingestion
MERGE INTO silver.sat_customer_details AS target
USING (
  SELECT 
    sha2(lower(trim(Customer_ID)), 256) AS customer_hk,
    current_timestamp() AS load_date,
    'KAFKA_STREAM_SALES' AS record_source,
    Customer_Name,
    Credit_Score,
    Risk_Segment
  FROM raw_sales_stream_buffer
) AS source
ON target.customer_hk = source.customer_hk 
   AND target.load_date = source.load_date
WHEN NOT MATCHED THEN
  INSERT (customer_hk, load_date, record_source, customer_name, credit_score, risk_segment)
  VALUES (source.customer_hk, source.load_date, source.record_source, source.customer_name, source.credit_score, source.risk_segment);

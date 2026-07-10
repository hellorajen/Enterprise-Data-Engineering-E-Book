SQL
-- Inferred Member Ingestion Script inside Gold Presentation Pipeline
MERGE INTO gold.dim_customer AS target
USING (
  SELECT DISTINCT 
    customer_hk,
    'INFERRED_STREAMING_PLACEHOLDER' AS customer_name,
    'Y' AS is_inferred_member,
    current_timestamp() AS valid_from,
    to_timestamp('9999-12-31 23:59:59') AS valid_to
  FROM gold.fact_policy_transactions_buffer
) AS source
ON target.customer_hk = source.customer_hk
WHEN NOT MATCHED THEN
  INSERT (customer_hk, customer_name, is_inferred_member, valid_from, valid_to)
  VALUES (source.customer_hk, source.customer_name, source.is_inferred_member, source.valid_from, source.valid_to);

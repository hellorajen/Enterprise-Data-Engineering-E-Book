SQL
-- Transforming Raw Bronze Data into Typed Operational Silver Tables
CREATE OR REPLACE TABLE Dw_Silver.Ods_Web_Interactions 
USING DELTA
AS
SELECT
    get_json_object(Raw_Payload, '$.session_id') AS Session_ID,
    CAST(get_json_object(Raw_Payload, '$.user_id') AS BIGINT) AS User_ID,
    CAST(get_json_object(Raw_Payload, '$.event_time') AS TIMESTAMP) AS Event_Time,
    get_json_object(Raw_Payload, '$.page_url') AS Page_URL,
    Ingest_Timestamp
FROM 
    Dw_Bronze.Streaming_Clickstream
WHERE 
    get_json_object(Raw_Payload, '$.session_id') IS NOT NULL;

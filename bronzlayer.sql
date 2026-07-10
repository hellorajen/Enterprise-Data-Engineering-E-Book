SQL
-- Creating a High-Performance Streaming Landing Zone in the Bronze Layer
CREATE TABLE Dw_Bronze.Streaming_Clickstream (
    Raw_Payload     STRING,
    Ingest_Timestamp TIMESTAMP,
    Source_File_Name STRING
) USING DELTA
LOCATION 's3a://enterprise-lakehouse/bronze/streaming_clickstream';

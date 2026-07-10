SQL
-- Building a Production-Grade Gold Fact Table with Liquid Clustering
CREATE TABLE Dw_Gold.Fact_Web_Sales_Delta (
    Sales_Transaction_ID STRING NOT NULL,
    Customer_SCD_Key     INT NOT NULL,
    Product_SCD_Key      INT NOT NULL,
    Order_Date_Key       INT NOT NULL,
    Gross_Revenue_CAD    DECIMAL(18,2),
    Quantity_Ordered     INT
) USING DELTA
CLUSTER BY (Order_Date_Key, Customer_SCD_Key) -- Liquid Clustering for instant query pruning
LOCATION 's3a://enterprise-lakehouse/gold/fact_web_sales';

----------------

SQL
-- Nightly Lakehouse Maintenance: Compact Files and Purge Obsolete Log History
OPTIMIZE Dw_Gold.Fact_Web_Sales_Delta;
VACUUM Dw_Gold.Fact_Web_Sales_Delta RETAIN 7 DAYS;

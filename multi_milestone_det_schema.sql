SQL
CREATE TABLE Dw_Gold.Fact_Order_Fulfillment_Snapshot (
    Order_ID_NK                 STRING NOT NULL, -- Natural Business Key
    Customer_SCD_Key            INT NOT NULL,    -- Link to Conformed Customer Dimension
    Product_SCD_Key             INT NOT NULL,    -- Link to Conformed Product Dimension
    
    -- Milestone Date Keys (Chronological Sequence)
    Order_Placed_Date_Key       INT NOT NULL,    -- e.g., 20261201
    Inventory_Alloc_Date_Key    INT NOT NULL,    -- Initially 19000101
    Carrier_Shipped_Date_Key    INT NOT NULL,    -- Initially 19000101
    Customer_Delivered_Date_Key INT NOT NULL,    -- Initially 19000101
    Invoice_Paid_Date_Key       INT NOT NULL,    -- Initially 19000101
    
    -- Degenerate Dimensions for Operational Context
    Fulfillment_Status_Code     STRING,
    
    -- Fact Degenerate Metrics (Quantities)
    Order_Qty                   INT,
    Gross_Amount_CAD            DECIMAL(18,2),
    
    -- Operational Velocity Lag Metrics (Calculated Directly In-Row)
    Days_From_Order_To_Alloc    INT,             -- Order to Warehouse Allocation Lag
    Days_From_Alloc_To_Ship     INT,             -- Warehouse to Carrier Lag
    Days_From_Ship_To_Deliver   INT,             -- Carrier Transit Lag
    Total_Cycle_Time_Days       INT              -- Absolute End-to-End Velocity
);

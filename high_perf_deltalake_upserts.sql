
SQL
-- Daily Delta Lake Pipeline Execution for Accumulating Snapshots
MERGE INTO Dw_Gold.Fact_Order_Fulfillment_Snapshot AS target
USING Dw_Silver.Stg_Operational_Pipeline_Updates AS source
ON target.Order_ID_NK = source.Order_ID_NK

WHEN MATCHED THEN
  UPDATE SET 
    target.Inventory_Alloc_Date_Key = COALESCE(source.Alloc_Date_Key, target.Inventory_Alloc_Date_Key),
    target.Carrier_Shipped_Date_Key = COALESCE(source.Ship_Date_Key, target.Carrier_Shipped_Date_Key),
    target.Customer_Delivered_Date_Key = COALESCE(source.Delivery_Date_Key, target.Customer_Delivered_Date_Key),
    target.Invoice_Paid_Date_Key   = COALESCE(source.Payment_Date_Key, target.Invoice_Paid_Date_Key),
    target.Fulfillment_Status_Code   = source.Current_Status,
    
    -- Recalculate operational velocity lags automatically upon state change
    target.Days_From_Order_To_Alloc  = CASE 
        WHEN source.Alloc_Date_Key IS NOT NULL THEN DATEDIFF(day, TO_DATE(CAST(target.Order_Placed_Date_Key AS STRING), 'yyyyMMdd'), TO_DATE(CAST(source.Alloc_Date_Key AS STRING), 'yyyyMMdd'))
        ELSE target.Days_From_Order_To_Alloc END,
        
    target.Days_From_Alloc_To_Ship   = CASE 
        WHEN source.Ship_Date_Key IS NOT NULL AND target.Inventory_Alloc_Date_Key != 19000101 THEN DATEDIFF(day, TO_DATE(CAST(target.Inventory_Alloc_Date_Key AS STRING), 'yyyyMMdd'), TO_DATE(CAST(source.Ship_Date_Key AS STRING), 'yyyyMMdd'))
        ELSE target.Days_From_Alloc_To_Ship END,
        
    target.Total_Cycle_Time_Days     = CASE 
        WHEN source.Payment_Date_Key IS NOT NULL THEN DATEDIFF(day, TO_DATE(CAST(target.Order_Placed_Date_Key AS STRING), 'yyyyMMdd'), TO_DATE(CAST(source.Payment_Date_Key AS STRING), 'yyyyMMdd'))
        ELSE NULL END

WHEN NOT MATCHED THEN
  INSERT (Order_ID_NK, Customer_SCD_Key, Product_SCD_Key, Order_Placed_Date_Key, Inventory_Alloc_Date_Key, Carrier_Shipped_Date_Key, Customer_Delivered_Date_Key, Invoice_Paid_Date_Key, Fulfillment_Status_Code, Order_Qty, Gross_Amount_CAD, Days_From_Order_To_Alloc, Days_From_Alloc_To_Ship, Days_From_Ship_To_Deliver, Total_Cycle_Time_Days)
  VALUES (source.Order_ID_NK, source.Customer_SCD_Key, source.Product_SCD_Key, source.Order_Date_Key, 19000101, 19000101, 19000101, 19000101, 'ORDERED', source.Qty, source.Amount, NULL, NULL, NULL, NULL);

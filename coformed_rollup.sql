

SQL
-- Creating a Governed Conformed Subset Dimension for Logistics
CREATE VIEW Dw_Gold.Dim_Product_Logistics_Subset AS
SELECT 
    Product_SCD_Key, -- The exact conformed surrogate key from master
    Product_Natural_Id,
    Product_Name,
    Weight_KG,
    Dimensions_Cube_CM,
    Hazardous_Material_Flag
FROM 
    Dw_Gold.Dim_Product -- Reading directly from the Master Conformed Dimension
WHERE 
    Is_Physical_Item_Flag = 1;

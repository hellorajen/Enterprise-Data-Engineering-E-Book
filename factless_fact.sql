SQL
-- Implementing a Factless Fact Table to Track Non-Transactional Marketing Events
CREATE TABLE Dw_Gold.Fact_Customer_Digital_Touchpoints (
    Customer_SCD_Key       INT NOT NULL, -- Who looked
    Promotion_SCD_Key      INT NOT NULL, -- What they looked at
    Touchpoint_Date_Key    INT NOT NULL, -- When it happened
    Operating_System_Key   INT NOT NULL, -- Channel profile context
    CONSTRAINT FK_Fact_Touchpoint_Date FOREIGN KEY (Touchpoint_Date_Key) REFERENCES Dw_Gold.Dim_Date(Date_Key)
);

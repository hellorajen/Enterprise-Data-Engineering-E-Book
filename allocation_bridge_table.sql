SQL
-- Creating the Policy-to-Broker Allocation Bridge Table
CREATE TABLE Dw_Gold.Bridge_Policy_Broker (
    Policy_SCD_Key        INT NOT NULL, -- Links to Dim_Policy
    Broker_SCD_Key        INT NOT NULL, -- Links to Dim_Broker
    Allocation_Factor     DECIMAL(5,4) NOT NULL, -- e.g., 0.3333 for an even three-way split
    CONSTRAINT PK_Bridge_Policy_Broker PRIMARY KEY (Policy_SCD_Key, Broker_SCD_Key)
);

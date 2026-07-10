SQL
-- Consolidating Loose Operational Indicators into a Single Junk Dimension
CREATE TABLE Dw_Gold.Dim_Compliance_Profile_Junk (
    Compliance_Junk_Key      INT NOT NULL,
    Is_Paperless_Billing     CHAR(1) NOT NULL, -- 'Y' / 'N'
    Has_Underwriting_Approval CHAR(1) NOT NULL, -- 'Y' / 'N'
    Marketing_Opt_In         CHAR(1) NOT NULL, -- 'Y' / 'N'
    Digital_Signature_Status  STRING NOT NULL,  -- 'Signed', 'Pending', 'Waived'
    CONSTRAINT PK_Dim_Compliance_Junk PRIMARY KEY (Compliance_Junk_Key)
);

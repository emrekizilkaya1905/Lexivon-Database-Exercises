USE [BilRegister];
GO

IF OBJECT_ID(N'dbo.testTrigger', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.testTrigger (
        FirstName VARCHAR(50),
        LastName VARCHAR(50)
    );
END;
GO

SELECT * FROM dbo.testTrigger;
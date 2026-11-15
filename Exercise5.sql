
CREATE TABLE dbo.Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL
);
GO

INSERT INTO dbo.Customers (FirstName, LastName)
VALUES
(N'Mark', N'Andersson'),
(N'Astrid', N'Lindgren'),
(N'Anna', N'Nilsson'),
(N'Mark', N'Svensson'),
(N'Astrid', N'Johansson');
GO


CREATE PROCEDURE dbo.GetMarkAndAstrid
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CustomerID, FirstName, LastName
    FROM dbo.Customers
    WHERE FirstName IN (N'Mark', N'Astrid')
    ORDER BY FirstName DESC;
END;
GO


EXEC dbo.GetMarkAndAstrid;
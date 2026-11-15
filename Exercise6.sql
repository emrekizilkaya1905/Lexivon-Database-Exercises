-- A: Hämta kunder efter förnamn.
-- Standardvärdet är Mark.
CREATE PROCEDURE dbo.GetCustomersByFirstName
    @FirstName NVARCHAR(50) = N'Mark'
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CustomerID, FirstName, LastName
    FROM dbo.Customers
    WHERE FirstName = @FirstName;
END;
GO

-- Utan parameter: hämtar Mark.
EXEC dbo.GetCustomersByFirstName;
GO

-- Med parameter: hämtar Astrid.
EXEC dbo.GetCustomersByFirstName @FirstName = N'Astrid';
GO

-- Lägg till testdata med efternamn som börjar på P.
INSERT INTO dbo.Customers (FirstName, LastName)
VALUES
(N'Lars', N'Persson'),
(N'Anna', N'Pettersson');
GO

-- B: Hämta kunder vars efternamn börjar på P.
CREATE PROCEDURE dbo.GetCustomersWithLastNameStartingWithP
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CustomerID, FirstName, LastName
    FROM dbo.Customers
    WHERE LastName LIKE N'P%'
    ORDER BY LastName, FirstName;
END;
GO

-- Anropa proceduren.
EXEC dbo.GetCustomersWithLastNameStartingWithP;
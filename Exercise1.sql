CREATE TABLE Bilregister (
    Fnamn  NVARCHAR(50),
    Enamn  NVARCHAR(50),
    Adress NVARCHAR(100),
    Postnr VARCHAR(5),
    Stad   NVARCHAR(50),
    Telefon VARCHAR(20),
    Email  NVARCHAR(100),
    Marke  NVARCHAR(50),
    Modell NVARCHAR(50)
);

INSERT INTO Bilregister
    (Fnamn, Enamn, Adress, Postnr, Stad, Telefon, Email, Marke, Modell)
VALUES
(N'Lars', N'Persson', N'Skolg. 2', '23456', N'Hässleholm',
 '07212344', 'lars@live.se', N'Ferrari', N'F40'),

(N'Anna', N'Nilsson', N'Borgv. 4', '14577', N'Stockholm',
 '07012345', 'anna@live.se', N'Bugatti', N'Veyron'),

(N'Anna', N'Nilsson', N'Borgv. 4', '14577', N'Stockholm',
 '07012345', 'anna@live.se', N'Mercedes', N'C112'),

(N'Lars', N'Persson', N'Skolg. 2', '23456', N'Hässleholm',
 '07212344', 'lars@live.se', N'Toyota', N'Corolla'),

(N'Bo', N'Karlsson', N'Furuv. 8', '12388', N'Göteborg',
 '01055223', 'bo@live.se', N'Nissan', N'Pulsar'),

(N'Lars', N'Persson', N'Skolg. 2', '23456', N'Hässleholm',
 '07212344', 'lars@live.se', N'Ford', N'Mustang');

-- Uppgift 1: Lägg till två bilar för Bo Karlsson.
INSERT INTO Bilregister
    (Fnamn, Enamn, Adress, Postnr, Stad, Telefon, Email, Marke, Modell)
VALUES
(N'Bo', N'Karlsson', N'Furuv. 8', '12388', N'Göteborg',
 '01055223', 'bo@live.se', N'Volvo', N'XC60'),

(N'Bo', N'Karlsson', N'Furuv. 8', '12388', N'Göteborg',
 '01055223', 'bo@live.se', N'BMW', N'320i');

SELECT * FROM Bilregister;

/*
2. Varför är det inte bra att upprepa ägarens uppgifter?

Det ökar risken för fel vid inmatning och tar onödig plats.
Om ägaren exempelvis byter adress måste flera rader uppdateras.
Om vi missar en rad får vi olika adresser för samma person.

3. Vad är primärnyckel och sekundärnyckel?

En primärnyckel identifierar varje rad i en tabell.
Den måste vara unik och får inte vara NULL.

En sekundärnyckel (främmande nyckel) kopplar ihop tabeller.
Exempel: BilagareID i Bilar hänvisar till primärnyckeln
BilagareID i Bilagare.

Skillnaden är att primärnyckeln identifierar en rad,
medan den främmande nyckeln visar sambandet med en annan tabell.

4. Är personnummer ett bra val för en primärnyckel?

Personnummer kan identifiera en person, men jag skulle välja
ett separat ID som primärnyckel. Alla personer har inte ett
svenskt personnummer. Ett separat ID gör också att vi inte
behöver använda personnummer i tabellernas kopplingar.

5. Ska sekundärnyckeln vara unik?

Inte i denna en-till-många-relation.
Samma BilagareID måste kunna finnas på flera rader i Bilar,
eftersom en person kan äga flera bilar.
Varje bil får däremot ett eget unikt BilID som primärnyckel.

6. Vad är skillnaden på data och information?

Data är exempelvis siffror eller ord utan sammanhang.
Information är data som har fått mening genom ett sammanhang.
Exempel: 10 är data. Att en bil kostar 10 kronor är information.

7. Exempel på relationer:

En till en: En person har ett personnummer och ett
personnummer tillhör en person.

En till många: En bilägare kan äga flera bilar,
men varje bil har en registrerad ägare.

Många till många: En skådespelare kan medverka i flera filmer,
och en film kan ha flera skådespelare.
Detta löses med en kopplingstabell.
*/

-- Uppgift 8: Separera bilägare och bilar.

CREATE TABLE Bilagare (
    BilagareID INT IDENTITY(1,1) PRIMARY KEY,
    Fnamn NVARCHAR(50),
    Enamn NVARCHAR(50),
    Adress NVARCHAR(100),
    Postnr VARCHAR(5),
    Stad NVARCHAR(50),
    Telefon VARCHAR(20),
    Email NVARCHAR(100)
);

CREATE TABLE Bilar (
    BilID INT IDENTITY(1,1) PRIMARY KEY,
    Marke NVARCHAR(50),
    Modell NVARCHAR(50),
    BilagareID INT NOT NULL,
    FOREIGN KEY (BilagareID)
        REFERENCES Bilagare(BilagareID)
);

-- Varje ägare registreras endast en gång.
INSERT INTO Bilagare
    (Fnamn, Enamn, Adress, Postnr, Stad, Telefon, Email)
VALUES
(N'Lars', N'Persson', N'Skolg. 2', '23456',
 N'Hässleholm', '07212344', 'lars@live.se'),

(N'Anna', N'Nilsson', N'Borgv. 4', '14577',
 N'Stockholm', '07012345', 'anna@live.se'),

(N'Bo', N'Karlsson', N'Furuv. 8', '12388',
 N'Göteborg', '01055223', 'bo@live.se');

-- BilagareID kopplar varje bil till dess ägare.
-- 1 = Lars, 2 = Anna, 3 = Bo.
INSERT INTO Bilar (Marke, Modell, BilagareID)
VALUES
(N'Ferrari', N'F40', 1),
(N'Bugatti', N'Veyron', 2),
(N'Mercedes', N'C112', 2),
(N'Toyota', N'Corolla', 1),
(N'Nissan', N'Pulsar', 3),
(N'Ford', N'Mustang', 1),
(N'Volvo', N'XC60', 3),
(N'BMW', N'320i', 3);

-- Visa de två tabellerna.
SELECT * FROM Bilagare;
SELECT * FROM Bilar;

-- Visa bilarna tillsammans med ägarnas uppgifter.
SELECT
    b.BilID,
    a.Fnamn,
    a.Enamn,
    a.Adress,
    a.Postnr,
    a.Stad,
    a.Telefon,
    a.Email,
    b.Marke,
    b.Modell
FROM Bilagare AS a
INNER JOIN Bilar AS b
    ON a.BilagareID = b.BilagareID
ORDER BY b.BilID;
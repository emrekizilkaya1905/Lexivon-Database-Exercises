CREATE TABLE Students (
    SID INT NOT NULL PRIMARY KEY,
    FName VARCHAR(20) NOT NULL,
    LName VARCHAR(20) NOT NULL,
    Comment TEXT NULL
);

INSERT INTO Students (SID, FName, LName, Comment)
VALUES
(1, 'Anna', 'Nilsson', 'Student i klass A'),
(2, 'Lars', 'Persson', NULL),
(3, 'Bo', 'Karlsson', 'Student i klass B');

SELECT * FROM Students;
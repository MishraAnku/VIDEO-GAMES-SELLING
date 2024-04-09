-- Create tables
CREATE TABLE VideoGames (
    GameID INT PRIMARY KEY,
    Title VARCHAR(100),
    Sales DECIMAL(18, 2)
);

CREATE TABLE ReviewScores (
    GameID INT PRIMARY KEY,
    Score DECIMAL(3, 1)
);

CREATE TABLE LovedYearsByCritics (
    Year INT PRIMARY KEY
);

CREATE TABLE LovedYearsByPlayers (
    Year INT PRIMARY KEY
);

-- Insert values into tables
INSERT INTO VideoGames (GameID, Title, Sales) VALUES
(1, 'Game1', 100000.00),
(2, 'Game2', 95000.00),
(3, 'Game3', 85000.00),
(4, 'Game4', 75000.00),
(5, 'Game5', 70000.00),
(6, 'Game6', 65000.00),
(7, 'Game7', 60000.00),
(8, 'Game8', 55000.00),
(9, 'Game9', 50000.00),
(10, 'Game10', 45000.00);

INSERT INTO ReviewScores (GameID, Score) VALUES
(1, 8.5),
(2, 9.0),
(4, 7.8),
(5, NULL), -- Missing review score for Game5
(6, 8.2),
(8, 6.5),
(9, 7.0),
(10, 8.8);

INSERT INTO LovedYearsByCritics (Year) VALUES
(1982),
(1983),
(1984),
(1985);

INSERT INTO LovedYearsByPlayers (Year) VALUES
(1982),
(1983),
(1985),
(1986),
(1987),
(1988);

-- Query to find the ten best-selling video games
SELECT vg.Title, vg.Sales
FROM VideoGames vg
ORDER BY vg.Sales DESC
LIMIT 10;

-- Query to find games with missing review scores
SELECT vg.Title
FROM VideoGames vg
LEFT JOIN ReviewScores rs ON vg.GameID = rs.GameID
WHERE rs.Score IS NULL;

-- Query to find years that video game critics loved
SELECT Year
FROM LovedYearsByCritics;

-- Query to find out if 1982 was a great year according to critics
SELECT *
FROM LovedYearsByCritics
WHERE Year = 1982;

-- Query to find years that dropped off the critics' favorites list
SELECT Year
FROM LovedYearsByCritics
WHERE Year NOT IN (SELECT Year FROM LovedYearsByPlayers);

-- Query to find years that video game players loved
SELECT Year
FROM LovedYearsByPlayers;

-- Query to find years that both players and critics loved
SELECT lyc.Year
FROM LovedYearsByCritics lyc
INNER JOIN LovedYearsByPlayers lyp ON lyc.Year = lyp.Year;

-- Query to find sales in the best video game years
SELECT vg.Title, vg.Sales
FROM VideoGames vg
INNER JOIN (
    SELECT Year
    FROM LovedYearsByPlayers
    LIMIT 5 -- Assuming top 5 years are the best
) best_years ON YEAR(vg.Year) = best_years.Year;


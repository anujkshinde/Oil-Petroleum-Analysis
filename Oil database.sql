CREATE DATABASE Oil_industry;
use Oil_industry;

CREATE TABLE Countries (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(100) NOT NULL,
    Region VARCHAR(100),
    OPECMember BOOLEAN
);

CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    CountryID INT,
    FoundedYear INT,
    Revenue DECIMAL(15, 2),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE OilFields (
    OilFieldID INT PRIMARY KEY,
    FieldName VARCHAR(100) NOT NULL,
    CountryID INT,
    DiscoveredYear INT,
    EstimatedReserves DECIMAL(15, 2), -- in million barrels
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE ProductionData (
    ProductionID INT PRIMARY KEY,
    OilFieldID INT,
    Year INT,
    ProductionVolume DECIMAL(15, 2), -- in million barrels
    FOREIGN KEY (OilFieldID) REFERENCES OilFields(OilFieldID)
);

CREATE TABLE Exports (
    ExportID INT PRIMARY KEY,
    CountryID INT,
    Year INT,
    ExportVolume DECIMAL(15, 2), -- in million barrels
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE CrudePrices (
    PriceID INT PRIMARY KEY,
    Year INT,
    AveragePrice DECIMAL(10, 2) -- Price per barrel in USD
);

CREATE TABLE ProductionStats (
    StatID INT PRIMARY KEY,
    CountryID INT,
    Year INT,
    TotalProduction DECIMAL(15, 2),
    TotalReserves DECIMAL(15, 2),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE EnvironmentalImpact (
    ImpactID INT PRIMARY KEY,
    CountryID INT,
    Year INT,
    CO2Emissions DECIMAL(15, 2), -- in million metric tons
    OilSpills INT,               -- Number of reported oil spills
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

INSERT INTO Countries VALUES 
(1, 'Saudi Arabia', 'Middle East', TRUE),
(2, 'United States', 'North America', FALSE),
(3, 'Russia', 'Europe', FALSE),
(4, 'Nigeria', 'Africa', TRUE),
(5, 'Venezuela', 'South America', TRUE),
(6, 'Canada', 'North America', FALSE),
(7, 'Iran', 'Middle East', TRUE),
(8, 'Iraq', 'Middle East', TRUE),
(9, 'Kuwait', 'Middle East', TRUE),
(10, 'United Arab Emirates', 'Middle East', TRUE),
(11, 'Qatar', 'Middle East', TRUE),
(12, 'Norway', 'Europe', FALSE),
(13, 'Brazil', 'South America', FALSE),
(14, 'Mexico', 'North America', FALSE),
(15, 'Angola', 'Africa', TRUE),
(16, 'Algeria', 'Africa', TRUE),
(17, 'Libya', 'Africa', TRUE),
(18, 'Indonesia', 'Asia', FALSE),
(19, 'Malaysia', 'Asia', FALSE),
(20, 'China', 'Asia', FALSE),
(21, 'India', 'Asia', FALSE),
(22, 'Kazakhstan', 'Asia', FALSE),
(23, 'Azerbaijan', 'Asia', FALSE),
(24, 'Turkmenistan', 'Asia', FALSE),
(25, 'Egypt', 'Africa', FALSE),
(26, 'Sudan', 'Africa', FALSE);

INSERT INTO Companies VALUES 
(1, 'Saudi Aramco', 1, 1933, 230000000.00),
(2, 'ExxonMobil', 2, 1870, 200000000.00),
(3, 'Gazprom', 3, 1989, 150000000.00),
(4, 'TotalEnergies', 3, 1924, 140000000.00),
(5, 'Shell', 2, 1907, 180000000.00),
(6, 'Chevron', 2, 1879, 120000000.00),
(7, 'National Iranian Oil Company', 7, 1948, 85000000.00),
(8, 'Iraq National Oil Company', 8, 1966, 75000000.00),
(9, 'Kuwait Petroleum Corporation', 9, 1980, 60000000.00),
(10, 'Abu Dhabi National Oil Company', 10, 1971, 70000000.00),
(11, 'Qatar Petroleum', 11, 1974, 55000000.00),
(12, 'Statoil', 12, 1972, 80000000.00),
(13, 'Petrobras', 13, 1953, 90000000.00),
(14, 'Pemex', 14, 1938, 65000000.00),
(15, 'Sonangol', 15, 1976, 50000000.00),
(16, 'Sonatrach', 16, 1963, 60000000.00),
(17, 'National Oil Corporation', 17, 1970, 40000000.00),
(18, 'Pertamina', 18, 1957, 45000000.00),
(19, 'Petronas', 19, 1974, 50000000.00),
(20, 'China National Petroleum Corporation', 20, 1988, 200000000.00),
(21, 'Oil and Natural Gas Corporation', 21, 1956, 75000000.00),
(22, 'KazMunayGas', 22, 2002, 35000000.00),
(23, 'SOCAR', 23, 1992, 40000000.00),
(24, 'Turkmengaz', 24, 1991, 30000000.00),
(25, 'Egyptian General Petroleum Corporation', 25, 1956, 50000000.00),
(26, 'Sudapet', 26, 1997, 25000000.00);

INSERT INTO OilFields VALUES 
(1, 'Ghawar Field', 1, 1948, 58000.00),
(2, 'Burgan Field', 1, 1938, 66000.00),
(3, 'Prudhoe Bay', 2, 1968, 25000.00),
(4, 'West Qurna', 3, 1973, 20000.00),
(5, 'Offshore Oil Field', 2, 1970, 10000.00),
(6, 'Kashagan Field', 3, 2000, 13000.00),
(7, 'Azadegan', 7, 1999, 26000.00),
(8, 'Majnoon', 8, 1975, 23000.00),
(9, 'Rumaila', 8, 1953, 17000.00),
(10, 'Burgan Field', 9, 1938, 66000.00),
(11, 'Upper Zakum', 10, 1963, 50000.00),
(12, 'North Field', 11, 1971, 24000.00),
(13, 'Johan Sverdrup', 12, 2010, 28000.00),
(14, 'Tupi', 13, 2006, 8000.00),
(15, 'Cantarell', 14, 1976, 16000.00),
(16, 'Dalia', 15, 1999, 11000.00),
(17, 'Hassi Messaoud', 16, 1956, 16000.00),
(18, 'Sirte Basin', 17, 1959, 20000.00),
(19, 'Duri Field', 18, 1941, 7000.00),
(20, 'Kerteh', 19, 1975, 9000.00),
(21, 'Daqing', 20, 1959, 24000.00),
(22, 'Mumbai High', 21, 1974, 5000.00),
(23, 'Kashagan', 22, 2000, 13000.00),
(24, 'Azeri-Chirag-Gunashli', 23, 1981, 6000.00),
(25, 'South Yolotan', 24, 2006, 14000.00),
(26, 'Gulf of Suez', 25, 1956, 3000.00);

INSERT INTO ProductionData VALUES 
(1, 1, 1950, 200.00),
(2, 1, 1960, 500.00),
(3, 1, 1970, 1000.00),
(4, 2, 1950, 100.00),
(5, 2, 1960, 300.00),
(6, 2, 1970, 700.00),
(7, 3, 1970, 400.00),
(8, 3, 1980, 500.00),
(9, 3, 1990, 600.00),
(10, 4, 1980, 200.00),
(11, 4, 1990, 400.00),
(12, 5, 1970, 300.00),
(13, 5, 1980, 500.00),
(14, 6, 2000, 100.00),
(15, 6, 2010, 200.00),
(16, 7, 2000, 150.00),
(17, 7, 2010, 350.00),
(18, 8, 1980, 120.00),
(19, 8, 1990, 250.00),
(20, 9, 1970, 300.00),
(21, 9, 1980, 450.00),
(22, 10, 1960, 500.00),
(23, 10, 1970, 700.00),
(24, 11, 1965, 300.00),
(25, 11, 1975, 600.00),
(26, 12, 1975, 200.00);

INSERT INTO Exports VALUES 
(1, 1, 1950, 150.00),
(2, 1, 1960, 400.00),
(3, 1, 1970, 800.00),
(4, 2, 1950, 100.00),
(5, 2, 1960, 300.00),
(6, 2, 1970, 600.00),
(7, 3, 1970, 350.00),
(8, 3, 1980, 450.00),
(9, 3, 1990, 550.00),
(10, 4, 1980, 150.00),
(11, 4, 1990, 300.00),
(12, 5, 1970, 250.00),
(13, 5, 1980, 400.00),
(14, 6, 2000, 100.00),
(15, 6, 2010, 150.00),
(16, 7, 2000, 120.00),
(17, 7, 2010, 300.00),
(18, 8, 1980, 100.00),
(19, 8, 1990, 200.00),
(20, 9, 1970, 250.00),
(21, 9, 1980, 350.00),
(22, 10, 1960, 450.00),
(23, 10, 1970, 600.00),
(24, 11, 1965, 200.00),
(25, 11, 1975, 400.00),
(26, 12, 1975, 150.00);

INSERT INTO CrudePrices VALUES 
(1, 1950, 2.57),
(2, 1960, 2.91),
(3, 1970, 3.39),
(4, 1980, 37.42),
(5, 1990, 23.73),
(6, 2000, 28.26),
(7, 2010, 79.61),
(8, 2020, 41.96),
(9, 1951, 2.60),
(10, 1952, 2.63),
(11, 1953, 2.65),
(12, 1954, 2.68),
(13, 1955, 2.70),
(14, 1956, 2.72),
(15, 1957, 2.75),
(16, 1958, 2.77),
(17, 1959, 2.80),
(18, 1960, 2.82),
(19, 1961, 2.85),
(20, 1962, 2.88),
(21, 1963, 2.90),
(22, 1964, 2.93),
(23, 1965, 2.95),
(24, 1966, 2.97),
(25, 1967, 3.00),
(26, 1968, 3.03);

INSERT INTO ProductionStats (StatID, CountryID, Year, TotalProduction, TotalReserves)
VALUES 
(1, 1, 1950, 200.00, 58000.00),
(2, 1, 1960, 500.00, 56000.00),
(3, 1, 1970, 1000.00, 54000.00),
(4, 2, 1950, 100.00, 25000.00),
(5, 2, 1960, 300.00, 24000.00),
(6, 2, 1970, 600.00, 23000.00),
(7, 3, 1980, 350.00, 20000.00),
(8, 3, 1990, 450.00, 19000.00),
(9, 3, 2000, 500.00, 18000.00),
(10, 4, 1980, 150.00, 15000.00),
(11, 4, 1990, 300.00, 14000.00),
(12, 5, 1970, 250.00, 13000.00),
(13, 5, 1980, 400.00, 12000.00),
(14, 6, 2000, 100.00, 13000.00),
(15, 6, 2010, 200.00, 12000.00),
(16, 7, 2000, 450.00, 10000.00),
(17, 7, 2010, 220.00, 20000.00),
(18, 8, 1980, 320.00, 8000.00),
(19, 8, 1990, 250.00, 16000.00),
(20, 9, 1970, 550.00, 12000.00),
(21, 9, 1980, 440.00, 18000.00),
(22, 10, 1960, 250.00, 24000.00),
(23, 10, 1970, 300.00, 30000.00),
(24, 11, 1965, 190.00, 8000.00),
(25, 11, 1975, 280.00, 16000.00),
(26, 12, 1975, 520.00, 6000.00);

INSERT INTO EnvironmentalImpact VALUES 
(1, 1, 1950, 50.00, 2),
(2, 1, 1960, 60.00, 1),
(3, 1, 1970, 70.00, 3),
(4, 2, 1950, 40.00, 4),
(5, 2, 1960, 50.00, 5),
(6, 2, 1970, 60.00, 6),
(7, 3, 1980, 55.00, 2),
(8, 3, 1990, 65.00, 3),
(9, 3, 2000, 75.00, 1),
(10, 4, 1980, 30.00, 2),
(11, 4, 1990, 35.00, 4),
(12, 5, 1970, 45.00, 5),
(13, 5, 1980, 50.00, 6),
(14, 6, 2000, 40.00, 3),
(15, 6, 2010, 45.00, 2),
(16, 7, 1950, 80.00, 2),
(17, 7, 1960, 85.00, 1),
(18, 7, 1970, 90.00, 3),
(19, 8, 1950, 70.00, 4),
(20, 8, 1960, 75.00, 5),
(21, 8, 1970, 80.00, 6),
(22, 9, 1980, 85.00, 2),
(23, 9, 1990, 90.00, 3),
(24, 9, 2000, 95.00, 1),
(25, 10, 1980, 40.00, 2),
(26, 10, 1990, 45.00, 4);


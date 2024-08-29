select * from companies;
select * from countries;
select * from crudeprices;
select * from exports;
select * from oilfields;
select * from productiondata;
select * from productionstats;
select * from environmentalimpact;

ALTER TABLE oilfields 
RENAME column DiscoveredYear to Year_Founded;  #-------Rename column----------#
select * from oilfields;

SET SQL_SAFE_UPDATES = 0;               #-----Update the revenue of a specific company------#
update companies set Revenue=550000000 
where companyname = 'ExxonMobil'; 
select * from companies;

# How many companies are in the database?
SELECT COUNT(*) AS TotalCompanies
FROM Companies;

# Find the maximum and minimum crude oil prices recorded in the database.
SELECT MAX(revenue) AS MaxPrice, 
	   MIN(revenue) AS MinPrice
FROM companies;

#----Calculate the total production volume for a specific year (e.g., 2010).
SELECT SUM(ProductionVolume) AS TotalProduction2010
FROM ProductionData
WHERE Year = 2010;

#----How many oil fields have an estimated reserve greater than 500 million barrels?
SELECT COUNT(*) AS FieldsWithLargeReserves
FROM OilFields
WHERE EstimatedReserves > 50000.00;

#-----How many countries are members of OPEC?
SELECT COUNT(*) AS OPECMemberCount
FROM Countries
WHERE OPECMember = TRUE;

#--Find companies with revenue greater than $150 million and founded before 1980:
SELECT CompanyName, Revenue, FoundedYear
FROM Companies
WHERE Revenue > 150000000.00 AND FoundedYear < 2000;

#--List oil fields that were discovered before 1970 or have estimated reserves greater than 500 million barrels:
SELECT FieldName, Year_Founded, EstimatedReserves
FROM OilFields
WHERE Year_Founded < 1970 OR EstimatedReserves > 500000.00;

#--Find oil fields discovered between 1980 and 1990:
SELECT FieldName, Year_founded
FROM OilFields
WHERE Year_founded BETWEEN 1980 AND 1999;

#---Find all countries with region containing 'America':
SELECT *
FROM countries
WHERE region LIKE '%America%';

#--Calculate the Age of a Company Based on the Founding Date:
SELECT CompanyName, YEAR(CURDATE()) - FoundedYear AS Company_Lifespan
FROM Companies;

#--What are the top 5 most productive years for oil production globally?
SELECT Year, SUM(pd.ProductionVolume) AS GlobalProduction
FROM ProductionData pd
GROUP BY Year
ORDER BY GlobalProduction DESC
LIMIT 5;

# Convert all country names to uppercase in the Exports table.
SELECT UPPER(c.CountryName) AS CountryName, e.ExportVolume
FROM Exports e
JOIN Countries c 
ON e.CountryID = c.CountryID;

#---What is the average CO2 emission per country from 1950 to 2010?
SELECT c.CountryName, AVG(e.CO2Emissions) AS AvgCO2Emissions
FROM EnvironmentalImpact e
INNER JOIN Countries c 
ON e.CountryID = c.CountryID
WHERE e.Year BETWEEN 1950 AND 2010
GROUP BY c.CountryName
ORDER BY AvgCO2Emissions DESC;

#---Which companies are operating in countries that are members of OPEC?
SELECT c.CompanyName, co.CountryName
FROM Companies c
INNER JOIN Countries co 
ON c.CountryID = co.CountryID
WHERE co.OPECMember = TRUE;

#--What are the top 5 countries with the most oil spills recorded?
SELECT co.CountryName, SUM(ei.OilSpills) AS TotalOilSpills
FROM EnvironmentalImpact ei
INNER JOIN Countries co
ON ei.CountryID = co.CountryID
GROUP BY co.CountryName
ORDER BY TotalOilSpills DESC
LIMIT 5;

#--What are the total CO2 emissions for each country over the entire dataset?
SELECT co.CountryName, SUM(ei.CO2Emissions) AS TotalCO2Emissions
FROM EnvironmentalImpact ei
INNER JOIN Countries co 
ON ei.CountryID = co.CountryID
GROUP BY co.CountryName
ORDER BY TotalCO2Emissions DESC;

#--List the countries that are not OPEC members but have had significant oil exports. 1 million barrels in a single year.
SELECT co.CountryName, ex.Year, ex.ExportVolume
FROM Exports ex
INNER JOIN Countries co 
ON ex.CountryID = co.CountryID
WHERE co.OPECMember = FALSE AND ex.ExportVolume > 100.00;

#--What is the average revenue per company for each region?
SELECT co.Region, AVG(c.Revenue) AS AverageRevenue
FROM Companies c
INNER JOIN Countries co 
ON c.CountryID = co.CountryID
GROUP BY co.Region;

#---List all countries along with their oil fields, including countries that may not have any oil fields.
SELECT co.CountryName, ol.FieldName
FROM Countries co
LEFT OUTER JOIN OilFields ol
ON co.CountryID = ol.CountryID;

#--List All Countries and Their Revenue(Even if Some Countries Have No Revenue Recorded)
SELECT co.CountryName, cp.Revenue, cp.FoundedYear
FROM Countries co
LEFT OUTER JOIN Companies cp 
ON co.CountryID = cp.CountryID;

#--List All Environmental Impact Data and Corresponding Countries(Including Data Without a Linked Country)
SELECT co.CountryName,ei.Year, ei.CO2Emissions, ei.OilSpills
FROM EnvironmentalImpact ei
RIGHT OUTER JOIN Countries co 
ON ei.CountryID = co.CountryID;

# Show the production volumes for each oil field, including those fields that have no recorded production.
SELECT ol.FieldName, pd.ProductionVolume
FROM ProductionData pd
RIGHT OUTER JOIN OilFields ol 
ON pd.OilFieldID = ol.OilFieldID;

#--Find the Company with the Lowest Revenue:
SELECT CompanyName, Revenue
FROM Companies
WHERE Revenue = (SELECT MIN(Revenue)
    FROM Companies);

#--Find Countries with CO2 Emissions Greater Than the Average CO2 Emissions
SELECT CountryName
FROM Countries
WHERE CountryID IN (SELECT CountryID
                    FROM EnvironmentalImpact
                     WHERE CO2Emissions > (SELECT AVG(CO2Emissions)
                                           FROM EnvironmentalImpact));

#--Find the Number of Oil Fields in a Specific Country (e.g. Russia)
select count(FieldName) as No_of_Oilfields
from oilfields
where countryid = (select CountryID 
from countries
where countryname='Russia');

#--Which oil fields are in countries that have never experienced an oil spill?
SELECT ol.FieldName, co.CountryName
FROM OilFields ol
INNER JOIN Countries co 
ON ol.CountryID = co.CountryID
WHERE co.CountryID NOT IN (SELECT CountryID 
        FROM EnvironmentalImpact 
        WHERE OilSpills > 0);

#--List the names of companies that operate in more than one country.
SELECT CompanyName
FROM Companies
WHERE CountryID IN 
(SELECT CountryID FROM Companies 
GROUP BY CountryID 
HAVING COUNT(CountryID) > 1);




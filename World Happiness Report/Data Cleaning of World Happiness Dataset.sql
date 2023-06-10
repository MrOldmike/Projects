/* Renaming and Cleaning the columns to help match all 5 tables */


-- 2015 Dataset

EXEC sp_rename '2015.Happiness Rank', 'Happiness_Rank', 'COLUMN';

EXEC sp_rename '2015.Happiness Score', 'Happiness_Score', 'COLUMN';

EXEC sp_rename '2015.Economy (GDP per Capita)', 'Economy_GDP_per_Capita', 'COLUMN';

EXEC sp_rename '2015.Health (Life Expectancy)', 'Health_Life_Expectancy', 'COLUMN';

EXEC sp_rename '2015.Trust (Government Corruption)', 'Trust_Government_Corruption', 'COLUMN';

SELECT *
FROM [Happiness].[dbo].[2015];



-- 2016 Dataset

EXEC sp_rename '2016.Happiness Rank', 'Happiness_Rank', 'COLUMN';

EXEC sp_rename '2016.Happiness Score', 'Happiness_Score', 'COLUMN';

EXEC sp_rename '2016.Economy (GDP per Capita)', 'Economy_GDP_per_Capita', 'COLUMN';

EXEC sp_rename '2016.Health (Life Expectancy)', 'Health_Life_Expectancy', 'COLUMN';

EXEC sp_rename '2016.Trust (Government Corruption)', 'Trust_Government_Corruption', 'COLUMN';

SELECT *
FROM [Happiness].[dbo].[2016];



--2017 Dataset 
--Removing Quotation marks on each columns in table "2017"

EXEC sp_rename '[2017].["Country"]', 'Country', 'COLUMN';

EXEC sp_rename '[2017].["Happiness Rank"]', 'Happiness_Rank', 'COLUMN';

EXEC sp_rename '[2017].["Happiness Score"]', 'Happiness_Score', 'COLUMN';

EXEC sp_rename '[2017].["Economy  GDP per Capita "]', 'Economy_GDP_per_Capita', 'COLUMN';

EXEC sp_rename '[2017].["Health  Life Expectancy "]', 'Health_Life_Expectancy', 'COLUMN';

EXEC sp_rename '[2017].["Trust  Government Corruption "]', 'Trust_Government_Corruption', 'COLUMN';

EXEC sp_rename '[2017].["Freedom"]', 'Freedom', 'COLUMN';

EXEC sp_rename '[2017].["Generosity"]', 'Generosity', 'COLUMN';


-- Removing quotation marks from the rows in the Country's column
UPDATE [2017]
	SET 
		[Country] = REPLACE([Country], '"', '')
	WHERE
		[Country] LIKE '%"%"%';


--Joining 2 Columns as 1
UPDATE [2017]
	SET
		Country = CONCAT(Country, ' ', Happiness_Rank)
	WHERE
		[Country] LIKE '%Kong%';


--Replacing the right valve to the right column, wrongly inputed
UPDATE [2017]
	SET
		Country = REPLACE([Country], '"Hong Kong S.A.R.  China"', 'Hong Kong'),
		Happiness_Rank = Happiness_Score,
		Happiness_Score = ["Whisker high"],
		["Whisker high"] = ["Whisker low"],
		["Whisker low"] =  Economy_GDP_per_Capita,
		Economy_GDP_per_Capita = ["Family"],
		["Family"] = Health_Life_Expectancy,
		Health_Life_Expectancy = Freedom,
		Freedom = Generosity,
		Generosity = Trust_Government_Corruption,
		Trust_Government_Corruption = NULL 
	WHERE
		[Country] LIKE '%Kong%';


--Using Substring to separate a column before the delimiter "," and putting the value in the right column. CharIndex helps to search for a specific value, in this case ","
UPDATE [2017]
	SET 
		Trust_Government_Corruption = SUBSTRING (["Dystopia Residual"], 1, CHARINDEX (',', ["Dystopia Residual"]) -1)
	WHERE
		[Country] LIKE '%Kong%';


--Using Substring to separate a column after the delimiter "," and inputting the remainder value in the column. CharIndex helps to search for a specific value, in this case ","
UPDATE [2017]
	SET
		["Dystopia Residual"] = SUBSTRING (["Dystopia Residual"], CHARINDEX (',', ["Dystopia Residual"]) +1, LEN(["Dystopia Residual"])) 
	WHERE
		[Country] LIKE '%Kong%';


SELECT *
FROM [Happiness].[dbo].[2017];

   

-- 2018 Dataset

EXEC sp_rename '2018.Overall rank', 'Happiness_Rank', 'COLUMN';

EXEC sp_rename '2018.Score', 'Happiness_Score', 'COLUMN';

EXEC sp_rename '2018.Country or region', 'Country', 'COLUMN';

EXEC sp_rename '2018.GDP per Capita', 'Economy_GDP_per_Capita', 'COLUMN';

EXEC sp_rename '2018.Healthy life expectancy', 'Health_Life_Expectancy', 'COLUMN';

EXEC sp_rename '2018.Freedom to make life choices', 'Freedom', 'COLUMN';

EXEC sp_rename '2018.Perceptions of corruption', 'Trust_Government_Corruption', 'COLUMN';

SELECT *
FROM [Happiness].[dbo].[2018];



-- 2019 Dataset

EXEC sp_rename '2019.Overall rank', 'Happiness_Rank', 'COLUMN';

EXEC sp_rename '2019.Score', 'Happiness_Score', 'COLUMN';

EXEC sp_rename '2019.Country or region', 'Country', 'COLUMN';

EXEC sp_rename '2019.GDP per Capita', 'Economy_GDP_per_Capita', 'COLUMN';

EXEC sp_rename '2019.Healthy life expectancy', 'Health_Life_Expectancy', 'COLUMN';

EXEC sp_rename '2019.Freedom to make life choices', 'Freedom', 'COLUMN';

EXEC sp_rename '2019.Perceptions of corruption', 'Trust_Government_Corruption', 'COLUMN';

SELECT *
FROM [Happiness].[dbo].[2019];



/* Add the Year column to all tables in the Dataset */

-- Add the Year column to the [2015] table
ALTER TABLE [2015]
ADD Year smallint;

-- Update the Year column with the year value
UPDATE [2015]
SET Year = 2015;


-- Add the Year column to the [2016] table
ALTER TABLE [2016]
ADD Year smallint;

-- Update the Year column with the year value
UPDATE [2016]
SET Year = 2016;


-- Add the Year column to the [2017] table
ALTER TABLE [2017]
ADD Year smallint;

-- Update the Year column with the year value
UPDATE [2017]
SET Year = 2017;


-- Add the Year column to the [2018] table
ALTER TABLE [2018]
ADD Year smallint;

-- Update the Year column with the year value
UPDATE [2018]
SET Year = 2018;


-- Add the Year column to the [2019] table
ALTER TABLE [2019]
ADD Year smallint;

-- Update the Year column with the year value
UPDATE [2019]
SET Year = 2019;



/* Using UNION function to merge the 5 tables */

SELECT *
FROM 
(
SELECT Country, Happiness_Rank, Happiness_Score, Economy_GDP_per_Capita, Generosity, Freedom, Trust_Government_Corruption, Health_Life_Expectancy, Year
FROM [Happiness].[dbo].[2015]
UNION
SELECT Country, Happiness_Rank, Happiness_Score, Economy_GDP_per_Capita, Generosity, Freedom, Trust_Government_Corruption, Health_Life_Expectancy, Year
FROM [Happiness].[dbo].[2016]
UNION
SELECT Country, Happiness_Rank, Happiness_Score, Economy_GDP_per_Capita, Generosity, Freedom, Trust_Government_Corruption, Health_Life_Expectancy, Year
FROM [Happiness].[dbo].[2017]
UNION
SELECT Country, Happiness_Rank, Happiness_Score, Economy_GDP_per_Capita, Generosity, Freedom, Trust_Government_Corruption, Health_Life_Expectancy, Year
FROM [Happiness].[dbo].[2018]
UNION
SELECT Country, Happiness_Rank, Happiness_Score, Economy_GDP_per_Capita, Generosity, Freedom, Trust_Government_Corruption, Health_Life_Expectancy, Year
FROM [Happiness].[dbo].[2019]
)
AS World_Happiness



/* Creating a New Table */

SELECT Country, Happiness_Rank, Happiness_Score, Economy_GDP_per_Capita, Generosity, Freedom, Trust_Government_Corruption, Health_Life_Expectancy, Year
INTO World_Happiness
FROM [Happiness].[dbo].[2015]
UNION
SELECT Country, Happiness_Rank, Happiness_Score, Economy_GDP_per_Capita, Generosity, Freedom, Trust_Government_Corruption, Health_Life_Expectancy, Year
FROM [Happiness].[dbo].[2016]
UNION
SELECT Country, Happiness_Rank, Happiness_Score, Economy_GDP_per_Capita, Generosity, Freedom, Trust_Government_Corruption, Health_Life_Expectancy, Year
FROM [Happiness].[dbo].[2017]
UNION
SELECT Country, Happiness_Rank, Happiness_Score, Economy_GDP_per_Capita, Generosity, Freedom, Trust_Government_Corruption, Health_Life_Expectancy, Year
FROM [Happiness].[dbo].[2018]
UNION
SELECT Country, Happiness_Rank, Happiness_Score, Economy_GDP_per_Capita, Generosity, Freedom, Trust_Government_Corruption, Health_Life_Expectancy, Year
FROM [Happiness].[dbo].[2019]
ORDER BY Country, Year

SELECT *
FROM World_Happiness


/* Check and remove duplicates in the dataset */

WITH RowNumCTE AS
(
	SELECT
		*,
		row_number() OVER 
		(
			PARTITION BY
				happiness_rank,
				year,
				country,
				freedom
				ORDER BY
				happiness_rank
		) AS row_num
	FROM
		[Happiness].[dbo].[World_Happiness]
)
SELECT
	*
FROM
	RowNumCTE
WHERE
	row_num > 1



/*Cleaning of the Dataset*/

SELECT DISTINCT Country
FROM [Happiness].[dbo].[world_happiness]


UPDATE [Happiness].[dbo].[world_happiness]
SET
	Country = 'Trinidad & Tobago'
WHERE [Country] LIKE '%Tobago%';


UPDATE [Happiness].[dbo].[world_happiness]
SET
	Country = 'Taiwan'
WHERE [Country] LIKE '%Taiwan%';


UPDATE [Happiness].[dbo].[world_happiness]
SET
	Country = 'Somaliland Region'
WHERE [Country] LIKE '%Somaliland%';


UPDATE [Happiness].[dbo].[world_happiness]
SET
	Country = 'North Cyprus'
WHERE [Country] LIKE '%Northern%';


SELECT *
FROM [Happiness].[dbo].[world_happiness]



























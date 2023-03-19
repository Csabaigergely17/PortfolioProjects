-- States for map
SELECT TRIM(State) AS State, SUM(Total_Victims) AS TotalVictims
FROM [Mass shooting].dbo.['Mass Shootings Dataset Ver 2$']
GROUP BY TRIM(State)


-- Total fatilites, injures, victims from 1965-2022
SELECT
	SUM(Fatalities) AS Deaths,
	SUM(Injured) AS Injured,
	SUM(Total_victims) AS TotalVictims	
FROM
	[Mass shooting].dbo.['Mass Shootings Dataset Ver 2$']


-- Fatilites, injures, vitims by each decade
SELECT
    CASE 
		WHEN YEAR([Date]) BETWEEN 1970 AND 1979 THEN '1970s'
        WHEN YEAR([Date]) BETWEEN 1980 AND 1989 THEN '1980s'
        WHEN YEAR([Date]) BETWEEN 1990 AND 1999 THEN '1990s'
        WHEN YEAR([Date]) BETWEEN 2000 AND 2009 THEN '2000s'
        WHEN YEAR([Date]) BETWEEN 2010 AND 2019 THEN '2010s'
		WHEN YEAR([Date]) BETWEEN 2020 AND 2023 THEN '2020s'
        ELSE 'Unknown'
    END AS Decade,
    SUM([Fatalities]) AS Total_Fatalities,
    SUM([Injured]) AS Total_Injured,
    SUM([Total_victims]) AS Total_Victims
FROM [Mass shooting].[dbo].['Mass Shootings Dataset Ver 2$']
WHERE YEAR([Date]) >= 1970
GROUP BY
    CASE 
		WHEN YEAR([Date]) BETWEEN 1970 AND 1979 THEN '1970s'
        WHEN YEAR([Date]) BETWEEN 1980 AND 1989 THEN '1980s'
        WHEN YEAR([Date]) BETWEEN 1990 AND 1999 THEN '1990s'
        WHEN YEAR([Date]) BETWEEN 2000 AND 2009 THEN '2000s'
        WHEN YEAR([Date]) BETWEEN 2010 AND 2019 THEN '2010s'
		WHEN YEAR([Date]) BETWEEN 2020 AND 2023 THEN '2020s'
        ELSE 'Unknown'
    END


-- Race
SELECT [Race], COUNT(*) AS [Count], 
       CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS [Percentage]
FROM [Mass shooting].[dbo].['Mass Shootings Dataset Ver 2$']
GROUP BY [Race]


-- gender
SELECT [Gender], COUNT(*) AS [Count], 
       CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS [Percentage]
FROM [Mass shooting].[dbo].['Mass Shootings Dataset Ver 2$']
WHERE [Gender] != 'Unknown'
GROUP BY [Gender]


-- Motive
SELECT [Motive], COUNT(*) AS [Count],
	   CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS [Percentage]
FROM [Mass shooting].[dbo].['Mass Shootings Dataset Ver 2$']
GROUP BY [Motive]


-- Deaths occurred by years
SELECT YEAR(Date) AS Year, SUM(Fatalities) AS Deaths
FROM [Mass shooting].dbo.['Mass Shootings Dataset Ver 2$']
GROUP BY YEAR(Date)


-- Outcome
SELECT TRIM(Case_End) AS Outcome, COUNT(*) AS Count,
	   CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS [Percentage]
FROM
	[Mass shooting].dbo.['Mass Shootings Dataset Ver 2$']
GROUP BY Case_End


-- Europe fatalities etc by decade
SELECT 
	CASE 
		WHEN [Decade] = 1970 THEN '1970s'
		WHEN [Decade] = 1980 THEN '1980s'
		WHEN [Decade] = 1990 THEN '1990s'
		WHEN [Decade] = 2000 THEN '2000s'
		WHEN [Decade] = 2010 THEN '2010s'
		WHEN [Decade] = 2020 THEN '2020s'
		ELSE 'Unknown'
	END AS Decade, 
	SUM([Deaths]) AS Total_Fatalities, 
	SUM([Injured]) AS Total_Injured, 
	SUM([Total_victims]) AS Total_Victims 
FROM [Mass shooting].[dbo].[Europe] 
GROUP BY Decade

    
-- Marked cases
SELECT
	Title,
	Location,
	State,
	Fatalities,
	Injured,
	Total_victims
	
FROM
	[Mass shooting].dbo.['Mass Shootings Dataset Ver 2$']
Where [Most terrifyng cases] Like '%1%' 
ORDER BY Total_victims DESC

 


 
    -- Views for Data Visualization--




-- States for map VIEW
CREATE VIEW States_for_Map AS  
SELECT TRIM(State) AS State, COUNT(*) AS Cases_occurred, SUM(Fatalities) AS Deaths
FROM [Mass shooting].dbo.['Mass Shootings Dataset Ver 2$']
GROUP BY TRIM(State)


-- Total fatilites, injures, victims from 1965-2022 VIEW
CREATE VIEW All_Time_Fatilites_Injures_Victims_1965_2022 AS 
SELECT
	SUM(Fatalities) AS Deaths,
	SUM(Injured) AS Injured,
	SUM(Total_victims) AS TotalVictims	
FROM
	[Mass shooting].dbo.['Mass Shootings Dataset Ver 2$']


-- Fatilites, injures, vitims by each decade VIEW
CREATE VIEW Total_Numbers_By_Decades AS
SELECT
    CASE 
		WHEN YEAR([Date]) BETWEEN 1970 AND 1979 THEN '1970s'
        WHEN YEAR([Date]) BETWEEN 1980 AND 1989 THEN '1980s'
        WHEN YEAR([Date]) BETWEEN 1990 AND 1999 THEN '1990s'
        WHEN YEAR([Date]) BETWEEN 2000 AND 2009 THEN '2000s'
        WHEN YEAR([Date]) BETWEEN 2010 AND 2019 THEN '2010s'
		WHEN YEAR([Date]) BETWEEN 2020 AND 2023 THEN '2020s'
        ELSE 'Unknown'
    END AS Decade,
	COUNT(*) AS Cases_occurred,
    SUM([Fatalities]) AS Total_Fatalities,
    SUM([Injured]) AS Total_Injured,
    SUM([Total_victims]) AS Total_Victims
FROM [Mass shooting].[dbo].['Mass Shootings Dataset Ver 2$']
WHERE YEAR([Date]) >= 1970
GROUP BY
    CASE 
		WHEN YEAR([Date]) BETWEEN 1970 AND 1979 THEN '1970s'
        WHEN YEAR([Date]) BETWEEN 1980 AND 1989 THEN '1980s'
        WHEN YEAR([Date]) BETWEEN 1990 AND 1999 THEN '1990s'
        WHEN YEAR([Date]) BETWEEN 2000 AND 2009 THEN '2000s'
        WHEN YEAR([Date]) BETWEEN 2010 AND 2019 THEN '2010s'
		WHEN YEAR([Date]) BETWEEN 2020 AND 2023 THEN '2020s'
        ELSE 'Unknown'
    END


-- Race VIEW
CREATE VIEW Race AS
SELECT [Race], COUNT(*) AS [Count], 
       CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS [Percentage]
FROM [Mass shooting].[dbo].['Mass Shootings Dataset Ver 2$']
GROUP BY [Race]


-- gender VIEW
CREATE VIEW Gender AS
SELECT [Gender], COUNT(*) AS [Count], 
       CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS [Percentage]
FROM [Mass shooting].[dbo].['Mass Shootings Dataset Ver 2$']
WHERE [Gender] != 'Unknown'
GROUP BY [Gender]


-- Motive VIEW
CREATE VIEW Motive AS
SELECT [Motive], COUNT(*) AS [Count],
	   CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS [Percentage]
FROM [Mass shooting].[dbo].['Mass Shootings Dataset Ver 2$']
GROUP BY [Motive]


-- Deaths occurred by years VIEW
CREATE VIEW Death_By_Year_For_Linear AS
SELECT YEAR(Date) AS Year, SUM(Fatalities) AS Deaths
FROM [Mass shooting].dbo.['Mass Shootings Dataset Ver 2$']
GROUP BY YEAR(Date)


-- Outcome VIEW
CREATE VIEW Outcome AS
SELECT TRIM(Case_End) AS Outcome, COUNT(*) AS Count,
	   CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS [Percentage]
FROM
	[Mass shooting].dbo.['Mass Shootings Dataset Ver 2$']
GROUP BY Case_End


-- Europe fatalities etc by decade VIEW
CREATE VIEW Europe_View AS
SELECT 
	CASE 
		WHEN [Decade] = 1970 THEN '1970s'
		WHEN [Decade] = 1980 THEN '1980s'
		WHEN [Decade] = 1990 THEN '1990s'
		WHEN [Decade] = 2000 THEN '2000s'
		WHEN [Decade] = 2010 THEN '2010s'
		WHEN [Decade] = 2020 THEN '2020s'
		ELSE 'Unknown'
	END AS Decade,
	COUNT(*) AS Cases_occurred,
	SUM([Deaths]) AS Total_Fatalities, 
	SUM([Injured]) AS Total_Injured, 
	SUM([Total_victims]) AS Total_Victims 
FROM [Mass shooting].[dbo].[Europe] 
GROUP BY Decade
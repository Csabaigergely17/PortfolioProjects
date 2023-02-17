-- Top 20 happiest countries around the world in 2022

SELECT TOP 20
	[Country or region],
	Rank_2022,
	Score_2022
FROM
	Hapiness_World.dbo.Hapiness_World
Where Rank_2022 IS NOT NULL
ORDER BY Rank_2022 ASC




-- Top 20 saddest country around the world in 2022

SELECT TOP 20
	[Country or region],
	Score_2022 AS Score
FROM
	Hapiness_World.dbo.Hapiness_World
Where Rank_2022 IS NOT NULL
ORDER BY Rank_2022 DESC






-- All time happiest countries (top20)

SELECT top 20
	[Country or region],
	CAST(Score_2022+ Score_2021 + Score_2020 + Score_2019 + Score_2018 + Score_2017 + Score_2016 as decimal(5, 2)) / 7 AS Avarage_Score
FROM
	Hapiness_World.dbo.Hapiness_World
ORDER BY Avarage_Score DESC






-- Avarage Before, In and After the covid

SELECT
	COUNT([Country or region]) AS All_Country_In_The_World,
    SUM(CAST(Score_2017 as decimal(4, 1))) / 154 AS Before_covid,
	SUM(CAST(Score_2018 as decimal(4, 1))) / 154 AS In_Covid,
	SUM(CAST(score_2022 as decimal(4, 1))) / 154 AS After_covid
	
FROM
	Hapiness_World.dbo.Hapiness_World 







-- Avarage hapiness in the world before and after the covid with different continents

SELECT
	Continent,
    AVG(score_2017) AS Before_The_Covid_2017,
	AVG(Score_2019) AS After_The_Covid_2022
FROM
	Hapiness_World.dbo.Hapiness_World 
WHERE
	Continent in ('Africa', 'Asia', 'Europe', 'North-Amarica', 'South-America', 'Oceania')
GROUP BY
	Continent





-- Sorted list from the happiest countries

SELECT
	[Country or region],
	(Score_2022+ Score_2021 + Score_2020 + Score_2019 + Score_2018 + Score_2017 + Score_2016) / 7 AS Avarage_Score_Per_Country
FROM
	Hapiness_World.dbo.Hapiness_World
ORDER BY Avarage_Score_Per_Country DESC







-- Hungarian Hapiness and the surrounding countries (2016-2022)

SELECT
	[Country or region],
	Rank_2017,
	Rank_2018,
	Rank_2020,
	Rank_2021,
	Rank_2022 
FROM 
	Hapiness_World.dbo.Hapiness_World
WHERE
	[Country or region] IN ('Hungary', 'Slovakia', 'Romania', 'Croatia', 'Austria')
ORDER BY
	(Rank_2017 + Rank_2018 + Rank_2022 + Rank_2020 + Rank_2021) / 5 ASC







-- West europe

SELECT
	[Country or region],
	AVG(Score_2022) AS Avarage_Per_Country
FROM
	Hapiness_World.dbo.Hapiness_World

WHERE [Country or region] IN('Spain', 'Portugal', 'Italy', 'Switzerland', 'France', 'Germany',
'Austria', 'Netherlands', 'Belgium', 'Luxemburg', 'Norwey', 'Sweden', 'Finland', 'Denmark', 'Iceland')
GROUP BY [Country or region]
ORDER BY Avarage_Per_Country DESC
SELECT
	COUNT([Country or region]) AS Total_Number_Of_West_Europe,
	SUM(Score_2022) / 13 AS All_Avarage
FROM
	Hapiness_World.dbo.Hapiness_World
WHERE [Country or region] IN('Spain', 'Portugal', 'Italy', 'Switzerland', 'France', 'Germany',
'Austria', 'Netherlands', 'Belgium', 'Luxemburg', 'Norwey', 'Sweden', 'Finland', 'Denmark', 'Iceland')



-- East europe

SELECT
	[Country or region],
	AVG(Score_2022) AS Avarage_Per_Country
FROM
	Hapiness_World.dbo.Hapiness_World

WHERE [Country or region] IN('Poland', 'Slovakia', 'Hungary', 'Ukraine', 'Romania', 'Serbia',
'Bulgaria', 'Kosovo', 'Croatia', 'Belarus', 'Russia', 'Greece', 'Lithuania')
GROUP BY [Country or region]
ORDER BY Avarage_Per_Country DESC
SELECT
	COUNT([Country or region]) AS Total_Number_Of_East_Europe,
	SUM(Score_2022) / 13 AS All_Avarage
FROM
	Hapiness_World.dbo.Hapiness_World
WHERE [Country or region] IN('Poland', 'Slovakia', 'Hungary', 'Ukraine', 'Romania', 'Serbia',
'Bulgaria', 'Kosovo', 'Croatia', 'Belarus', 'Russia', 'Greece', 'Lithuania')









-- North America

SELECT
	[Country or region],
	AVG(Score_2022) AS Avarage_Per_Country
FROM
	Hapiness_World.dbo.Hapiness_World

WHERE [Country or region] IN('United States of America', 'Canada', 'Mexico')
GROUP BY [Country or region]
ORDER BY Avarage_Per_Country DESC

SELECT
	COUNT([Country or region]) AS Total_Number_Of_North_America,
	SUM(Score_2022) / 3 AS All_Avarage
FROM
	Hapiness_World.dbo.Hapiness_World
WHERE [Country or region] IN('United States of America', 'Canada', 'Mexico')




-- Central

SELECT
	[Country or region],
	AVG(Score_2022) AS Avarage_Per_Country
FROM
	Hapiness_World.dbo.Hapiness_World

WHERE [Country or region] IN('Panama', 'Costa Rica', 'Guatemala', 'El Salvador', 'Nicaragua', 'Jamaica', 'Honduras', 'Dominican Repbulic', 'Haiti')
GROUP BY [Country or region]
ORDER BY Avarage_Per_Country DESC

SELECT
	COUNT([Country or region]) AS Total_Number_Of_Cenrtal_America,
	SUM(Score_2022) / 8 AS All_Avarage
FROM
	Hapiness_World.dbo.Hapiness_World
WHERE [Country or region] IN('Panama', 'Costa Rica', 'Guatemala', 'El Salvador', 'Nicaragua', 'Jamaica', 'Honduras', 'Dominican Repbulic', 'Haiti')



--South America

SELECT
	[Country or region],
	AVG(Score_2022) AS Avarage_Per_Country
FROM
	Hapiness_World.dbo.Hapiness_World

WHERE [Country or region] IN('Chile', 'Brazil', 'Uruguay', 'Colombia', 'Argentina', 'Bolivia', 'Paraguay', 'Peru', 'Cameroon', 'Venezuela')
GROUP BY [Country or region]
ORDER BY Avarage_Per_Country DESC

SELECT
	COUNT([Country or region]) AS Total_Number_Of_South_America,
	SUM(Score_2022) / 10 AS All_Avarage
FROM
	Hapiness_World.dbo.Hapiness_World
WHERE [Country or region] IN('Chile', 'Brazil', 'Uruguay', 'Colombia', 'Argentina', 'Bolivia', 'Paraguay', 'Peru', 'Cameroon', 'Venezuela')




-- VIEWS --->>


-- TOP 20 Happiest Countries(2022) VIEW 

CREATE VIEW Top20_Happiest_Country_2022 AS
SELECT TOP 20
	[Country or region],
	Rank_2022,
	Score_2022
FROM
	Hapiness_World.dbo.Hapiness_World
Where Rank_2022 IS NOT NULL
ORDER BY Rank_2022 ASC



-- TOP 20 Saddest Countries VIEW

CREATE VIEW Top20_Saddest_Country AS
SELECT TOP 20
	[Country or region],
	Score_2022 AS Score
FROM
	Hapiness_World.dbo.Hapiness_World
Where Rank_2022 IS NOT NULL
ORDER BY Rank_2022 DESC



-- All time happiest countries (top20) VIEW

CREATE VIEW All_Time_Happiest_Countries AS
SELECT top 20
	[Country or region],
	CAST(Score_2022+ Score_2021 + Score_2020 + Score_2019 + Score_2018 + Score_2017 + Score_2016 as decimal(5, 2)) / 7 AS Avarage_Score
FROM
	Hapiness_World.dbo.Hapiness_World
ORDER BY Avarage_Score DESC 



-- Avarage Before, In and After the covid VIEW

CREATE VIEW Before_In_After_Covid AS
SELECT
	COUNT([Country or region]) AS All_Country_In_The_World,
    SUM(CAST(Score_2017 as decimal(4, 1))) / 154 AS Before_covid,
	SUM(CAST(Score_2018 as decimal(4, 1))) / 154 AS In_Covid,
	SUM(CAST(score_2022 as decimal(4, 1))) / 154 AS After_covid
	
FROM
	Hapiness_World.dbo.Hapiness_World 





-- Sorted list from the happiest countries VIEW

CREATE VIEW All_countries AS
SELECT
	[Country or region],
	(Score_2022+ Score_2021 + Score_2020 + Score_2019 + Score_2018 + Score_2017 + Score_2016) / 7 AS Avarage_Score_Per_Country
FROM
	Hapiness_World.dbo.Hapiness_World
--ORDER BY Avarage_Score_Per_Country DESC




-- Hungary and the neighborhoods VIEW

CREATE VIEW Middle_Europe AS
SELECT
	[Country or region],
	Rank_2017,
	Rank_2018,
	Rank_2020,
	Rank_2021,
	Rank_2022 
FROM 
	Hapiness_World.dbo.Hapiness_World
WHERE
	[Country or region] IN ('Hungary', 'Slovakia', 'Romania', 'Croatia', 'Austria')
--ORDER BY (Rank_2017 + Rank_2018 + Rank_2022 + Rank_2020 + Rank_2021) / 5 ASC




-- West Europe

CREATE VIEW West_Europe AS
SELECT
	[Country or region],
	AVG(Score_2022) AS Avarage_Per_Country
FROM
	Hapiness_World.dbo.Hapiness_World

WHERE [Country or region] IN('Spain', 'Portugal', 'Italy', 'Switzerland', 'France', 'Germany',
'Austria', 'Netherlands', 'Belgium', 'Luxemburg', 'Norwey', 'Sweden', 'Finland', 'Denmark', 'Iceland')
GROUP BY [Country or region]
--ORDER BY Avarage_Per_Country DESC
SELECT
	COUNT([Country or region]) AS Total_Number_Of_West_Europe,
	SUM(Score_2022) / 13 AS All_Avarage
FROM
	Hapiness_World.dbo.Hapiness_World
WHERE [Country or region] IN('Spain', 'Portugal', 'Italy', 'Switzerland', 'France', 'Germany',
'Austria', 'Netherlands', 'Belgium', 'Luxemburg', 'Norwey', 'Sweden', 'Finland', 'Denmark', 'Iceland')





-- East europe VIEW 

CREATE VIEW East_Europe AS
SELECT
	[Country or region],
	AVG(Score_2022) AS Avarage_Per_Country
FROM
	Hapiness_World.dbo.Hapiness_World

WHERE [Country or region] IN('Poland', 'Slovakia', 'Hungary', 'Ukraine', 'Romania', 'Serbia',
'Bulgaria', 'Kosovo', 'Croatia', 'Belarus', 'Russia', 'Greece', 'Lithuania')
GROUP BY [Country or region]
--ORDER BY Avarage_Per_Country DESC





-- North America VIEW

CREATE vIEW Nort_America AS
SELECT
	[Country or region],
	AVG(Score_2022) AS Avarage_Per_Country
FROM
	Hapiness_World.dbo.Hapiness_World

WHERE [Country or region] IN('United States of America', 'Canada', 'Mexico')
GROUP BY [Country or region]
--ORDER BY Avarage_Per_Country DESC




-- Central VIEW

CREATE VIEW Cenrtal_America AS
SELECT
	[Country or region],
	AVG(Score_2022) AS Avarage_Per_Country
FROM
	Hapiness_World.dbo.Hapiness_World

WHERE [Country or region] IN('Panama', 'Costa Rica', 'Guatemala', 'El Salvador', 'Nicaragua', 'Jamaica', 'Honduras', 'Dominican Repbulic', 'Haiti')
GROUP BY [Country or region]
--ORDER BY Avarage_Per_Country DESC





--South America VIEW 

CREATE VIEW South_America AS
SELECT
	[Country or region],
	AVG(Score_2022) AS Avarage_Per_Country
FROM
	Hapiness_World.dbo.Hapiness_World

WHERE [Country or region] IN('Chile', 'Brazil', 'Uruguay', 'Colombia', 'Argentina', 'Bolivia', 'Paraguay', 'Peru', 'Cameroon', 'Venezuela')
GROUP BY [Country or region]
ORDER BY Avarage_Per_Country DESC

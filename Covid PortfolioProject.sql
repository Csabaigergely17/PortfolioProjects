
-- DEATHPERCENTAGE IN THE USA

SELECT location,
	   date,
	   total_cases,
	   ROUND(total_deaths/total_cases, 3)* 100 as DeathPercentage,
	   total_deaths
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths
WHERE
	location = 'United States'
ORDER BY
	location, date



-- Hungarian infection rate 

SELECT location,
	   date,
	   population,
	   total_cases,
	   ROUND(total_cases/population, 3)* 100 as Cases_Percentage
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths
WHERE
	location = 'Hungary'
ORDER BY
	location, date




-- Countries with highest infection rate

SELECT location,
	   population,
	   MAX(total_cases) AS Highest_Infection_Per_Country,
	   MAX((ROUND(total_cases/population, 3)))* 100 as Cases_Percentage
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths
WHERE
	continent is not null
GROUP BY
	location, population
ORDER BY
	4 desc
	



-- Countries with highest death rate

SELECT location,
	   population,
	   MAX(total_deaths) AS Highest_death_Per_Country,
	   MAX((ROUND(total_deaths/population, 3)))* 100 as Death_Percentage
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths
WHERE
	continent is not null
GROUP BY 
	location, population
ORDER BY 
	4 desc




-- Total deaths per continent

SELECT location,
	   MAX(CAST(total_deaths AS int)) AS Total_Deaths_Per_Continent   
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths
WHERE
	continent is  null AND location NOT LIKE '%income%'
GROUP BY 
	location
ORDER BY
	Total_Deaths_Per_Continent DESC




-- GLOBAL SCOPE

SELECT
	SUM(new_cases) AS Total_cases,
	SUM(CAST(new_deaths as int)) AS Total_deaths,
	SUM(CAST(new_deaths as int)) / SUM(new_cases) * 100 AS Death_Percentage
	
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths
WHERE continent IS NOT NULL 
ORDER BY 1, 2





-- Total populations vs Vaccinations

WITH POPvsVAC (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
AS
(
SELECT
	deaths.continent,
	deaths.location,
	deaths.date,
	deaths.population,
	vaccinaces.new_vaccinations,
	SUM(CAST(vaccinaces.new_vaccinations AS bigint)) OVER (PARTITION BY deaths.location ORDER BY deaths.location,
	deaths.date) AS RollingPeopleVaccinated
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths AS deaths
JOIN [Portfolio Project 1. Data Exploration].dbo.covid_vaccinaces AS vaccinaces
ON deaths.location = vaccinaces.location 
AND deaths.date = vaccinaces.date
WHERE
	deaths.continent IS NOT NULL
--ORDER BY 2, 3
)
SELECT *, (RollingPeopleVaccinated/population) * 100
FROM POPvsVAC




-- TEMP TABLE 

CREATE TABLE #PercentPopulationVaccinated
(Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
INSERT INTO #PercentPopulationVaccinated
SELECT
	deaths.continent,
	deaths.location,
	deaths.date,
	deaths.population,
	vaccinaces.new_vaccinations,
	SUM(CAST(vaccinaces.new_vaccinations as bigint)) OVER (PARTITION BY deaths.location ORDER BY deaths.location,
	deaths.date) AS RollingPeopleVaccinated
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths AS deaths
JOIN [Portfolio Project 1. Data Exploration].dbo.covid_vaccinaces AS vaccinaces
ON deaths.location = vaccinaces.location 
AND deaths.date = vaccinaces.date
-- WHERE deaths.continent IS NOT NULL
-- ORDER BY 2, 3
SELECT *, (RollingPeopleVaccinated/Population) * 100
FROM #PercentPopulationVaccinated





-- VIEWS --->>


-- PercentPopulationVaccinated VIEW

CREATE VIEW PercentPopulationVaccinated as
SELECT
	deaths.continent,
	deaths.location,
	deaths.date,
	deaths.population,
	vaccinaces.new_vaccinations,
	SUM(CAST(vaccinaces.new_vaccinations AS bigint)) OVER (PARTITION BY deaths.location ORDER BY deaths.location,
	deaths.date) AS RollingPeopleVaccinated
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths AS deaths
JOIN [Portfolio Project 1. Data Exploration].dbo.covid_vaccinaces AS vaccinaces
ON deaths.location = vaccinaces.location 
AND deaths.date = vaccinaces.date
WHERE
	deaths.continent IS NOT NULL
--ORDER BY 2, 3



-- GLOBAL SCOPE VIEW

CREATE VIEW GLOBAL_SCOPE  AS
SELECT
	SUM(new_cases) AS Total_cases,
	SUM(CAST(new_deaths as int)) AS Total_deaths,
	SUM(CAST(new_deaths as int)) / SUM(new_cases) * 100 AS Death_Percentage
	
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths
WHERE continent IS NOT NULL 
--ORDER BY 1, 2




-- Total_Deaths_Per_Continent VIEW

CREATE VIEW Total_Deaths_Per_Continent AS 
SELECT location,
	   MAX(CAST(total_deaths AS int)) AS Total_Deaths_Per_Continent   
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths
WHERE
	continent is  null AND location NOT LIKE '%income%'
GROUP BY 
	location
--ORDER BY Total_Deaths_Per_Continent DESC



-- Hungarian infection rate VIEW

CREATE VIEW Hungary_Infection_Rate AS
SELECT location,
	   date,
	   population,
	   total_cases,
	   ROUND(total_cases/population, 3)* 100 as Cases_Percentage
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths
WHERE
	location = 'Hungary'
--ORDER BY location, date





-- Countries with hieghst infection rate VIEW

CREATE VIEW Highest_Infection_Rate_Per_Country AS
SELECT location,
	   population,
	   MAX(total_cases) AS Highest_Infection_Per_Country,
	   MAX((ROUND(total_cases/population, 3)))* 100 as Cases_Percentage
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths
WHERE
	continent is not null
GROUP BY
	location, population
--ORDER BY 4 desc



-- Highest Death Per Country VIEW 

CREATE VIEW Highest_Death_Per_Country AS 
SELECT location,
	   population,
	   MAX(total_deaths) AS Highest_death_Per_Country,
	   MAX((ROUND(total_deaths/population, 3)))* 100 as Death_Percentage
FROM
	[Portfolio Project 1. Data Exploration].dbo.covid_deaths
WHERE
	continent is not null
GROUP BY 
	location, population
--ORDER BY  4 desc


--                                                      PROJECT IS DONE


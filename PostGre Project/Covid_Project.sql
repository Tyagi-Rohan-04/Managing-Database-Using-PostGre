-- Portfolio Project
-- In this project we downloaded the particular dataset from ourworldindata.org performing several queries to hget the result of our questionnaire. --

-- Firstly we created the schema in PostGre SQL by having a look into the given csv files,
-- Then imported the csv file data into our postgre server,
-- Implementing the given questions for analysing our data.
-- The questions givern are:-

-- a. Datewise likelihood of dying due to covid-Totalcases vs TotalDeath in India.

SELECT date,total_cases,total_deaths FROM "CovidDeaths"  WHERE location LIKE '%India%'

-- b. Total % of deaths out of entire population in India.

SELECT max(total_deaths)/avg(cast(population AS integer))*100 AS perc_death FROM "CovidDeaths" WHERE location LIKE '%India%'

-- c. Verify by getting info seperately and calculating it conventionally.

SELECT total_deaths, population FROM "CovidDeaths"

-- d. Country with highest death as a % of the population.

SELECT location,(max(total_deaths)/avg(cast(population AS bigint))*100) AS percentage FROM "CovidDeaths" GROUP BY location ORDER BY percentage desc;

-- e. Total % of positive covid cases in India.

SELECT (max(total_cases)/avg(cast(population AS bigint))*100) AS percentagepositive FROM "CovidDeaths" WHERE location LIKE '%India%'

-- f. Total % of positive covid cases in World.

SELECT location, (max(total_cases)/avg(cast(population AS bigint))*100) AS percentagepositive FROM "CovidDeaths" GROUP BY location ORDER BY percentagepositive desc;

-- g. Continent wise positive cases.

SELECT location, max(total_cases) AS total_case FROM "CovidDeaths" WHERE continent IS null GROUP BY location ORDER BY total_case desc;

-- h. Continent wise deaths.

SELECT location, max(total_deaths) AS total_death FROM "CovidDeaths" WHERE continent IS null GROUP BY location ORDER BY total_death desc;

-- i. Daily newcases vs. hospitalizations vs. icu_patients in India.

SELECT date, new_cases, hosp_patients, icu_patients FROM "CovidDeaths" WHERE location LIKE '%India%'

-- j. Countrywise age 65> .

SELECT "CovidDeaths".location, "CovidVaccinations".aged_65_older FROM "CovidDeaths" JOIN "CovidVaccinations" ON "CovidDeaths".iso_code = "CovidVaccinations".iso_code AND "CovidDeaths".date = "CovidVaccinations".date;

-- k. Countrywise total vaccinated person.

SELECT "CovidDeaths".location AS country, (max("CovidVaccinations".people_fully_vaccinated)) AS Fully_vaccinated FROM "CovidDeaths" JOIN "CovidVaccinations" ON "CovidDeaths".iso_code = "CovidVaccinations".iso_code AND "CovidDeaths".date = "CovidVaccinations".date WHERE "CovidDeaths".continent IS NOT null GROUP BY country ORDER BY Fully_vaccinated DESC;

-- END OF THE PROJECT --
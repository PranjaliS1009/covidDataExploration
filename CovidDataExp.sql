
Select *
From DataExploration.dbo.covidDeaths
where continent is not null
Order by 3,4

--Select *
--From DataExploration..covidVaccinations
--Order by 3,4

Select location, date, total_cases, new_cases, total_deaths, population
From DataExploration..covidDeaths
Order by 1,2

--Finding data type
EXEC sp_help 'dbo.covidDeaths'

--Converting navachar to int
ALTER TABLE dbo.covidDeaths
ALTER COLUMN total_cases int
ALTER TABLE dbo.covidDeaths
ALTER COLUMN total_deaths int

--Finding hightest infection count
Select location, population, max(total_cases) as highestInfectionCount, max((total_cases/population))*100 as CovidPercentage
From DataExploration..covidDeaths
--where location like '%India%'
group by location, population
Order by CovidPercentage desc

--Finding total death count per population
Select location, population,total_deaths, (total_deaths/population)*100 as DeathPercentage
From DataExploration..covidDeaths
--where location like '%India%'
Order by DeathPercentage desc

--Finding max death percentage
Select location, population, max(total_deaths) as highestDeath, max((total_deaths/population))*100 as maxDeathPercentage
From DataExploration..covidDeaths
--where location like '%India%'
where continent is not null
Group by location, population
Order by maxDeathPercentage 

--Break down things using continent
Select continent, max(total_deaths) as highestDeath
From DataExploration..covidDeaths
--where location like '%India%'
where continent is not null
Group by continent
Order by highestDeath desc

--Global Analysis
Select date, sum(total_deaths) as totalDeath
From DataExploration..covidDeaths
Group by date
Order by totalDeath asc

--Joining the two tables
Select *
From DataExploration..covidDeaths dea
Join DataExploration..covidVaccinations vac
 On dea.location = vac.location
 and  dea.date = vac.date
 
--Performing operations on combined table
Select dea.continent, dea.location, dea.date, dea.population 
From DataExploration..covidDeaths dea
Join DataExploration..covidVaccinations vac
 On dea.location = vac.location
 and  dea.date = vac.date
 where dea.continent is not null
 order by 1,2,3









-- Section: 'SELECT basics' --

-- Question 1 

SELECT population FROM world
  WHERE name = 'Germany'


-- Question 2
SELECT name, population FROM world
  WHERE name IN ('Ireland', 'Iceland', 'Denmark')

-- Question 3

SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000

-- Section: 'SELECT from World'

-- Question 1
SELECT name, continent, population FROM world

-- Question 2
SELECT name FROM world
WHERE population>200000000

-- Question 3
SELECT name, gdp/population FROM world
WHERE population > 200000000

-- Question 4
SELECT name, population/1000000 FROM world
WHERE continent IN ('South America')

-- Question 5
SELECT name, population FROM world
WHERE name in ("France", "Germany", "Italy")

-- Question 6
SELECT name FROM world
WHERE name LIKE "United %"

-- Question 7
SELECT name, population, area FROM world
WHERE population > 250000000 OR area > 3000000

-- Question 8
SELECT name, population, area FROM world
WHERE population > 250000000 XOR area > 3000000

-- Question 9
SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2) FROM world
WHERE continent like "South America"

-- Question 10
SELECT name, ROUND(gdp/population, -3) FROM world
WHERE gdp > 1000000000000

-- Question 11
SELECT name, 
       CASE WHEN continent='Oceania' THEN 'Australasia'
            ELSE continent END
  FROM world
 WHERE name LIKE 'N%'

 -- Question 12
  SELECT name,
CASE WHEN continent = 'Europe' THEN 'Eurasia'
WHEN continent = 'Asia' THEN 'Eurasia'
WHEN continent = 'South America' THEN 'America'
WHEN continent = 'North America' THEN 'America'
WHEN continent = 'Caribbean' THEN 'America'
ELSE continent

END
FROM world

WHERE name LIKE 'A%' OR name LIKE 'B%'

-- Question 13
SELECT name, continent,
CASE WHEN continent = 'Oceania' THEN 'Australasia'
     WHEN continent = 'Eurasia' THEN 'Europe/Asia'
     WHEN name = 'Turkey' THEN 'Europe/Asia'
     WHEN continent = 'Caribbean' and name LIKE "B%" THEN 'North America'
     WHEN continent = 'Caribbean' and name NOT LIKE "%B" THEN 'South America'
ELSE continent

END
  FROM world

WHERE tld in ('.ag','.ba','.bb','.ca','.cn','.nz','.ru','.tr','.uk')


-- Section: SELECT from Nobel

-- Question 1

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

-- Question 2
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'

-- Question 3
SELECT yr, subject FROM nobel WHERE winner like "Albert Einstein"

-- Question 4
SELECT winner FROM nobel WHERE yr > 1999 AND subject like "Peace"

-- Question 5
SELECT yr, subject, winner FROM nobel WHERE subject like "Literature" AND yr > 1979 and yr < 1990

-- Question 6
SELECT yr, subject, winner FROM nobel WHERE winner IN ("Theodore Roosevelt", "Woodrow Wilson", "Jimmy Carter")

-- Question 7
SELECT winner FROM nobel WHERE winner like "John %"

-- Question 8
SELECT yr,subject, winner FROM nobel WHERE (yr = 1984 and subject like "Chemistry") OR (yr = 1980 and subject like "Physics")

-- Question 9
SELECT yr,subject,winner FROM nobel WHERE (yr=1980 AND subject NOT IN ("Chemistry", "Medicine"))

--Question 10
SELECT yr,subject,winner FROM nobel WHERE (yr < 1910 AND subject like "Medicine") OR (yr > 2003 and subject like "Literature")

--Question 11
SELECT yr, subject, winner FROM nobel WHERE winner like "Peter Gr%"

--Question 12
SELECT yr,subject,winner FROM nobel WHERE winner like "Eugene O%"

--Question 13
SELECT winner,yr,subject FROM nobel WHERE winner like "Sir %"

-- Question 14
SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'),subject,winner

-- Section: SELECT in SELECT

-- Question 1
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- Question 2
SELECT name FROM world WHERE gdp/population > (SELECT gdp/population FROM world WHERE name like "United Kingdom") and continent like "Europe"

-- Question 3
SELECT name,continent FROM world WHERE continent IN ("South America", "Oceania") ORDER BY name

-- Question 4
SELECT name, population FROM world where population > (SELECT population FROM world where name like "Canada") AND population < (SELECT population FROM world WHERE name like "Poland")

-- Question 5
SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name like "Germany")*100,0), "%") FROM world WHERE continent like "Europe"

-- Question 6
SELECT name FROM world WHERE gdp > ALL(SELECT gdp FROM world WHERE gdp != 0 AND continent like "Europe") and continent != "Europe"

-- Question 7
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area != 0)

--  Question 8
SELECT continent, name
FROM world a
WHERE name <= ALL(SELECT name FROM world b WHERE a.continent = b.continent)

-- Question 9
SELECT name, continent, population
FROM world a
WHERE 25000000  >= ALL(SELECT population FROM world b WHERE a.continent = b.continent AND b.population != 0)

-- Question 10
SELECT name, continent FROM world a
WHERE population > ALL(SELECT population*3 FROM world b WHERE a.continent = b.continent AND b.population > 0 AND a.name != b.name)

-- Section: Sum and Count 

-- Question 1
SELECT SUM(population) FROM world 

-- Question 2
SELECT DISTINCT(continent) FROM world

-- Question 3
SELECT sum(gdp) FROM world where continent like "Africa"

-- Question 4
SELECT count(name) FROM world where area > 1000000

-- Question 5
SELECT sum(population) FROM world where name in ('Estonia', 'Latvia', 'Lithuania')

-- Question 6
SELECT continent, COUNT(name) FROM world GROUP BY continent

-- Question 7
SELECT continent, COUNT(name) FROM world WHERE population > 10000000 GROUP BY continent

-- Question 8
SELECT continent FROM world  GROUP BY continent HAVING SUM(population) > 100000000


-- Section: JOIN

--Question 1
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'
  
 -- Question 2
 SELECT id,stadium,team1,team2
  FROM game where id like "1012"
  
 --Question 3
 SELECT player,teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid) WHERE goal.teamid like "GER"
  
  -- Question 4
  SELECT team1,team2,player
FROM game JOIN goal ON (id=matchid) WHERE player like 'Mario %'

-- Question 5
SELECT player,teamid,coach,gtime FROM goal JOIN eteam on teamid=id WHERE gtime<=10

--Question 6
SELECT mdate, teamname FROM game JOIN eteam ON (team1=eteam.id) WHERE eteam.coach like "Fernando Santos"

-- Question 7
SELECT player FROM goal JOIN game on (game.id=goal.matchid) WHERE stadium like "National Stadium%"

-- Question 8
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') AND goal.teamid != 'GER'

  -- Question 9 
SELECT eteam.teamname, COUNT(goal.teamid) FROM goal JOIN eteam on goal.teamid=eteam.id GROUP BY teamname

-- Question 10
SELECT game.stadium, COUNT(goal.matchid) FROM game JOIN goal on goal.matchid=game.id GROUP BY game.stadium

-- Question 11
SELECT game.id, game.mdate, COUNT(goal.player)
FROM game
  JOIN goal ON (game.id=goal.matchid AND (team1 = 'GER' OR team2 = 'GER') AND teamid='GER')
GROUP BY game.id, game.mdate

-- Question 12
SELECT mdate,
       team1,
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END),
       team2,
       SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) 
FROM game LEFT JOIN goal ON (game.id = goal.matchid)
    GROUP BY mdate, team1, team2


-- Section: More JOIN 

--Question 1
SELECT id, title
 FROM movie
 WHERE yr = 1962
 
 -- Question 2
 SELECT yr FROM movie WHERE title like "Citizen Kane"
 
 -- Question 3
 SELECT id, title, yr FROM movie WHERE title like "Star Trek%"
 
 -- Question 4
 SELECT id FROM actor WHERE name like "Glenn Close"
 
 -- Question 5
 SELECT id FROM movie WHERE title like "Casablanca"
 
 -- Question 6
 SELECT name FROM actor JOIN casting on casting.actorid=actor.id WHERE movieid=11768
 
 -- Question 7
SELECT name FROM actor JOIN casting on casting.actorid=actor.id JOIN movie on movie.id=casting.movieid WHERE movie.title="Alien"

-- Question 8
SELECT movie.title FROM movie JOIN casting on casting.movieid=movie.id JOIN actor on actor.id= casting.actorid WHERE actor.name="Harrison Ford"

-- Question 9
SELECT movie.title FROM movie JOIN casting on casting.movieid=movie.id JOIN actor on actor.id=casting.actorid WHERE actor.name="Harrison Ford" AND casting.ord > 1

-- Question 10
SELECT movie.title, actor.name FROM movie JOIN casting on casting.movieid=movie.id JOIN actor on actor.id=casting.actorid WHERE casting.ord = 1 AND movie.yr = 1962

-- Question 11
SELECT yr, COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=casting.movieid
         JOIN actor   ON casting.actorid=actor.id
 where name='John Travolta'
 GROUP BY yr) AS t
)

-- Question 12
SELECT title, name FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE ord=1 AND movieid IN
(SELECT movieid FROM casting
JOIN actor ON actor.id=casting.actorid
WHERE name = 'Julie Andrews')

-- Question 13
SELECT name
FROM actor
  JOIN casting ON (id = actorid AND (SELECT COUNT(ord) FROM casting WHERE actorid = actor.id AND ord=1)>29)
GROUP BY name

-- Question 14
SELECT title, COUNT(actorid) as cast
FROM movie JOIN casting on id=movieid
WHERE yr = 1978
GROUP BY title
ORDER BY cast DESC

-- Question 15
SELECT DISTINCT first.name
FROM actor first JOIN casting second ON (second.actorid=first.id)
   JOIN casting third on (second.movieid=third.movieid)
   JOIN actor fourth on (third.actorid=fourth.id 
                and fourth.name='Art Garfunkel')
  WHERE first.id!=fourth.id


-- Section: Using NULL

-- Question 1
SELECT name FROM teacher WHERE dept is null

-- Question 2
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

-- Question 3
SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)

-- Question 4
SELECT teacher.name, dept.name
 FROM teacher RIGHT JOIN dept
           ON (teacher.dept=dept.id)

-- Question 5
SELECT teacher.name, COALESCE(mobile, '07986 444 2266') FROM teacher

-- Question 6
SELECT teacher.name, COALESCE(dept.name, 'None')
FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)

-- Question 7
SELECT COUNT(teacher.name), COUNT(teacher.mobile) FROM teacher

-- Question 8
SELECT dept.name, COUNT(teacher.name) FROM teacher RIGHT JOIN dept ON (teacher.dept = dept.id) GROUP BY dept.name

-- Question 9
SELECT teacher.name,
CASE WHEN dept.id < 3 THEN 'Sci'
     ELSE 'Art' END
FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)

-- Question 10
SELECT teacher.name,
CASE WHEN dept.id < 3 THEN 'Sci'
     WHEN dept.id = 3 THEN 'Art'
     ELSE 'None' END
FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)


-- Section: Self JOIN 

-- Question 1
SELECT COUNT(stops.id) FROM stops

-- Question 2
SELECT stops.id FROM stops WHERE stops.name like 'Craiglockhart'

-- Question 3
SELECT stops.id, stops.name FROM stops JOIN route on route.stop=stops.id WHERE route.company like "LRT" and route.num = 4

-- Question 4
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num HAVING COUNT(*) = 2

-- Question 5
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 and b.stop = 149

-- Question 6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name ='London Road'

-- Question 7
SELECT  DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop = 115 and b.stop = 137 

-- Question 8
SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name ='Tollcross'

-- Question 9
SELECT stopx.name, x.company, x.num
FROM route x
  JOIN route y ON (x.num=y.num AND x.company=y.company)
  JOIN stops stopx ON (x.stop=stopx.id)
  JOIN stops stopy ON (y.stop=stopy.id)
WHERE stopy.name = 'Craiglockhart'

-- Question 10
SELECT DISTINCT a.num, a.company, stopb.name ,  c.num,  c.company
FROM route a JOIN route b
ON (a.company = b.company AND a.num = b.num)
JOIN ( route c JOIN route d ON (c.company = d.company AND c.num= d.num))
JOIN stops stopa ON (a.stop = stopa.id)
JOIN stops stopb ON (b.stop = stopb.id)
JOIN stops stopc ON (c.stop = stopc.id)
JOIN stops stopd ON (d.stop = stopd.id)
WHERE  stopa.name = 'Craiglockhart' AND stopd.name = 'Sighthill'
            AND  stopb.name = stopc.name
ORDER BY LENGTH(a.num), b.num, stopb.id, LENGTH(c.num), d.num











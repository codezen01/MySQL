-- 15. List all the people who have worked with 'Art Garfunkel'.

SELECT actor.name 
FROM movie 
JOIN casting ON (movie.id=casting.movieid) 
JOIN actor ON (actor.id=casting.actorid)
WHERE actor.name!='Art Garfunkel' AND 
movie.id IN (SELECT movie.id FROM movie 
JOIN casting ON (movie.id=casting.movieid) 
JOIN actor ON (actor.id=casting.actorid) 
WHERE actor.name = 'Art Garfunkel')


-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title

SELECT movie.title, COUNT(*) 
FROM movie 
JOIN casting ON (movie.id=casting.movieid) 
JOIN actor ON (actor.id=casting.actorid) 
WHERE movie.yr='1978' 
GROUP BY movie.title 
ORDER BY COUNT(*) DESC , movie.title 


-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

SELECT DISTINCT actor.name 
FROM movie 
JOIN casting ON movie.id=casting.movieid 
JOIN actor ON actor.id=casting.actorid 
WHERE casting.ord = 1 GROUP BY actor.name 
Having COUNT(movie.id) >= 15 ORDER BY actor.name


-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.

SELECT x.title, y.name 
FROM (SELECT movie.* FROM movie JOIN casting ON (movie.id=casting.movieid) JOIN actor ON (actor.id = casting.actorid) 
WHERE actor.name='Julie Andrews') AS x 
JOIN (SELECT actor.* , casting.movieid  as movieid From movie JOIN casting ON (movie.id = casting.movieid) JOIN actor ON (actor.id = casting.actorid) WHERE ord = 1) AS y ON x.id = y.movieid 


-- 10. List the films together with the leading star for all 1962 films.

SELECT movie.title, actor.name 
FROM movie JOIN casting ON (id=movieid ) 
JOIN actor ON (actor.id=casting.actorid) 
WHERE movie.yr= '1962' and   casting.ord=1 

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

SELECT title FROM  movie JOIN casting ON id=movieid WHERE ord != 1 and actorid = (SELECT id FROM  actor where name='Harrison Ford')


-- Give the id and the name for the stops on the '4' 'LRT' service.

select id,name
from stops join route
on stops.id=route.stop
where num='4' and company='LRT'

-- The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the -- query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the -- output to these two routes.

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num Having COUNT(*)=2

-- Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, -- without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.


SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop =149

-- The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to -- stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London -- Road' are shown.


SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'


-- Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=115 AND b.stop=137 


-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='Tollcross'


-- Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including -- 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.

SELECT DISTINCT stopb.name,b.company,b.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND a.company='LRT'





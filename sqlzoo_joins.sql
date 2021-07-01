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




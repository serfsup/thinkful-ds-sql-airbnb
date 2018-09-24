--What's the most expensive listing? What else can you tell me about the listing?

SELECT
	*
FROM
	listings
ORDER BY
	price DESC
	
/* There are two listings that are each for $9,999, and they are both in Manhattan.  The first one has a minimum
nights of 5 but has no availability all year.  The second listing is a private room, and the minimum nights is 99.
This seems absolutely absurd!  There are ten additional listings that are for $999, 
mostly from Manhattan, Brooklyn, and Queens.  Only two are private rooms (the rest are entire home/
apartments) with minimum nights of one or two nights.  While a few have no availablity, one of the listings
is available 365 days (which also happens to be the listing with the most reviews per month).
*/


--What neighborhoods seem to be the most popular?

SELECT
	neighbourhood AS neighborhood,
	COUNT(*)
FROM
	listings AS l
JOIN
	calendar AS c
ON
	l.id = c.listing_id
WHERE
	c.available IS 'f'
GROUP BY l.neighbourhood
ORDER BY COUNT(*) DESC

/*  Williamsburg seems to be the most popular neighborhood, with 1,187,799 booked nights over the 
time period.  The next most popular is Bedford-Stuyvesant at 888,205, followed by Harlem at 724,791.
*/


--What time of year is the cheapest time to go to your city? What about the busiest?

SELECT
	listing_id,
	date,
	available,
	price,
	(CASE WHEN date LIKE '-12-' OR '-01-' OR '-02-' THEN 'winter'
			 WHEN date LIKE '-03-' OR '-04-' OR '-05-' THEN 'spring'
			 WHEN date LIKE '-06-' OR '-07-' OR '-08-' THEN 'summer'
			 WHEN date LIKE '-09-' OR '-10-' OR '-11-' THEN 'autumn' END) AS season
		FROM 
			calendar;
			
/*  I'm not quite sure why my results are not coming out correctly, but everything seems to be coming up in
the winter season.  The only thing I can think is that the '-01-' isn't identifying the month portion of the date 
(like in 2018-01-31), but the 01 in 2016, 2017, 2018, and 2019.  I'm not sure how to remedy this.
*/
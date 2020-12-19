Question Set 1
Question #1
We want to understand more about the movies that families are watching.
The following categories are considered family movies:
Animation, Children, Classics, Comedy, Family and Music.
Create a query that lists each movie,
the film category it is classified in, and the number of times it
has been rented out.

SELECT a.title AS Filmtitle,
		c.name AS Categoryname,
    Count(e.rental_id)  AS Rentals
FROM  film a
JOIN film_category b ON a.film_id = b.film_id
JOIN Category c ON b.category_id = c.category_id
JOIN Inventory d ON a.film_id = d.film_id
JOIN Rental e ON d.inventory_id = e.inventory_id
WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
GROUP by a.title, c.name
ORDER BY 2,1 ASC , 3 DESC

Question#3
Finally, provide a table with the family-friendly film category,
each of the quartiles, and the corresponding count of movies within each
combination of film category for each corresponding rental duration category.
The resulting table should have three columns:
Category,Rental length category,Count

SELECT  CategoryName,
				RentalDuration,
        COUNT(CategoryName)
FROM (SELECT c.name AS CategoryName,a.rental_duration AS RentalDuration,
  			     NTILE(4) OVER (ORDER BY a.rental_duration) AS Quartiles
      FROM film a
      JOIN film_category b ON a.film_id = b.film_id
			JOIN category c ON c.category_id = b.category_id
			WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) F
GROUP BY 1, 2
ORDER BY 1, 2

Question Set 2
Question #1
We want to find out how the two stores compare in their count of rental
orders during every month for all the years we have data for.
 Write a query that returns the store ID for the store, the year and month
 and the number of rental orders each store has fulfilled for that month.
 Your table should include a column for each of the following: year, month,
 store ID and count of rental orders fulfilled during that month.

 SELECT   DATE_PART('YEAR', a.rental_date) RentalYear,
          DATE_PART('MONTH', a.rental_date) RentalMonth,
 		 d.store_id,
   		 COUNT(d.store_id)
 FROM rental a
 JOIN payment b ON b.rental_id = a.rental_id
 JOIN staff c ON c.staff_id = b.staff_id
 JOIN store d ON d.store_id = c.store_id
 GROUP BY 1, 2, 3
 ORDER BY 1 DESC, 2, 3, 4 DESC

Question #2
 We would like to know who were our top 10 paying customers,
 how many payments they made on a monthly basis during 2007,
 and what was the amount of the monthly payments. Can you
 write a query to capture the customer name, month and year of payment,
 and total payment amount for each month by these top 10 paying customers?

 SELECT DATE_PART('MONTH',b.payment_date) AS MonthPayment,
        a.first_name||' '||a.last_name AS CustomerName,
        COUNT(b.payment_id) AS CountPayment,
        SUM(b.amount) AS TotalPayment
 FROM customer a
 JOIN payment b ON a.customer_id = b.customer_id
 WHERE b.payment_date BETWEEN '2007-01-01' AND '2007-12-31'
 GROUP BY 1,2
 ORDER BY 4 DESC
 LIMIT 10;

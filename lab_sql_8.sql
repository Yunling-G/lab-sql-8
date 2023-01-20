USE sakila;
-- 1.Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city, co.country 
FROM city AS c
JOIN country AS co 
ON c.country_id = co.country_id
JOIN address AS a 
ON c.city_id=a.city_id
JOIN store AS s 
ON a.address_id=s.address_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id AS store, SUM(p.amount) AS toat_amount 
From inventory AS i
JOIN rental AS r
ON i.inventory_id = r.inventory_id
JOIN payment AS p
ON r.rental_id = p.rental_id
JOIN staff AS s
ON r.staff_id = s.staff_id
GROUP BY s.store_id;

-- 3. Which film categories are longest?
SELECT f.film_id, f.title, c.category_id,c.name, AVG(length) AS avg_length 
FROM film AS f
JOIN film_category AS fc
ON  f.film_id = fc.film_id
JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY f.film_id, f.title, category_id, c.name
ORDER BY avg_length DESC
LIMIT 1;

-- 4. Display the most frequently rented movies in descending order.
SELECT f.title, count(rental_id) AS num_rented_movies
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY num_rented_movies DESC
LIMIT 1;

-- 5. List the top five genres in gross revenue in descending order.
SELECT c.name, SUM(p.amount) AS revenue
FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
JOIN inventory AS i
ON fc.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
JOIN payment AS p
ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY revenue DESC
LIMIT 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title,s.store_id
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN store AS s
ON i.store_id = s.store_id
WHERE s.store_id =1 AND f.title ='Academy Dinosaur';

-- 7. Get all pairs of actors that worked together.
SELECT f1.actor_id, f2.actor_id,f1.film_id,a1.first_name,a1.last_name,a2.first_name,a2.last_name
FROM film_actor AS f1
JOIN film_actor AS f2
ON f1.film_id = f2.film_id
JOIN actor AS a1
ON f1.actor_id = a1.actor_id
JOIN actor AS a2
ON f2.actor_id = a2.actor_id
WHERE f1.actor_id < f2.actor_id;

-- 8. Get all pairs of customers that have rented the same film more than 3 times.
SELECT c.customer_id, i.film_id, count(rental_id) AS num_rentals
FROM customer AS c
LEFT JOIN rental AS r
ON c.customer_id = r.customer_id
LEFT JOIN inventory AS i
ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id, i.film_id
HAVING count(rental_id) >3; -- Cannot finish it....


-- 9.For each film, list actor that has acted in more films.
SELECT a.actor_id, a.first_name,a.last_name, count(fc.film_id) AS num_films
FROM actor AS a
JOIN film_actor AS fc
ON a.actor_id = fc.actor_id
GROUP BY  a.actor_id, a.first_name,a.last_name
HAVING num_films > 1
ORDER BY num_films DESC;

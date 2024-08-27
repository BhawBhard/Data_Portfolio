SELECT c.first_name, c.last_name
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
WHERE r.rental_id IS NULL;

SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'Customer Name', SUM(p.amount) AS 'Total Paid'
FROM payment AS p
JOIN customer AS c ON p.customer_id = c.customer_id
WHERE p.amount > 5
GROUP BY c.customer_id;

SELECT cat.name AS CategoryName, AVG(film.length) AS AverageLength
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category cat ON cat.category_id = film_category.category_id
GROUP BY cat.name;

select DATE_SUB('2005-05-25', INTERVAL 1 MONTH) ;

select * from rental where rental_date between '2005-08-21'and '2005-05-25';
select year(rental.rental_date) = year(DATE_SUB("2006-05-25", INTERval 1 year)) from rental ;

SELECT customer.first_name, customer.last_name, COUNT(rental.rental_id) AS rental_count
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY rental_count DESC;

SELECT f.title
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.customer_id = p.customer_id
WHERE p.payment_date >= DATE_SUB("2005-05-25", INTERVAL 6 MONTH);

select rental_date between DATE_SUB('2005-06-25', INTERVAL 1 WEEK) and '2005-06-25' from rental;

select DATE_SUB('2005-06-25', INTERVAL 1 WEEK) ;
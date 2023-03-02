
/*Luis*/
use sakila;

#Q1
#Rank films by length (filter out the rows with nulls or zeros in length column). 
#Select only columns title, length and rank in your output.
select title
	, length
	, dense_rank() over (order by film.length desc) as ranking
from film
where length is not null and length<>0
;

#Q2
#Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
#In your output, only select the columns title, length, rating and rank.
select film.title
	, film.length
	, film.rating
	, dense_rank() over (partition by rating order by film.length desc) as ranking
from film
where length is not null and length<>0
;

#Q3
#How many films are there for each of the categories in the category table? 
#Hint: Use appropriate join between the tables "category" and "film_category".
select c.name
	, count(film_id) as num_films
from film_category fc
	inner join category c on c.category_id=fc.category_id
group by c.name
order by num_films desc
;
#Q4
#Which actor has appeared in the most films? 
#Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select
	a.first_name,
    a.last_name,
    count(fa.film_id) as num_films
from film_actor fa
	inner join actor a on a.actor_id = fa.actor_id
group by 	a.first_name, a.last_name
order by num_films desc
;


#Q5
#Which is the most active customer (the customer that has rented the most number of films)? 
#Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT c.first_name
    ,	c.last_name
    ,	count(rental_id) as num_rentals
FROM rental r
	INNER JOIN customer c on c.customer_id=r.customer_id
GROUP BY c.first_name ,	c.last_name
ORDER BY num_rentals desc
limit 1
;

#Bonus
select
	f.title
    ,count(r.rental_id) as 'num_rentals'
from film f
	inner join inventory i on f.film_id=i.film_id
    inner join rental r on i.inventory_id=r.inventory_id
group by title
order by num_rentals desc
limit 1
;
select * from rental;
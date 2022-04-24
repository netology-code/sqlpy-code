-- Агрегирующие функции
-- найдем максимальную стоимость проката
SELECT MAX(rental_rate) FROM film;

-- посчитаем среднюю продолжительность фильма
SELECT AVG(length) FROM film;

-- сколько уникальных имен актеров?
SELECT COUNT(DISTINCT first_name) FROM actor

-- посчитаем сумму и средние продажи по конкретному продавцу
SELECT SUM(amount), AVG(amount) FROM payment
WHERE staff_id = 1;


-- Вложенные запросы
-- найдем все фильмы с продолжительностью ваше среднего
-- так работать не будет
SELECT title, length  FROM film
WHERE length >= AVG(length);
-- нужно вот так
SELECT title, length FROM film
WHERE length >= (SELECT AVG(length) FROM film);

-- найдем названия фильмов, стоимость проката которых не максимальная
SELECT title, rental_rate FROM film
WHERE rental_rate < (SELECT MAX(rental_rate) FROM film)
ORDER BY rental_rate DESC;


-- Группировки
-- посчитаем количество актеров в разрезе фамилий (найдем однофамильцев)
SELECT last_name, COUNT(*) FROM actor
GROUP BY last_name
ORDER BY COUNT(*) DESC;

-- посчитаем количество фильмов в разрезе рейтингов (распределение рейтингов)
SELECT rating, COUNT(title) FROM film
GROUP BY rating
ORDER BY COUNT(title) DESC;

-- найдем максимальные продажи в разрезе продавцов
SELECT staff_id, MAX(amount) FROM payment
GROUP BY staff_id;

-- найдем средние продажи каждого продавца каждому покупателю
SELECT staff_id, customer_id, AVG(amount) FROM payment
GROUP BY staff_id, customer_id
ORDER BY AVG(amount) DESC;

-- найдем среднюю продолжительность фильма в разрезе рейтингов в 2006 году
SELECT rating, AVG(length) FROM film
WHERE release_year = 2006
GROUP BY rating;


-- Оператор HAVING
-- отберем только фамилии актеров, которые не повторяются
SELECT last_name, COUNT(*) FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

-- отберем и посчитаем только фамилии актеров, которые повторяются
SELECT last_name, COUNT(*) FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

-- найдем фильмы, у которых есть Super в названии 
-- и они сдавались в прокат суммарно более, чем на 5 дней
SELECT title, SUM(rental_duration) FROM film
WHERE title LIKE '%Super%'
GROUP BY title
HAVING SUM(rental_duration) > 5;


-- ALIAS
-- предыдущий запрос с псевдонимами
SELECT title AS t, SUM(rental_duration) AS sum_t FROM film AS f
WHERE title LIKE '%Super%'
GROUP BY t
HAVING SUM(rental_duration) > 5;

-- ключевое слово AS можно не писать
SELECT title t, SUM(rental_duration) sum_t FROM film f
WHERE title LIKE '%Super%'
GROUP BY t
HAVING SUM(rental_duration) > 5;


-- Объединение таблиц
-- выведем имена, фамилии и адреса всех сотрудников
SELECT first_name, last_name, address FROM staff s
LEFT JOIN address a ON s.address_id = a.address_id;

-- определим количество продаж каждого продавца
SELECT s.last_name, COUNT(amount) FROM payment p
LEFT JOIN staff s ON p.staff_id = s.staff_id
GROUP BY s.last_name;

-- посчитаем, сколько актеров играло в каждом фильме
SELECT title, COUNT(actor_id) actor_q FROM film f
JOIN film_actor a ON f.film_id = a.film_id
GROUP BY f.title
ORDER BY actor_q DESC;

-- сколько копий фильмов со словом Super в названии есть в наличии
SELECT title, COUNT(inventory_id) FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE title LIKE '%Super%'
GROUP BY title;

-- выведем список покупателей с количеством их покупок в порядке убывания
SELECT c.last_name n, COUNT(p.amount) amount FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY n
ORDER BY amount DESC;

-- выведем имена и почтовые адреса всех покупателей из России
SELECT c.last_name, c.first_name, c.email FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ON a.city_id = city.city_id
JOIN country co ON city.country_id = co.country_id
WHERE country = 'Russian Federation';

-- фильмы, которые берут в прокат чаще всего
SELECT f.title, COUNT(r.inventory_id) count FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY count DESC;

-- суммарные доходы магазинов
SELECT s.store_id, SUM(p.amount) sales FROM store s 
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- найдем города и страны каждого магазина
SELECT store_id, city, country FROM store s 
JOIN address a ON s.address_id = a.address_id
JOIN city ON a.city_id = city.city_id
JOIN country c ON city.country_id = c.country_id;

-- выведем топ-5 жанров по доходу
SELECT c.name, SUM(p.amount) revenue FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY revenue DESC 
LIMIT 5;

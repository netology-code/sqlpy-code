-- Основы
-- выберем все поля из таблицы film
SELECT * FROM film;

-- выберем столбец title таблицы film
SELECT title FROM film;

-- выберем 2 столбца из таблицы film
SELECT title, release_year FROM film;


-- Как работает DISTINCT
-- выведем столбец rating из film
SELECT DISTINCT rating FROM film;


-- Примеры с арифметикой
-- переведем цены в условные рубли
SELECT amount * 70 FROM payment;

-- узнаем время аренды по позициям
SELECT return_date - rental_date FROM rental;


-- WHERE
-- найдем фильмы, вышедшие после 2000
SELECT title, release_year FROM film
WHERE release_year >= 2000;

-- найдем сотрудников, которые сейчас работают
SELECT first_name, last_name, active FROM staff
WHERE active = true;

-- критерий не обязательно должен входить в выборку
SELECT first_name, last_name FROM staff
WHERE active = true;

-- найдем ID, имена, фамилии актеров, которых зовут Joe
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'Joe';

-- найдем всех сотрудников, которые работают не во втором магазине
SELECT first_name, last_name FROM staff
WHERE store_id != 2;

-- найдем только работающих сотрудников из всех магазинов, кроме 1
SELECT first_name, last_name FROM staff
WHERE active = true AND NOT store_id = 1;

-- найдем фильмы, цена проката которых меньше 0.99, а цена возмещения меньше 9.99
SELECT title, rental_rate, replacement_cost FROM film
WHERE rental_rate <= 0.99 AND replacement_cost <= 9.99;

-- найдем фильмы аналогичные предыдущему примеру или продолжительностью меньше 50 минут
SELECT title, length, rental_rate, replacement_cost FROM film
WHERE rental_rate <= 0.99 AND replacement_cost <= 9.99 OR length < 50;


-- IN / NOT IN
-- найдем фильмы с рейтингом R, NC-17
SELECT title, description, rating FROM film
WHERE rating IN ('R', 'NC-17');

-- найдем недетские фильмы
SELECT title, description, rating FROM film
WHERE rating NOT IN ('G', 'PG');


-- BETWEEN
-- в диапазоне (включая границы)
SELECT title, rental_rate FROM film
WHERE rental_rate BETWEEN 0.99 AND 3;

-- вне диапазона (границы тоже инвертируются => не включая границы)
SELECT title, rental_rate FROM film
WHERE rental_rate NOT BETWEEN 0.99 AND 3;


-- LIKE
-- найдем фильм, в описании которого есть Scientist
SELECT title, description FROM film
WHERE description LIKE '%Scientist%';

-- найдем ID, имена, фамилии актеров, фамилия которых содержит gen
SELECT actor_id, first_name, last_name FROM actor
WHERE last_name LIKE '%gen%';

-- найдем ID, имена, фамилии актеров, фамилия которых оканчивается на gen
SELECT actor_id, first_name, last_name FROM actor
WHERE last_name LIKE '%gen';


-- ORDER BY
-- отсортируем фильмы по цене проката
SELECT title, rental_rate FROM film
ORDER BY rental_rate;

-- по убыванию
SELECT title, rental_rate FROM film
ORDER BY rental_rate DESC;

-- сортируем по нескольким столбцам: продолжительности и цене проката
SELECT title, length, rental_rate FROM film
ORDER BY length DESC, rental_rate ASC;

-- найдем ID, имена, фамилии актеров, чья фамилия содержит li, 
-- отсортируем в алфавитном порядке по фамилии, затем по имени
SELECT actor_id, first_name, last_name FROM actor 
WHERE last_name LIKE '%li%' 
ORDER BY last_name, first_name;


-- LIMIT
-- выведем первые 15 записей
SELECT title, length, rental_rate FROM film
ORDER BY length DESC, rental_rate
LIMIT 15;

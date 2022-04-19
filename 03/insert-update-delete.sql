-- INSERT
-- добавим новый курс
INSERT INTO course(name, description) 
VALUES('Python', 'Python с нуля');

-- можно не перечислять атрибуты, но тогда придется указать их все в VALUES
INSERT INTO course
VALUES(999, 'Java', 'Без описания');

-- пример с нарушением внешнего ключа
INSERT INTO homeworktask(course_id, number, description) 
VALUES(999, 3, 'Описание задачи');

-- проверим
SELECT * FROM homeworktask;


-- UPDATE
-- добавим возврат из проката
UPDATE course
SET description = 'Java с нуля'
WHERE id = 999;

-- проверим
SELECT * FROM course
WHERE id = 999;


-- DELETE
DELETE FROM homeworktask 
WHERE id = 3;

-- удалим запись о прокате
DELETE FROM course 
WHERE id = 999;

-- проверим
SELECT * FROM course;

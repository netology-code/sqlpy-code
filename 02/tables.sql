-- все, что начинается с двух дефисов - это комментарий

-- один к одному (1 вариант)

--CREATE TABLE IF NOT EXISTS Student (
--	email VARCHAR(80) PRIMARY KEY,
--	name VARCHAR(40) NOT NULL,
--	password VARCHAR(128) NOT NULL
--);
--
--CREATE TABLE IF NOT EXISTS StudentInfo (
--	email VARCHAR(80) PRIMARY KEY REFERENCES Student(email),
--	birthday date,
--	city VARCHAR(60),
--	roi TEXT
--);

-- один к одному (2 вариант)

CREATE TABLE IF NOT EXISTS Student (
	id SERIAL PRIMARY KEY,
	email VARCHAR(80) UNIQUE NOT NULL,
	name VARCHAR(40) NOT NULL,
	PASSWORD VARCHAR(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS StudentInfo (
	id INTEGER PRIMARY KEY REFERENCES Student(id),
	birthday date,
	city VARCHAR(60),
	roi TEXT
);

-- один ко многим

CREATE TABLE IF NOT EXISTS Course (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	description TEXT
);

CREATE TABLE IF NOT EXISTS HomeworkTask (
	id SERIAL PRIMARY KEY,
	course_id INTEGER NOT NULL REFERENCES Course(id),
	number INTEGER NOT NULL,
	description TEXT NOT NULL
);

-- многие ко многим (1 вариант)

CREATE TABLE IF NOT EXISTS CourseStudent (
	course_id INTEGER REFERENCES Course(id),
	student_id INTEGER REFERENCES Student(id),
	CONSTRAINT pk PRIMARY KEY (course_id, student_id)
);

-- многие ко многим (2 вариант)

CREATE TABLE IF NOT EXISTS HomeworkSolution (
	id SERIAL PRIMARY KEY,
	task_id INTEGER NOT NULL REFERENCES HomeworkTask(id),
	student_id INTEGER NOT NULL REFERENCES Student(id),
	solution TEXT NOT NULL
);

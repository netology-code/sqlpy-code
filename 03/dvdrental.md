# Загрузка БД DVD Rental

Практиковать новые знания мы будем на готовой базе данных **dvdrental**, которая была составлена специально для тренировочных целей.

Скачать SQL-файлы для ее локальной установки можно здесь:

[dvdrental.zip](./dvdrental.zip)

Далее необходимо:

1. Распаковать архив (появится файл `dvdrental.tar`)
1. Создать БД с названием `dvdrental`:

```bash
createdb -U postgres dvdrental
```

3. Выполнить загрузку данных:

```bash
pg_restore -U postgres -d dvdrental путь_к_вашему_файлу_dvdrental.tar
```

Полная инструкция (на английском):

https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/

Удобное описание этой базы есть здесь:

https://dataedo.com/samples/html/Pagila/doc/Pagila_10/home.html

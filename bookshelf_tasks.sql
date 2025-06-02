-- 1 Найти автора с самым большим числом книг и вывести его имя
select authors.name
from authors
join authors_books on authors.id = authors_books.authors_id
group by authors.id
order by count(authors_books.books_id) desc
limit 1;

-- 2 Вывести пять самых старых книг у которых указан год издания
select title, year
from books
where year is not null
order by year asc
limit 5;

-- 3 Вывести общее количество книг на полке в кабинете
select count(*)
from books
join shelves on books.shelves_id = shelves.id
where shelves.title = 'Полка в кабинете';

-- 4 Вывести названия, имена авторов и годы издания книг, которые находятся на полке в спальне
select books.title, authors.name author_name, books.year
from books
join shelves on books.shelves_id = shelves.id
join authors_books on books.id = authors_books.books_id
join authors on authors_books.authors_id = authors.id
where shelves.title = 'Полка в спальне';

-- 5 Вывести названия и годы издания книг, написанных автором 'Лев Толстой'
select books.title, books.year
from books 
join authors_books on books.id = authors_books.books_id
join authors on authors_id = authors.id
where authors.name = "Лев Толстой"; 

-- 6 Вывести название книг, которые написали авторы, чьи имена начинаются на букву "А"
select books.title
from books 
join authors_books on books.id = authors_books.books_id
join authors on authors_id = authors.id
where authors.name like "А%";

-- 7 Вывести название книг и имена авторов для книг, которые находятся на полках, названия которых включают слова «верхняя» или «нижняя»
select books.title, authors.name 
from books
join shelves on books.shelves_id = shelves.id
left join authors_books on books.id = authors_books.books_id
left join authors on authors_books.authors_id = authors.id
where shelves.title like '%верхняя%' or shelves.title like '%нижняя%';

-- 8 Книгу «Божественная комедия» автора «Данте Алигьери» одолжили почитать другу Ивану Иванову, необходимо написать один или несколько запросов которые отразят это событие в БД
select id into @friend_id 
from friends 
where name like "Иванов Иван";

select books.id into @book_id from books
join authors_books on books.id = authors_books.books_id
join authors on authors_books.authors_id = authors.id
where title like "Божественная комедия" and authors.name like "Данте Алигьери";

update books 
set friends_id = @friend_id
where id = @book_id;

select * from books 
join authors_books on books.id = authors_books.books_id
join authors on authors_books.authors_id = authors.id
where title like "Божественная комедия";

-- 9 Добавить в базу книгу «Краткие ответы на большие вопросы», год издания 2020, автор «Стивен Хокинг», положить ее на полку в кабинете
select id into @shelf_id 
from shelves 
where title = 'Полка в кабинете';
insert into authors (name) values ('Стивен Хокинг');
insert into books (title, year, shelves_id) values ('Краткие ответы на большие вопросы', 2020, @shelf_id);
SELECT LAST_INSERT_ID() into @book_id;
insert into authors_books (books_id, authors_id) values (@book_id, @author_id);
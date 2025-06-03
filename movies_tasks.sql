-- 1. Вывести сколько фильмов сняла кинокомпания Universal Pictures

select count(*) from movies 
join companies on movies.companies_id = companies.id
where companies.title = "Universal Pictures";

-- 2. Вывести сколько всего фильмов было снято режиссером Фрэнсисом Фордом Копполой

select count(*) from movies 
join directors on movies.directors_id = directors.id
where directors.full_name = "Фрэнсис Форд Коппола";

-- 3. Вывести количество снятых фильмов за последние 20 лет

select count(*) from movies 
where year > (year(curdate()) - 20);

-- 4. Вывести все жанры фильмов в которых снимал Стивен Спилберг в течении всей своей карьеры

select distinct genres.title from genres 
join movies on genres.id = movies.genres_id
join directors on movies.directors_id = directors.id 
where directors.full_name = "Стивен Спилберг";

-- 5. Вывести названия, жанры и режиссеров 5 самых дорогих фильмов

select movies.title, genres.title genre, directors.full_name director from movies 
join directors on movies.directors_id = directors.id
join genres on movies.genres_id = genres.id
order by budget
limit 5;

-- 6.Вывести имя режиссера с самым большим количеством фильмов

select full_name, count(movies.id) from movies
join directors on  movies.directors_id = directors.id 
group by directors.full_name
order by count(movies.id) desc
limit 1;
 
-- 7. Вывести названия и жанры фильмов, снятые самой большой кинокомпанией (по сумме всех бюджетов фильмов)

select movies.title, genres.title 
from movies 
join companies on movies.companies_id = companies.id
join genres on movies.genres_id = genres.id 
where movies.companies_id = ( 
select companies.id 
from movies 
join companies on movies.companies_id = companies.id
group by companies.id 
order by sum(movies.budget) desc 
limit 1
);

-- 8. Вывести средний бюджет фильмов, снятых кинокомпанией Warner Bros.

select avg(budget)
from movies 
join companies on movies.companies_id = companies.id
where companies.title = "Warner Bros.";

-- 9. Вывести количество фильмов каждого жанра и средний бюджет по жанру

select genres.title, count(movies.id) films_count, avg(budget)
from movies 
join genres on movies.genres_id = genres.id
group by genres.title;

-- 10. Найти и удалить комедию "Дикие истории" 2014-го года

delete from movies
where id = (
select movies.id
from movies
join genres on movies.genres_id = genres.id
where movies.title = 'Дикие истории' and movies.year = 2014 and genres.title = 'Комедия'
limit 1
);
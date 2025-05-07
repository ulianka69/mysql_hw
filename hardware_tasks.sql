-- 1 Вывести сумму  единиц техники
SELECT SUM(amount)
FROM hardware;

-- 2 Товары которые закончились
SELECT *
from hardware
where amount = 0

-- 3 Вывести среднюю цену монитора
SELECT AVG(price) 
FROM hardware
WHERE title LIKE '%Монитор%';

-- 4 Вывести все клавиатуры от дешёвой до дорогой
SELECT * FROM hardware 
WHERE title LIKE '%Клавиатура%' 
ORDER BY PRICE ASC;

-- 5 Вывести в рамках одного запроса количество товарных позиций по каждому тегу с использованием группировки, результаты отсортировать от максимального количества до минимального (товары без тегов не учитываем)
select  count(*) as qwe
from hardware
where tag is not null
group by tag
order by qwe desc;
-- 6.Вывести количество товарных позиций со скидками на складе
select count(*) as qwe
from hardware
where tag = 'discount';
-- 7.Вывести название и цену самой дорогой новинки
select title,price
from hardware
where tag = 'new'
order by price desc
LIMIT 1;
-- 8.Добавить в таблицу товар Ноутбук Lenovo 2BXKQ7E9XD как новинку по цене 54500 руб. в единственном экземпляре
insert into hardware(title,price,amount,tag)
values ('Ноутбук Lenovo 2BXKQ7E9XD',54500,1,new);
-- 9.Найти и удалить по названию из базы ошибочно добавленный товар Очки PS VR 2 (задачу можно решить как одним запросом, так и двумя разными, принимаются оба варианта решения, при этом не забудьте что в запросе должен формально присутствовать первичный ключ, иначе safe_mode не позволит его выполнить и вы увидите ошибку Error Code: 1175)
delete from hardware
where title = 'Очки PS VR 2' AND id > 1;

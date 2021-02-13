-------------------------집합---------------------------
--data 생성
create table s1 
( name varchar(50),
  amount numeric(15, 2)
);

insert into s1
values
('다은', 150000.25),
('둥현', 132000.75),
('피자연구', 100000);

create table s2
( name varchar(50),
  amount numeric(15, 2)
);

insert into s2
values
('다은', 120000.25),
('둥현', 142000.75),
('피자연구', 100000);

select * from s1;

--union : 중복 데이터 삭제
select * from s1
union 
select * from s2  --s1, s2 둘다 중복된 것 삭제
order by amount desc;  -- order은 맨 마지막에 쓰기!

select name from s1
union 
select name from s2;  --name 기준 중복 값 삭제

--union all : 중복 데이터도 출력
select * from s1
union all
select * from s2  
order by amount desc;  

--intersect : 교집합만 출력
select name from s1
intersect 
select name from s2;

--except 
select film_id, title from film  --A 
except -- A에서 B를 뺀다
select distinct inventory.film_id, title from inventory  --B 
inner join film 
on film.film_id = inventory.film_id
order by title;
--재고가 존재하지 않는 영화만 남음



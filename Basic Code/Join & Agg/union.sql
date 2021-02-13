-------------------------����---------------------------
--data ����
create table s1 
( name varchar(50),
  amount numeric(15, 2)
);

insert into s1
values
('����', 150000.25),
('����', 132000.75),
('���ڿ���', 100000);

create table s2
( name varchar(50),
  amount numeric(15, 2)
);

insert into s2
values
('����', 120000.25),
('����', 142000.75),
('���ڿ���', 100000);

select * from s1;

--union : �ߺ� ������ ����
select * from s1
union 
select * from s2  --s1, s2 �Ѵ� �ߺ��� �� ����
order by amount desc;  -- order�� �� �������� ����!

select name from s1
union 
select name from s2;  --name ���� �ߺ� �� ����

--union all : �ߺ� �����͵� ���
select * from s1
union all
select * from s2  
order by amount desc;  

--intersect : �����ո� ���
select name from s1
intersect 
select name from s2;

--except 
select film_id, title from film  --A 
except -- A���� B�� ����
select distinct inventory.film_id, title from inventory  --B 
inner join film 
on film.film_id = inventory.film_id
order by title;
--��� �������� �ʴ� ��ȭ�� ����



--data ����
CREATE TABLE sales 
(
brand varchar NOT NULL, 
segment varchar NOT NULL, 
quantity int NOT NULL,
PRIMARY KEY (brand, segment)
)
INSERT INTO sales (brand, segment, quantity)
VALUES
('����Ű', 'Premium', 100),
('����Ű', 'Basic', 200),
('�Ƶ�ٽ�', 'Premium', 100),
('�Ƶ�ٽ�', 'Basic', 300);

select * from sales;

------------------ ���� �Լ� ----------------------------
-- groupby
select segment, count(quantity) from sales
group by segment;

select sum(quantity) from sales; --��ü �հ� ���ϱ�

-- grouping sets
select brand, segment, sum(quantity) from sales 
group by grouping sets(
(brand, segment), (brand), (segment), ()
);

-- roll up
select
	brand,
	segment,
	sum(quantity)
from
	sales
group by
	rollup(brand,
	segment)
	--rollup(brand, segment)   --�κ� rollup

	order by brand,
	segment;


-- cube
select
	brand,segment,sum(quantity)
from
	sales
group by
	cube (brand,segment)
order by
	brand,segment;

------------------ �м� �Լ� ----------------------------
create table product_group2 (
group_id varchar(255) primary key, 
group_name varchar(255) not null
);

create table product2(
product_id varchar(255) primary key,
product_name varchar (255) not null,
price decimal(11,2),
group_id int not null,
foreign key (group_id) references product_groups (group_id)
);

insert into product_group2(group_id, group_name)
values
(1, '����Ʈ��'), (2, '��ž'), (3, 'Ÿ��')
;

select * from product_group2;

insert into product2 (product_name, group_id, price)
values
('������12', 1, 200),
('������13', 1, 250),
('������14', 1, 220),
('������15', 1, 240),
('�ַ���', 2, 300),
('�ַ���2', 2, 600),
('������', 3, 400)
;

select * from product2;
select count(*) from product2; --�ܼ� count ����ϴ� �����Լ�

-- ������ �����Ӱ� ���� ����ϱ�
select count(*) over(), A.* from product2 A;

-- AVG �Լ�
select avg(price) as mean_price from product2;  --������ ���

-- join, groupby�� ����
select
	b.group_name,
	avg(price)
from
	product2 a
	-- mean���� groupby
inner join product_group2 b on
	a.group_id = b.group_id
group by
	b.group_name;

-- ������ + �����������ӵ� ����ϱ�
select
	a.product_name,
	a.price,
	b.group_name,
	avg(a.price) over(partition by b.group_name) as group_mean
	--������, �׷����
	from product2 a
	
inner join product_group2 b on
	a.group_id = b.group_id;
--over(partition by b.group_name order by a.price) : �ڿ� order ���̸� �������
--�� �׷��� ������ Į���� �׷� ���� ������� ä����

--Row_number, Rank, Dense_rank
select
	a.product_name,
	b.group_name,
	a.price,
	row_number () over (partition by b.group_name
order by
	a.price) as rank
from
	product2 a
inner join product_group2 b on
	a.group_id = b.group_id ;

--first_value
select
	a.product_name,
	b.group_name,
	a.price,
	first_value(a.price) over (partition by b.group_name
order by
	a.price) as lowest_price
from
	product2 a
inner join product_group2 b on
	a.group_id = b.group_id ;

--last_value (ó��, �������κ� ���� ���� �ʿ�!!)
select
	a.product_name,
	b.group_name,
	a.price,
	last_value(a.price) over (partition by b.group_name
order by
	a.price desc range between unbounded preceding and unbounded following)
	-- ��Ƽ���� ù��° �ο���� �������ο����
 as lowest_price
from
	product2 a
inner join product_group2 b on
	a.group_id = b.group_id ;

--Lag, Lead �Լ� : ����, ������ ����
select
	a.product_name,
	b.group_name,
	a.price,
	lead(a.price, 1) over (partition by b.group_name order by a.price) as next_price,
	a.price - lead(a.price, 1) over(partition by group_name order by a.price) as cur_next_diff
from
	product2 a
inner join product_group2 b on
	a.group_id = b.group_id ;


--data 생성
CREATE TABLE sales 
(
brand varchar NOT NULL, 
segment varchar NOT NULL, 
quantity int NOT NULL,
PRIMARY KEY (brand, segment)
)
INSERT INTO sales (brand, segment, quantity)
VALUES
('나이키', 'Premium', 100),
('나이키', 'Basic', 200),
('아디다스', 'Premium', 100),
('아디다스', 'Basic', 300);

select * from sales;

------------------ 집계 함수 ----------------------------
-- groupby
select segment, count(quantity) from sales
group by segment;

select sum(quantity) from sales; --전체 합계 구하기

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
	--rollup(brand, segment)   --부분 rollup

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

------------------ 분석 함수 ----------------------------
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
(1, '스마트폰'), (2, '랩탑'), (3, '타블랫')
;

select * from product_group2;

insert into product2 (product_name, group_id, price)
values
('아이폰12', 1, 200),
('아이폰13', 1, 250),
('아이폰14', 1, 220),
('아이폰15', 1, 240),
('겔럭시', 2, 300),
('겔럭시2', 2, 600),
('샤오미', 3, 400)
;

select * from product2;
select count(*) from product2; --단순 count 출력하는 집계함수

-- 데이터 프레임과 같이 출력하기
select count(*) over(), A.* from product2 A;

-- AVG 함수
select avg(price) as mean_price from product2;  --가격의 평균

-- join, groupby와 결합
select
	b.group_name,
	avg(price)
from
	product2 a
	-- mean으로 groupby
inner join product_group2 b on
	a.group_id = b.group_id
group by
	b.group_name;

-- 집계결과 + 데이터프레임도 출력하기
select
	a.product_name,
	a.price,
	b.group_name,
	avg(a.price) over(partition by b.group_name) as group_mean
	--집계결과, 그룹평균
	from product2 a
	
inner join product_group2 b on
	a.group_id = b.group_id;
--over(partition by b.group_name order by a.price) : 뒤에 order 붙이면 누적평균
--각 그룹의 마지막 칼럼은 그룹 누적 평균으로 채워짐

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

--last_value (처음, 마지막부분 조건 지정 필요!!)
select
	a.product_name,
	b.group_name,
	a.price,
	last_value(a.price) over (partition by b.group_name
order by
	a.price desc range between unbounded preceding and unbounded following)
	-- 파티션의 첫번째 로우부터 마지막로우까지
 as lowest_price
from
	product2 a
inner join product_group2 b on
	a.group_id = b.group_id ;

--Lag, Lead 함수 : 이전, 다음행 추출
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


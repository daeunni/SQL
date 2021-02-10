--2개 테이블 inner join
select a.customer_id, a.first_name, a.last_name, a.email, 
b.amount, b.payment_date --선택할 칼럼
from customer a
inner join payment b -- a와 b를 merge
on a.customer_id = b.customer_id  --customer_id가 같은거끼리
where a.customer_id = 2  -- customer_id가 2인 row만 조회하기
;

--3개 테이블 inner join 
select a.customer_id, a.first_name, a.last_name, a.email, 
b.amount, b.payment_date, -- 선택할 칼럼은 맨 마지막에 선택하자
c.first_name as s_first_name, c.last_name as s_last_name 
from customer a
inner join payment b on a.customer_id = b.customer_id 
inner join staff c on b.staff_id = c.staff_id 
;

--left, right outer join
select a.id as id_a, 
a.fruit as fruit_a,
b.id as id_b,
b.fruit as fruit_b
from basket_a a
left join basket_b b -- a를 기준으로 b를 합친다. a는 다출력함
-- 만약에 a에 해당하는 b가 없으면 b는 NULL값으로 출력함
on a.fruit = b.fruit;
where b.id is null;  -- left outer only : 교집합 빼고 a 존재하는 부분만 출력


--self join
create table employee
(
employee_id int primary key, 
first_name varchar (255) not null,
last_name varchar (255) not null,
manager_id int,
foreign key (manager_id) references employee (employee_id)
on delete cascade
);

insert into employee(employee_id, first_name, last_name, manager_id)
values 
(1, '다은', '이', NULL),
(2, '동현', '김', 1),
(3, '다연', '기', 2),
(4, '다은', '최', 3),
(5, '배고', '파', 3),
(6, '졸', '려', 2);

--inner self join
select *
from employee e
inner join employee m  -- e와 m의 정확히 일치되는 교집합만 출력
on m.employee_id = e.manager_id  -- employee_id와 manager_id가 정확히 일치되는 부분
; 
--m에서는 employee_id를 가져오고, e에서는 manager_id를 가져옴

--outer self join
select *
from employee e
left join employee m  -- e를 기준으로 일치되는게 있으면 m도 출력 (그럼 null도 출력됨)
on m.employee_id = e.manager_id  
; 

--부정형 조건 (inner 조건에 추가)
select f1.title, f2.title, f1.length from film f1
inner join film f2
on f1.film_id <> f2.film_id and f1.length = f2.length -- 필름 아이디는 다른데 상영시간은 똑같은 것
;



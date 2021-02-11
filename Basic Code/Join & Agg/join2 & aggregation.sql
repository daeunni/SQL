-------------------------Full outer join-------------------------------
create table
if not exists d -- 존재하지 않으면 생성
( department_id serial primary key,  --인덱스 생성하는 range 기능
department_name varchar (255) not null
);

create table
if not exists e
(employee_id serial primary key,
employee_name varchar(255),
department_id integer
);

insert into d(department_name)
values ('sales'), ('Marketing'), ('Hr'), ('IT'), ('production');

insert into e(employee_name, department_id)
values ('다은', 1), ('둥현', 2), ('졸려', 2), ('왤케하기싫지', 3), ('아아', NULL);

-- Full outer join
select e.employee_name, d.department_name from e 
full outer join d on d.department_id = e.department_id;

---------------- 공통된거 제외하는 only full outer join-------------------
select e.employee_name, d.department_name from e 
full outer join d on d.department_id = e.department_id
where e.employee_name is null;  --오른쪽에 해당하는 부분만 출력
-- where d.department_name is null; --왼쪽에 해당하는 부분만 출력

--------------- cross join : join 가능한 모든 경우의수 출력----------------------
create table cross_t1
(label char(1) primary key);

create table cross_t2
(score int primary key);

insert into cross_t1 (label)
values ('A'), ('B');

insert into cross_t2 (score)
values (1), (2), (3);

select * from cross_t1
cross join cross_t2
order by label;

select * from cross_t1, cross_t2 
order by label;  --이것도 동일한 결과 (동일한 sql문)

-------------------- Natural join(inner join의 자동화)----------------------------
select * from city a 
natural join country b;  --공통 칼럼이 두개 이상이라서 출력되지 않는다(실무에서 잘 안씀)


------------------------------ Groupby 절------------------------------------------
select customer_id from payment 
group by customer_id;  --unique한 customer_id만 출력

select distinct customer_id from payment;  --이거랑 같은 값

--groupby 별 연산하기
select customer_id, sum(amount) as amount_sum, count(amount) as amount_count from payment 
group by customer_id --고객 id로 groupby
having sum(amount) > 200 --groupby 결과 중 특정 조건의 열만 출력 
order by sum(amount) desc
;

select store_id, count(customer_id) as customer수 from customer
group by store_id 
having count(customer_id)>300
;

-------------------------Grouping set절 ---------------------------------------



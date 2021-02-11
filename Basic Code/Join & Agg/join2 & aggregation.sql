-------------------------Full outer join-------------------------------
create table
if not exists d -- �������� ������ ����
( department_id serial primary key,  --�ε��� �����ϴ� range ���
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
values ('����', 1), ('����', 2), ('����', 2), ('�����ϱ����', 3), ('�ƾ�', NULL);

-- Full outer join
select e.employee_name, d.department_name from e 
full outer join d on d.department_id = e.department_id;

---------------- ����Ȱ� �����ϴ� only full outer join-------------------
select e.employee_name, d.department_name from e 
full outer join d on d.department_id = e.department_id
where e.employee_name is null;  --�����ʿ� �ش��ϴ� �κи� ���
-- where d.department_name is null; --���ʿ� �ش��ϴ� �κи� ���

--------------- cross join : join ������ ��� ����Ǽ� ���----------------------
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
order by label;  --�̰͵� ������ ��� (������ sql��)

-------------------- Natural join(inner join�� �ڵ�ȭ)----------------------------
select * from city a 
natural join country b;  --���� Į���� �ΰ� �̻��̶� ��µ��� �ʴ´�(�ǹ����� �� �Ⱦ�)


------------------------------ Groupby ��------------------------------------------
select customer_id from payment 
group by customer_id;  --unique�� customer_id�� ���

select distinct customer_id from payment;  --�̰Ŷ� ���� ��

--groupby �� �����ϱ�
select customer_id, sum(amount) as amount_sum, count(amount) as amount_count from payment 
group by customer_id --�� id�� groupby
having sum(amount) > 200 --groupby ��� �� Ư�� ������ ���� ��� 
order by sum(amount) desc
;

select store_id, count(customer_id) as customer�� from customer
group by store_id 
having count(customer_id)>300
;

-------------------------Grouping set�� ---------------------------------------



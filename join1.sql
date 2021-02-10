--2�� ���̺� inner join
select a.customer_id, a.first_name, a.last_name, a.email, 
b.amount, b.payment_date --������ Į��
from customer a
inner join payment b -- a�� b�� merge
on a.customer_id = b.customer_id  --customer_id�� �����ų���
where a.customer_id = 2  -- customer_id�� 2�� row�� ��ȸ�ϱ�
;

--3�� ���̺� inner join 
select a.customer_id, a.first_name, a.last_name, a.email, 
b.amount, b.payment_date, -- ������ Į���� �� �������� ��������
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
left join basket_b b -- a�� �������� b�� ��ģ��. a�� �������
-- ���࿡ a�� �ش��ϴ� b�� ������ b�� NULL������ �����
on a.fruit = b.fruit;
where b.id is null;  -- left outer only : ������ ���� a �����ϴ� �κи� ���


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
(1, '����', '��', NULL),
(2, '����', '��', 1),
(3, '�ٿ�', '��', 2),
(4, '����', '��', 3),
(5, '���', '��', 3),
(6, '��', '��', 2);

--inner self join
select *
from employee e
inner join employee m  -- e�� m�� ��Ȯ�� ��ġ�Ǵ� �����ո� ���
on m.employee_id = e.manager_id  -- employee_id�� manager_id�� ��Ȯ�� ��ġ�Ǵ� �κ�
; 
--m������ employee_id�� ��������, e������ manager_id�� ������

--outer self join
select *
from employee e
left join employee m  -- e�� �������� ��ġ�Ǵ°� ������ m�� ��� (�׷� null�� ��µ�)
on m.employee_id = e.manager_id  
; 

--������ ���� (inner ���ǿ� �߰�)
select f1.title, f2.title, f1.length from film f1
inner join film f2
on f1.film_id <> f2.film_id and f1.length = f2.length -- �ʸ� ���̵�� �ٸ��� �󿵽ð��� �Ȱ��� ��
;



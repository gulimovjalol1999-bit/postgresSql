create database "lesson2";

\c lesson2

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    birthYear INT NOT NULL
);

\copy "users"(username, email, birthYear) from '/home/jaloliddin/Desktop/MOCK_DATA.csv' csv header;

insert into users(username, email, birthYear) values();

-- simple indexing
create index simple2_indexing on teachers(teachers_id);

-- unique indexing
create unique index unique_indexing on users(username);

-- composite indexing 
create index username_email_indexing on users(username, email);

-- functional indexing
create index functional_indexing on users(lower(username));

-- partial indexing
create index partial_indexing on users(birthYear) where birthYear > 2000;


select * from users order by birthYear asc;

select * from users order by username asc;

select * from users where birthYear > 2000 order by username asc;

select * from users where birthYear > 2000 order by username asc limit 5;

select * from users where birthYear > 2000 order by username asc offset 10 limit 5;

select birthYear, count(*) from users group by birthYear;

select birthYear, count(*) from users group by birthYear order by count(birthYear) asc;


create table if not exists employees (
  id SERIAL PRIMARY key,
  name varchar not null,
  departament varchar not null,
  salary float not null
);

insert into employees(name, departament, salary) values('ibrat2', 'cyber security', 3000), ('botir2', 'node.js', 2000), ('saida2', 'director', 300), ('muxlisa2', 'software engineer', 5000), ('durdona2', 'designer', 900);


select departament, avg(salary) as avg_salary
from employees
group by departament
having avg(salary) > 500;

select from employees
group by departament
having sum(salary) > 2000;


-- Transaction

Start Transaction;

-- 1. Hisobdan pul yechish
update account set balance = balance - 1004 where account_id = 1;

-- 2. Boshqa hisobga publ kiritsh
update account set balance = balance + 1000 where account_id = 2;

-- Tranzaksiyani tasdiqlash
commit;


Start Transaction;

update accounts set balance = balance - 500 where account_id = 1;
SAVEPOINT step1;

update accounts set balance = balance + 500 where account_id = 2;

-- Agar muammo yuzaga kelsa 
Rollback to step1;

commit;


select * from users where username ilike '%a';

select * from users where username ilike '%a' and id > 500;


select * from employees where salary between 500 and 1000;
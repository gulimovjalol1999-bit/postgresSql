create database homework3;

create table Customers (
  id serial primary key,
  name varchar not null,
  phone_number varchar not null
);

insert into Customers (name, phone_number) values
('Ali Valiyev', '+998901112233'),
('Sardor Karimov', '+998933334455'),
('Dilshod Rahimov', '+998977778899'),
('Aziza Tursunova', '+998909876543'),
('Jasmina Xolmatova', '+998935551122');


create table Products (
  id serial primary key,
  title varchar not null,
  price float not null
);

insert into Products (title, price) values
('iPhone 13', 900),
('Samsung Galaxy S22', 850),
('MacBook Air M1', 1200),
('AirPods Pro', 250),
('Dell XPS 13', 1100);

insert into Products (title, price) values('iPhone 17', 1600);


create table Orders (
  id serial primary key,
  customer_id int not null,
  product_id int not null,
  amount int not null
);

alter table Orders
add constraint fk_customer_id
foreign key(customer_id)
references Customers(id);

alter table Orders
add constraint fk_product_id
foreign key(product_id)
references Products(id);


insert into Orders(customer_id, product_id, amount) values(1, 3, 1);
insert into Orders(customer_id, product_id, amount) values(2, 1, 1);
insert into Orders(customer_id, product_id, amount) values(3, 2, 1);
insert into Orders(customer_id, product_id, amount) values(4, 4, 1);
insert into Orders(customer_id, product_id, amount) values(5, 5, 1);
insert into Orders(customer_id, product_id, amount) values(1, 4, 1);

------------joins 
--1
select c.id, c.name, c.phone_number, p.title as product_name, o.amount, p.price, (o.amount * p.price) as total_price 
from Orders o 
join Customers c on customer_id = c.id
join Products p on product_id = p.id;
--2
select
  o.id as order_id,
  c.name,
  p.title as product_title,
  o.amount,
  p.price,
  (p.price * o.amount) as total_price
from Orders o 
join Customers c on customer_id = c.id
join Products p on product_id = p.id;
--3
select
  p.id as product_id,
  p.title as product_title
from Products p
left join Orders o on p.id = product_id 
where o.id IS null;
--4
SELECT *
FROM Customers
FULL JOIN Products
ON Customers.id = Products.id;

-----------------------------------------------------------------------------------------

CREATE TABLE Students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO Students (name) VALUES
('Ali Valiyev'),
('Vali Karimov'),
('Sardor Bekzodov'),
('Madina Islomova'),
('Aziza Qodirova'),
('Javlon Rahimov'),
('Dilnoza Tursunova'),
('Bekzod Nurmatov'),
('Shahzod Ergashev'),
('Zarina Abdukarimova');


CREATE TABLE Courses (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

INSERT INTO Courses (title) VALUES
('Matematika'),
('Fizika'),
('Ingliz tili'),
('Dasturlash asoslari'),
('Malumotlar bazasi'),
('Algoritmlar va Data Structures'),
('Web dasturlash'),
('Suniy intellekt'),
('Kiberxavfsizlik'),
('Tarmoq asoslari');


create table enrollments (
  student_id int,
  course_id int,
  primary key (student_id, course_id),
  foreign key(student_id) references Students(id),
  foreign key(course_id) references Courses(id)
);

insert into enrollments(student_id, course_id) values(1, 1), (1, 3), (2, 2), (5, 8);
insert into enrollments(student_id, course_id) values(2, 1), (2, 3), (1, 8);
--------------
select s.name, c.title 
from Students s 
join enrollments e on s.id = e.student_id
join Courses c on e.course_id = c.id;
-----------

SELECT 
    s.name
FROM Students s
LEFT JOIN Enrollments e ON s.id = e.student_id
WHERE e.student_id IS NULL
--------------------------------------
SELECT 
    c.title
FROM Courses c
LEFT JOIN Enrollments e ON c.id = e.course_id
WHERE e.course_id IS NULL;

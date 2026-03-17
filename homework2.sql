

create table if not exists "students" (
  student_id serial primary key,
  full_name varchar(100) not null,
  baholari int not null,
  qayerdan varchar not null,
  birth_date date not null,
  courseName varchar not null
);




alter table students
add constraint check_baholari check (baholari >= 0 and baholari <= 100);

insert into students (full_name, baholari, qayerdan, birth_date)
values 
('Ali Valiyev', 85, 'Toshkent', '2005-03-12'),
('Sardor Karimov', 92, 'Samarqand', '2004-07-25'),
('Dilshod Xasanov', 76, 'Buxoro', '2006-01-10'),
('Javohir Tursunov', 88, 'Fargona', '2005-11-03'),
('Bekzod Rahimov', 67, 'Namangan', '2003-09-18');

insert into students (full_name, baholari, qayerdan, birth_date)
values 
('Azizbek Aliyev', 90, 'Andijon', '2005-05-05'),
('Shohruh Yoqubov', 73, 'Xorazm', '2004-02-20'),
('Umidjon Qodirov', 81, 'Qashqadaryo', '2006-08-14'),
('Boburjon Islomov', 95, 'Surxondaryo', '2005-12-30'),
('Islombek Nazarov', 60, 'Toshkent', '2003-06-11');

insert into students (full_name, baholari, qayerdan, birth_date)
values 
('Akmal Sobirov', 78, 'Toshkent', '2005-04-21'),
('Diyorbek Qodirov', 88, 'Samarqand', '2004-09-13'),
('Sherzod Ismoilov', 91, 'Buxoro', '2006-02-28'),
('Oybek Tursunov', 69, 'Fargona', '2005-07-17'),
('Sanjar Rahmatov', 84, 'Namangan', '2003-12-05');

insert into students (full_name, baholari, qayerdan, birth_date)
values 
('Ibrohim Yoqubov', 86, 'Toshkent', '2005-02-11'),
('Farrux Ganiev', 74, 'Samarqand', '2004-06-29'),
('Kamron Usmonov', 93, 'Buxoro', '2006-09-15'),
('Zafar Abdullayev', 68, 'Fargona', '2005-01-04'),
('Nodirbek Xolmurodov', 80, 'Namangan', '2003-11-22');

insert into students (full_name, baholari, qayerdan, birth_date)
values('Yoldosh', 100, 'Karakalpak', '2007-03-23'),
('Shoxrux Rustamov', 88, 'Toshkent', '2005-08-03'),
('Odilbek Rasulov', 92, 'Samarqand', '2004-04-12'),
('Jasurbek Xolmatov', 75, 'Buxoro', '2006-05-21'),
('Davronbek Tursunov', 81, 'Fargona', '2005-09-14'),
('Fazliddin Karimov', 66, 'Namangan', '2003-02-27');


CREATE TABLE IF NOT EXISTS courses (
    course_id serial PRIMARY KEY,
    course_name varchar(100) NOT NULL,
    teacher_name varchar(100)
);
  

INSERT INTO courses (course_name, teacher_name) VALUES
('Matematika', 'Dr. Akmalov'),
('Fizika', 'Prof. Karimov'),
('Informatika', 'Sh. Tursunov'),
('Biologiya', 'O. Rahimov'),
('Kimyo', 'F. Yusupov'),
('Tarix', 'S. Tursunov'),
('Ingliz tili', 'N. Usmonova'),
('Geografiya', 'M. Rasulov'),
('Adabiyot', 'D. Karimov'),
('Falsafa', 'A. Sobirov');



--1
create index simple_indexing on students(student_id);
--2
select * from students order by baholari desc; 
select * from students order by baholari asc; 
--3
select * from students offset 4 limit 10;
--4
select qayerdan, count(*) from students group by qayerdan;
--5
select birth_date as tugilgan_sana from students;
--6
select full_name from students union select course_name from courses;
--7
select * from students where baholari > 80;
--9
select * from students where baholari between 70 and 90 or qayerdan = 'Toshkent';
--10
select * from students where full_name ilike 'sh%' or full_name ilike '%sh';

----------------------------------------------------------------------------------------
create table if not exists "teachers" (
  teachers_id serial primary key,
  full_name varchar not null,
  viloyati varchar not null,
  age int not null
);

INSERT INTO teachers (full_name, viloyati, age) VALUES
('Ali Karimov', 'Toshkent', 35),
('Dilnoza Rahimova', 'Samarqand', 29),
('Sardor Tursunov', 'Buxoro', 41),
('Malika Usmonova', 'Fargona', 33),
('Jasur Xolmatov', 'Namangan', 38),
('Nodira Qodirova', 'Andijon', 27),
('Bekzod Ergashev', 'Xorazm', 45),
('Shahlo Ismoilova', 'Qashqadaryo', 31),
('Otabek Rasulov', 'Surxondaryo', 36),
('Farrux Tadjiev', 'Toshkent', 40);

--1
create index simple2_indexing on teachers(teachers_id);
--2
select full_name, baholari from students order by baholari desc limit 10;
--3
SELECT coursename, AVG(baholari) AS avg_grade
FROM students
GROUP BY coursename
HAVING AVG(baholari) > 85;
--4
 
--5
SELECT * FROM teachers WHERE (age BETWEEN 18 AND 25) OR (viloyati IN ('Samarqand', 'Xorazm'));
--6
select * from students where full_name ilike '%o';
select * from teachers where full_name ilike 'R%';
--7
select * from teachers offset 19 limit 5;
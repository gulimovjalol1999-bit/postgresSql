create table students (
  id serial primary key,
  name varchar not null,
  birth_date date not null
);

insert into students (name, birth_date) values
('Ali Valiyev', '2005-03-12'),
('Sardor Karimov', '2004-07-25'),
('Dilshod Rahimov', '2005-11-02'),
('Jasmina Aliyeva', '2006-01-15'),
('Bekzod Tursunov', '2003-09-30'),
('Malika Ismoilova', '2005-06-18'),
('Azizbek Qodirov', '2004-12-05'),
('Nigora Xasanova', '2006-04-22'),
('Shoxrux Ergashev', '2003-08-10'),
('Zarina Murodova', '2005-02-27');

create table courses (
  id serial primary key,
  title varchar(100) not null
);

insert into courses (title) values
('Mathematics'),
('Physics'),
('Programming'),
('Database'),
('English');

create table enrollments (
  id serial primary key,
  student_id int not null,
  course_id int not null,
  grade int,

  constraint fk_student
    foreign key (student_id)
    references students(id)
    on delete cascade on update cascade,

  constraint fk_course
    foreign key (course_id)
    references courses(id)
    on delete cascade on update cascade
);

insert into enrollments (student_id, course_id, grade) values
(1, 1, 85),
(1, 2, 90),
(2, 1, 78),
(2, 3, 88),
(3, 2, 91),
(3, 4, 83),
(4, 1, 67),
(4, 5, 72),
(5, 3, 95),
(5, 4, 89),
(6, 2, 80),
(6, 5, 84),
(7, 1, 73),
(7, 3, 77),
(8, 4, 92),
(8, 5, 86),
(9, 2, 79),
(10, 1, 88),
(10, 2, 90),
(10, 3, 85);


--1
create or replace function age_calculator(birth_date date)
returns int as $$
begin 
  return extract(year from age(current_date, birth_date));
end;
$$ language plpgsql;

select name, age_calculator(birth_date) as age from students;

--2
create or replace procedure enroll_students(
  p_course_id int,
  p_student_ids int[]
)
language plpgsql
as $$
declare
  s_id int;
begin
  foreach s_id in array p_student_ids
  loop
    insert into enrollments (student_id, course_id)
    values (s_id, p_course_id);
  end loop;
end;
$$;

call enroll_students(1, array[1,2,3,4]);

--3
create table if not exists notifications (
  id serial primary key,
  student_id int not null,
  message text not null,
  created_at timestamp default current_timestamp
);

create or replace function grade_update_notification_function()
returns trigger as $$
begin
    if new.grade < old.grade then
      insert into notifications (student_id, message)
      values (new.student_id, 'Your grade has decreased to ' || new.grade);
    end if;
    return new;
end;
$$ language plpgsql;


create trigger grade_update_notification
after update on enrollments
for each row
execute function grade_update_notification_function();

update enrollments
set grade = 80
where student_id = 1 and course_id = 1;

select * from notifications;

--4
create or replace function student_average_grade(
    p_student_id int,
    p_course_id int
)
returns numeric as $$
declare
    avg_grade numeric;
begin
    select avg(grade)
    into avg_grade
    from enrollments
    where student_id = p_student_id
      and course_id = p_course_id;

    return avg_grade;
end;
$$ language plpgsql;

select student_average_grade(1, 1);

--5
create or replace function prevent_duplicate_enrollment()
returns trigger as $$
begin
    if exists (
        select 1 
        from enrollments 
        where student_id = new.student_id
          and course_id = new.course_id
    ) then
        raise exception 'Student % is already enrolled in course %', new.student_id, new.course_id;
    end if;

    return new;  
end;
$$ language plpgsql;

create trigger check_duplicate_enrollment
before insert on enrollments
for each row
execute function prevent_duplicate_enrollment();

insert into enrollments(student_id, course_id, grade) values (1,1,85);

insert into enrollments(student_id, course_id, grade) values (1,1,90);

-----------------------------------------------------------------------
--1
create or replace function best_student_in_course(
    p_course_id int
)
returns table(
    student_name varchar,
    grade int,
    enrolled_at date
) as $$
begin
    return query
    select s.name, e.grade, current_date 
    from enrollments e
    join students s on s.id = e.student_id
    where e.course_id = p_course_id
    order by e.grade desc
    limit 1;
end;
$$ language plpgsql;

select * from best_student_in_course(1);

--2
CREATE OR REPLACE FUNCTION get_kurs_talabalar_soni(
    p_course_id INT
)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_son INT;
BEGIN
    SELECT COUNT(*) INTO v_son
    FROM enrollments
    WHERE course_id = p_course_id;

    RETURN v_son;
END;
$$;

SELECT get_kurs_talabalar_soni(3);

--3
create or replace function student_enrollment_notification()
returns trigger as $$
begin
    insert into notifications(student_id, message)
    values (NEW.student_id, 'Sizning ro''yxatdan o''tishingiz muvaffaqiyatli amalga oshdi');
    
    return NEW;
end;
$$ language plpgsql;

create trigger notify_on_enrollment
after insert on enrollments
for each row
execute function student_enrollment_notification();

insert into enrollments(student_id, course_id, grade)
values (1, 3, 85);

select * from notifications;
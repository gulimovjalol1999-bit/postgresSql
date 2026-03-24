create table products (
  id serial primary key,
  title varchar not null,
  price float not null,
  image_url varchar not null,
  description text not null,
  details jsonb not NULL
);

insert into products(title, price, image_url, description, jsonb) values('samsung s20', 555, 'sdfsdf', 'dfds',
'
  [
    {
      "ram": "8gb",
      "xotira": "256",
      "rangi": "oq"
    },
    {
      "ram": "8gb",
      "xotira": "256",
      "rangi": "qora"
    },
    {
      "ram": "16gb",
      "xotira": "512",
      "rangi": "green"
    }
  ]
'
);


create table users (
  id serial primary key,
  name varchar(100) not null,
  birth_date date not null
);

insert into users(name, birth_date) values('ali', '2026-03-08') ('nodir', '1998-03-29'), ('bekzod', '2002-09-17');

create or replace function age_calculator(birth_date date)
returns int as $$
begin 
  return extract(year from age(birth_date));
end
  $$ language pgpsql;

select name, age_calculator(birth_date) as age from users;


--------------------------------------------------------------------------------------------------
create or replace function grade_update_notification_function()
returns trigger as $$
begin
    if new.grade < old.grade then
      insert into notifications (student_id, message, created_at)
      values (new.student_id, 'your grade has decreased ' || 
      new.grade, current_timestamp);
    end if
    return new;
end;
$$ language plpgpsql;

create trigger grede_update_notification 
after update on Students
for each row
execute function grade_update_notification_function('')
--------------------------------------------------------------------------------------------------


------------------------------------------------------------------------
create table student (
  id serial primary key,
  name varchar(100) not null
);

inset into student(name) values('ali'), ('usmon'), ('umar'), ('abubakr');

create table course (
  id serial primary key,
  title varchar(100) not null
);

insert into course(title) values('backend'), ('frontend');

create table enrollments (
  id serial primary key,
  student_id int not null,
  course_id int not null,
  enrollment_date date
);


create or replace function enroll_students(cursor_id int studentList text)
returns void as $$
declare 
  student_id int;
  cur cursor for select (jsonb_array_elements_text(studentList::jsonb))::int;
begin 
  open cur;
  loop
    fetch cur into student_id
    exit when not found;

    insert into enrollments (student_id, course_id, enrollment_id, enrollment_date)
    values (student_id, course_id, current_date);
  end loop;
  close cur;
end;
$$ language plpgpsql

select enroll_students (2, '[1, 2, 3, 4]');
-------------------------------------------------------------------------------
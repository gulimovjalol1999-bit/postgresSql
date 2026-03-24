-- create table if not exists groups (
--   id serial primary key,
--   title varchar not null
-- );

-- create table if not exists student (
--   id serial primary key,
--   name varchar not null,
--   profession varchar not null,
--   group_id int not null,
--   constraint fk_group_id foreign key(group_id) references groups(id) on delete cascade on update cascade
-- );

-- insert into groups(title) values('XN9');

-- insert into student(name, profession, group_id) values('botir', 'design', 1);


create table if not exists users (
  id serial primary key,
  name varchar not null,
  role varchar default 'user'
);

insert into users(name, role) values('Ali', 'admin');


create table if not exists category (
  id serial primary key,
  title varchar not null
);
alter table category add column user_id int not null;

insert into category(title, user_id) values('kiyim', 1);


create table if not exists product (
  id serial primary key,
  title varchar not null,
  price float not null,
  description text not null,
  category_id int not null,
  constraint fk_category_id foreign key(category_id) references category(id)
);

insert into product(title, price, description, category_id) values('shim', 200, 'stefano ricci mahsuloti', 1);


create table if not exists orders (
  id serial primary key,
  user_id int not null,
  product_id int not null,
  constraint fk_user_id foreign key(user_id) references users(id) on delete cascade on update cascade,
  constraint fk_product_id foreign key(product_id) references product(id) on delete cascade on update cascade
);

insert into orders(user_id, product_id) values(1, 1);

alter table category
add constraint fk_user_id
foreign key(user_id)
references users(id);



---------------------------------------------------------------------------
select * from courses c 
join users u on u.id = c.created_by_user_id;


select Users.user_name, Courses.course_title
from Users 
inner join Courses on User.id = Courses.created_by_user_id;


select Users.user_name, Courses.id
from Users 
right join Courses on User.id = Courses.created_by_user_id;
----------------------------------------------------------------------------
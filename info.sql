

-- create table if not exists cars;
drop table if exists cars;

create table "cars" (
  id varchar primary key default gen_random_uuid(),
  title varchar(100) not null,
  brand varchar not null,
  years int not null,
  color varchar not null
);

insert into cars(title, brand, years, color) values('k5', 'kia', 2024, 'white');

insert into cars(title, brand, years, color) values('m5', 'bmw', 2025, 'black'), ('galenwagen', 'mercedes', 2026, 'silver'), ('golf', 'wolkswagen', 2017, 'gold');

update cars set title = 'gentra', brand = 'muhammadali@gmail.com', years = 30 where title = 'ali';

delete from cars where title = 'muhammadali';



update cars set title = 'Gentra', brand = 'Chevrolet', years = 2020, color = 'black' where title = 'galenwagen';

/////////////////////// fruit

drop table if exists fruits;

create table "fruits" (
  id varchar primary key default gen_random_uuid(),
  title varchar(100) NOT NULL,
  color varchar(50) NOT NULL,
  price numeric(10,2) NOT NULL
);

insert into fruits(title, color, price) values('peach', 'orange', 10), ('cherry', 'red', 12), ('apple', 'green', 6);

update fruits set price = 8 where title = 'apple'

///////////////////animal

drop table if exists animals;

create table "animals" (
  id varchar primary key default gen_random_uuid(),
  names varchar(50) not null,
  types varchar not null,
  age int not null
);

insert into animals(names, types, age) values('fox', 'wild', 3), ('tiger', 'wild', 5), ('horse', 'domestic', 4);

update animals set age = 11 where names = 'horse';

delete from animals where names = 'tiger'; 


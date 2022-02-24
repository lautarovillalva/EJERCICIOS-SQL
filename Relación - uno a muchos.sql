create database [clase02 - uno a muchos]
use [clase02 - uno a muchos]

create table carreras(
id smallint not null primary key identity(1,1),
nombre varchar(50) not null,
fechaCreacion date not null,
mail varchar(100) not null unique,
nivel tinyint not null
)
create table alumnos(
legajo bigint not null primary key identity (1,1),
IDCarrera smallint not null foreign key references carreras(id),
nombre varchar(50) not null,
fechaNac date not null,
mail varchar(50) not null unique,
telefono varchar(50) null
)

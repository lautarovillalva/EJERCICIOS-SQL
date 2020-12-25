create database [actividad 1.1]
use [actividad 1.1]

create table nivel(
IDNivel tinyint not null primary key,
nombre varchar(20) not null,
)
alter table nivel
add constraint CHK_nivel check(IDNivel>=1 and IDNivel<=4)
create table carreras(
id varchar(4) not null primary key,
nombre varchar(50) not null,
fechaCreacion date not null,
mail varchar(50) not null,
IDNivel tinyint not null foreign key references nivel(IDNivel)
)
create table materias(
id int not null primary key identity(1,1),
IDCarrera varchar(4) not null foreign key references carreras(id),
nombre varchar(50) not null,
cargaHoraria tinyint not null check(cargaHoraria > 0)
)
create table alumno(
id int not null primary key identity(1000,1),
IDCarrera varchar(4) not null foreign key references carreras(id),
apellidos varchar(50) not null,
nombres varchar(50) not null,
fechaNac date not null,
mail varchar(50) not null,
telefono varchar(20) not null
)
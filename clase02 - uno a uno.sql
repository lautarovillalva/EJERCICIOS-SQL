create database [clase02 - uno a uno]
use [clase02 - uno a uno]

create table libros(
id bigint not null,
titulo varchar(50) not null,
fechaPub date null,
)
alter table libros
add paginas smallint null
alter table libros
add constraint PK_libros primary key (id)
alter table libros
add constraint CHK_pagPositivas check(paginas > 0)

create table portadas(
id bigint not null,
portada varchar(50),
contratapa varchar(50)
)
-- CLAVE DE LA RELACIÓN UNO A UNO: PK Y FK --
alter table portadas
add constraint PK_portada primary key (id)
alter table portadas
add constraint FK_portadasLibros foreign key (id) references libros(id)

-- PARA ELIMINAR COLUMNA --
alter table libros
drop column fechaPub

-- CARGA DE DATOS --
insert into libros(id, titulo, paginas) values(100, 'el principito', 400)
insert into libros(id, titulo, paginas) values(200, 'carrie', 550)
insert into libros(id, titulo, paginas) values(300, 'batman: begins', 720)
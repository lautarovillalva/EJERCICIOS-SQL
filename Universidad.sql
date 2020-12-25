-- Universidad
/*
Alumnos
---------------
Legajo(PK)
Apellido
Nombre
Fnac
Genero null
IDCarrera (FK)

Carreras
---------------
ID (PK) (autonumerico)
Nombre de carrera
Tipo carrera (1= pregrado, 2= grado, 3= posgrado)
*/

--Create Database Universidad
--use Universidad

create table Carreras(
ID int not null primary key identity(10,10),
Nombre varchar(50) not null,
Tipo tinyint not null check (Tipo>=1 and Tipo<=3),
)

create table Alumnos(
Legajo bigint not null primary key,
Apellido varchar(50) not null,
Genero char null,
IDCarrera int not null foreign key references Carreras(ID),
)

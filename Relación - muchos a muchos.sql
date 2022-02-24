create database [clase02 - muchos a muchos]
use [clase02 - muchos a muchos]

create table empleados(
mail varchar(50) not null primary key,
apellidos varchar(50) not null,
nombres varchar(50) not null,
fechaNac date null
)
create table lenguajes(
id int not null primary key identity(1,1),
nombre varchar(50) not null
)
-- PARA AGREGAR UNA COLUMNA --
alter table lenguajes
add valoracion tinyint

-- PARA CARGAR DATOS A TODA UNA COLUMNA --
update lenguajes set valoracion = '0'
select * from lenguajes

create table lenguajes_X_empleados(
mail varchar(50) not null,
IDLenguaje int not null,
nivel tinyint not null check (nivel>=1 and nivel<=10),
-- PRIMERA OPCION PARA HACER DOS PK --
primary key(mail, IDLenguaje)
)
-- SEGUNDA OPCION PARA HACER DOS PK -- 
alter table lenguajes_X_empleados
add constraint PK_LxE primary key(mail, IDLenguaje)
-- HACER FK --
alter table lenguajes_X_empleados
add constraint FK_mailEmpleados foreign key(mail) references empleados(mail)
alter table lenguajes_X_empleados
add constraint FK_Lenguajes foreign key(IDLenguaje) references lenguajes(id)
-- BORRAR UNA RESTRICCION --
alter table lenguajes_X_empleados
drop constraint CK__lenguajes__nivel__3A81B327
-- AGREGAR UNA RESTRICCION --
alter table lenguajes_X_empleados
add constraint CHK_nivel check(nivel>=1 and nivel<=10)
-- CARGA DE DATOS --
-- EMPLEADOS --
insert into empleados(mail, apellidos, nombres, fechaNac) values('angel@utn.com', 'simon', 'angel', '12/03/1989')
insert into empleados(mail, apellidos, nombres, fechaNac) values('ljvillalva@utn.com', 'villalva','lautaro', '01/18/1997')
insert into empleados(mail, apellidos, nombres, fechaNac) values('lml@utn.com', 'leal', 'marcos', '09/09/1997')
insert into empleados(mail, apellidos, nombres, fechaNac) values('jalonzo@utn.com', 'alonzo', 'jonathan', '10/05/1996')
-- LENGUAJES --
insert into lenguajes(nombre) values('c++')
insert into lenguajes(nombre) values('c')
insert into lenguajes(nombre) values('javascript')
insert into lenguajes(nombre) values('java')
insert into lenguajes(nombre) values('phyton')
-- LENGUAJES X EMPLEADOS --
insert into lenguajes_X_empleados(mail, IDLenguaje, nivel) values( 'ljvillalva@utn.com', 1, 9)
insert into lenguajes_X_empleados(mail, IDLenguaje, nivel) values( 'ljvillalva@utn.com', 2, 8)
insert into lenguajes_X_empleados(mail, IDLenguaje, nivel) values( 'lml@utn.com', 1, 10)
insert into lenguajes_X_empleados(mail, IDLenguaje, nivel) values( 'angel@utn.com', 4, 10)
insert into lenguajes_X_empleados(mail, IDLenguaje, nivel) values( 'angel@utn.com', 5, 8)

create database joins
use joins
create table equipos(
id bigint not null primary key identity(1,1),
equipo varchar(50) not null
)
create table hinchas(
id bigint not null primary key identity(1,1),
idEquipo bigint null foreign key references equipos(id),
nombre varchar(50)not null
)
create table ciudades(
id bigint not null primary key identity(1,1),
ciudad varchar(50) not null
)
create table equipo_X_ciudad(
idCiudad bigint not null foreign key references ciudades(id),
idEquipo bigint not null foreign key references equipos(id),
primary key (idCiudad,idEquipo)
)
-- INNER JOIN --
-- Devuelven �nicamente aquellos registros/filas que tienen 
-- valores id�nticos en los dos campos que se comparan para 
-- unir ambas tablas.
select hinchas.nombre, equipos.equipo
from hinchas
inner join equipos on hinchas.idEquipo=equipos.id

-- LEFT JOIN --
-- Combina los valores de la primera tabla con los valores 
-- de la segunda tabla. Siempre devolver� las filas de la 
-- primera tabla, incluso aunque no cumplan la condici�n.
select hinchas.nombre, equipos.equipo
from hinchas
left join equipos on hinchas.idEquipo=equipos.id

-- RIGHT JOIN --
-- Permite obtener informaci�n de dos tablas, pero siempre 
-- considerando que los registros resultantes deben estar en 
-- la segunda, pudiendo regresar los que est�n en la 
-- primera tabla, o no.
select hinchas.nombre, equipos.equipo
from hinchas
right join equipos on hinchas.idEquipo=equipos.id

-- FULL JOIN --
--La sentencia FULL JOIN combina los valores de la primera tabla 
-- con los valores de la segunda tabla. Siempre devolver� las 
-- filas de las dos tablas, aunque no cumplan la condici�n.
select hinchas.nombre, equipos.equipo
from hinchas
full join equipos on hinchas.idEquipo=equipos.id
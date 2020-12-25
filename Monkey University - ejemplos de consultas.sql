use [Monkey University]

-- CONSULTAS --

-- PARA CONSULTAR TODA LA TABLA --
select * from Cursos

-- PARA SELECCIONAR LAS COLUMNAS DESEADAS --
select nombre, CostoCurso, CostoCertificacion from Cursos

-- PARA HACER OPERACIONES ENTRE COLUMNAS --
select Nombre, CostoCurso, CostoCertificacion, CostoCurso + CostoCertificacion as COSTO 
from Cursos
select Nombre, CostoCurso, CostoCertificacion, (CostoCurso + CostoCertificacion)*0.8 as CostoDesc 
from Cursos

-- PARA ACHIVAR FILAS Y ORDENAR DESC O ASC --
select top 10 with ties nombre, CostoCurso 
from Cursos
order by Estreno asc, Nombre desc
-- asc / desc 
-- with ties = con empates 

-- PARA ELIMINAR LAS FILAS REPETIDAS --
select distinct Estreno
from Cursos
order by Estreno asc

-- CONSULTAS CON RESTRICCIÓN --
select ID, Nombre, CostoCurso, IDNivel 
from Cursos
where CostoCertificacion >1200 and CostoCertificacion < 5000
--where costoCertificacion between 5000 and 1200
order by CostoCertificacion asc
--
select Nombre, Numero, duracion 
from Clases
where IDCurso= 10 or IDCurso= 4 or IDCurso= 5
-- where idCurso in(10, 4, 5)
-- where idCurso in('texto1', 'texto2', etc )
-- distinto: where IDCurso != 10 ó <> 10
-- distinto: where IDCurso not int(10, 4, 5)

-- CON NULL -- 
select Nombre, IDNivel
from Cursos
where IDNivel is not null

-- 

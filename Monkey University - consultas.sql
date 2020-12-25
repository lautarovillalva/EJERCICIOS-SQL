use [Monkey University]

-- TP
-- 1	Listado de todos los idiomas.
select * from Idiomas
-- 2	Listado de todos los cursos.
select * from Cursos
-- 3	Listado con nombre, costo de inscripci�n, costo de certificaci�n y fecha de estreno de todos los cursos.
select Nombre, CostoCurso, CostoCertificacion, Estreno
from Cursos
order by Nombre asc
-- 4	Listado con ID, nombre, costo de inscripci�n e ID de nivel de todos los cursos cuyo costo de certificaci�n sea menor a $ 5000.
select ID, Nombre, CostoCurso
from Cursos
where CostoCertificacion<5000
order by Nombre asc
-- 5	Listado con ID, nombre, costo de inscripci�n e ID de nivel de todos los cursos cuyo costo de certificaci�n sea mayor a $ 1200.
select ID, Nombre, CostoCurso, IDNivel
from Cursos
where CostoCertificacion>1200
order by Nombre asc
-- 6	Listado con nombre, n�mero y duraci�n de todas las clases del curso con ID n�mero 6.
select Nombre, Numero, Duracion
from Clases
where ID=6
-- 7	Listado con nombre, n�mero y duraci�n de todas las clases del curso con ID n�mero 10.
select Nombre, Numero, Duracion
from Clases
where ID=10
-- 8	Listado con nombre y duraci�n de todas las clases con ID n�mero 4. Ordenado por duraci�n de mayor a menor.
select Nombre, Duracion
from clases
where ID=4
order by Duracion asc
-- 9	Listado con nombre, fecha de estreno, costo del curso, costo de certificaci�n ordenados por fecha de estreno de manera creciente.
select Nombre, Estreno, CostoCurso, CostoCertificacion
from Cursos
order by Estreno asc
-- 10	Listado con nombre, fecha de estreno y costo del curso de todos aquellos cuyo ID de nivel sea 1, 5, 6 o 7.
select Nombre, Estreno, CostoCurso
from Cursos
where ID in(1, 5, 6, 7)
order by Nombre asc
-- 11	Listado con nombre, fecha de estreno y costo del curso de todos aquellos cuyo ID de nivel sea 1, 5, 9 o 10.
select Nombre, Estreno, CostoCurso 
from Cursos
where ID in(1, 5, 9, 10)
-- 12	Listado con nombre, duraci�n y n�mero de todas las clases de los cursos con ID 2, 5, y 7. Ordenados por ID de Curso ascendente y luego por n�mero de clase ascendente.
select Nombre, Duracion, Numero
from Clases
where ID in(2, 5, 7)
order by IDCurso asc, Numero asc
-- 13	Listado con nombre y fecha de estreno de todos los cursos cuya fecha de estreno haya sido en el primer semestre del a�o 2019.
select Nombre, Estreno
from Cursos
where month(Estreno) between 1 and 6 and year(Estreno)=2019
order by Estreno asc
-- 14	Listado de cursos cuya fecha de estreno haya sido en el a�o 2020.
select *
from Cursos
where year(Estreno)=2020
order by month(Estreno) asc

-- Investigar:
------------------
-- DATEPART
-- DATEDIFF y DATEADD

-- 15	Listado de cursos cuya mes de estreno haya sido entre el 1 y el 4.
select *
from Cursos
where month(Estreno) between 1 and 4
-- 16	Listado de clases cuya duraci�n se encuentre entre 15 y 90 minutos.
select *
from Clases
where Duracion between 15 and 90
-- 17	Listado de contenidos cuyo tama�o supere los 5000MB y sean de tipo 4 o sean menores a 400MB y sean de tipo 1.
select *
from Contenidos
where (Tama�o>5000 and IDTipo=4) or (Tama�o<400 and IDTipo=1)
order by IDTipo
-- 18	Listado de cursos que no posean ID de nivel.
select *
from Cursos
where IDNivel is not null
order by Nombre
-- 19	Listado de cursos cuyo costo de certificaci�n corresponda al 20% o m�s del costo del curso.
select *
from Cursos
where CostoCertificacion>= (CostoCurso*0.2)
-- 20	Listado de costos de cursado de todos los cursos sin repetir y ordenados de mayor a menor.
select distinct CostoCurso
from Cursos
order by CostoCurso desc
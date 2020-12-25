use [monkey university]

-- TP1: CONSULTAS DE SELECCIÓN + JOINS + FUNCIONES DE RESUMEN
-- (1)  Listado con la cantidad de cursos.
select count (*) as 'cantidad de cursos'
	from Cursos
-- 2  Listado con la cantidad de usuarios.
select count(*) as 'cantidad de usuarios'
	from Usuarios
-- (3)  Listado con el promedio de costo de certificación de los cursos.
select avg(Cursos.CostoCertificacion)
	from Cursos
-- 4  Listado con el promedio general de calificación de reseñas.
select avg(Reseñas.Puntaje)
	from Reseñas
-- (5)  Listado con la fecha de estreno de curso más antigua.
select MIN(Cursos.Estreno)
	from Cursos
-- 6  Listado con el costo de certificación menos costoso.
select MIN(Cursos.CostoCertificacion)
	from Cursos
-- (7)  Listado con el costo total de todos los cursos.
select SUM(Cursos.CostoCurso)
	from Cursos
-- 8  Listado con la suma total de todos los pagos.
select SUM(pagos.Importe)
	from Pagos
-- 9  Listado con la cantidad de cursos de nivel principiante.
use [monkey university]
select
	Cursos.ID,
	Cursos.Nombre,
	Cursos.IDNivel,
	Niveles.Nombre
from Cursos
inner join Niveles on Cursos.IDNivel=Niveles.ID
where Niveles.Nombre like '%principiante'
--
select 
	COUNT(Niveles.ID)
from Cursos
inner join Niveles on Cursos.IDNivel=Niveles.ID
where Niveles.Nombre like '%principiante%'
-- 10  Listado con la suma total de todos los pagos realizados en 2019.
select
	SUM(Pagos.Importe)
from Pagos
where YEAR(Pagos.Fecha)=2019
-- (11)  Listado con la cantidad de usuarios que son instructores.
select * from Instructores_x_Curso
order by Instructores_x_Curso.IDUsuario asc
--
select
	count(distinct Instructores_x_Curso.IDUsuario)
from Instructores_x_Curso
-- 12  Listado con la cantidad de usuarios distintos que se hayan certificado.
select * from Certificaciones order by Certificaciones.IDInscripcion asc
--
select
	count(distinct Certificaciones.IDInscripcion)
from Certificaciones
-- (13)  Listado con el nombre del país y la cantidad de usuarios de cada país.
select
	Paises.Nombre
from Paises
inner join Datos_Personales on Paises.ID=Datos_Personales.IDPais
order by Paises.Nombre asc
go
select
	Paises.Nombre,
	count(Datos_Personales.IDPais)
from Paises
inner join Datos_Personales on Datos_Personales.IDPais=Paises.ID
group by Paises.Nombre
-- (14)  Listado con el apellido y nombres del usuario y el importe más costoso 
--abonado como pago.
--Sólo listar aquellos que hayan abonado más de $7500.
select
	Datos_Personales.Apellidos + ', ' + Datos_Personales.Nombres,
	MAX(Pagos.Importe)
from Datos_Personales
inner join Inscripciones on Inscripciones.IDUsuario=Datos_Personales.ID
inner join Pagos on Pagos.IDInscripcion=Inscripciones.ID
group by Datos_Personales.Apellidos + ', ' + Datos_Personales.Nombres
having MAX(Pagos.Importe)>7500
-- 15  Listado con el apellido y nombres de usuario y el importe más costoso de curso al cual se haya inscripto.
select
	Datos_Personales.Apellidos+', '+Datos_Personales.Nombres,
	MAX(Inscripciones.Costo)
from Datos_Personales
inner join Inscripciones on Inscripciones.IDUsuario=Datos_Personales.ID
group by Datos_Personales.Apellidos+', '+Datos_Personales.Nombres
order by Datos_Personales.Apellidos+', '+Datos_Personales.Nombres
-- 16  Listado con el nombre del curso, nombre del nivel, cantidad total de clases y duración total del curso en minutos.
select
	Cursos.Nombre as 'nombre de curso',
	Niveles.Nombre as 'nivel de curso',
	COUNT(Clases.IDCurso) as 'cantidad de clases',
	SUM(Clases.Duracion) as 'duracion total'
from Cursos
inner join Clases on Clases.IDCurso=Cursos.ID
inner join Niveles on Niveles.ID=Cursos.IDNivel
group by Cursos.Nombre, Niveles.Nombre
order by Niveles.Nombre
-- 17  Listado con el nombre del curso y cantidad de contenidos registrados. Sólo listar aquellos cursos que tengan más de 10 contenidos registrados.
select
	Cursos.Nombre as 'nombre curso',
	count(Contenidos.IDClase) as 'cant contenido > 10'
from Cursos
inner join Clases on Clases.IDCurso=Cursos.ID
inner join Contenidos on Contenidos.IDClase=Clases.ID
group by Cursos.Nombre
having count(Contenidos.IDClase)>10
order by count(Contenidos.IDClase) asc
-- 18  Listado con nombre del curso, nombre del idioma y cantidad de tipos de idiomas.
select
	Cursos.Nombre as 'curso',
	Idiomas.Nombre as 'idioma',
	count(TiposIdioma.ID) as 'cantidad tipos de idiomas'
from Cursos
inner join Idiomas_x_Curso on Idiomas_x_Curso.IDCurso=Cursos.ID
inner join Idiomas on Idiomas.ID=Idiomas_x_Curso.IDIdioma
inner join TiposIdioma on TiposIdioma.ID=Idiomas_x_Curso.IDTipo
group by Cursos.ID, Cursos.Nombre,Idiomas.ID, Idiomas.Nombre
order by Cursos.ID, Idiomas.ID
go
select
	Idiomas_x_Curso.IDCurso,
	Idiomas.Nombre
from Idiomas_x_Curso
inner join Idiomas on Idiomas.ID=Idiomas_x_Curso.IDIdioma
order by Idiomas_x_Curso.IDCurso, Idiomas.ID asc
-- 19  Listado con el nombre del curso y cantidad de idiomas distintos disponibles.
select
	Cursos.Nombre,
	count(Idiomas_x_Curso.IDIdioma) as 'cantidad de idiomas'
from Cursos
inner join Idiomas_x_Curso on Idiomas_x_Curso.IDCurso=Cursos.ID
group by Cursos.Nombre
order by Cursos.Nombre
-- 20  Listado de categorías de curso y cantidad de cursos asociadas a cada categoría. Sólo mostrar las categorías con más de 5 cursos.
select
	Categorias.Nombre as 'categoria',
	count(Categorias_x_Curso.IDCurso) as 'cant cursos' 
from Categorias
inner join Categorias_x_Curso on Categorias_x_Curso.IDCategoria=Categorias.ID
group by Categorias.Nombre
order by Categorias.Nombre
-- 21  Listado con tipos de contenido y la cantidad de contenidos asociados a cada tipo. Mostrar aquellos tipos que no hayan registrado contenidos con cantidad 0.
select
	TiposContenido.ID,
	COUNT(Contenidos.IDTipo) as 'cant contenidos'
from TiposContenido
left join Contenidos on Contenidos.IDTipo=TiposContenido.ID
group by TiposContenido.ID 
having COUNT(Contenidos.IDTipo)!=0
order by TiposContenido.ID
-- 22  Listado con Nombre del curso, nivel, año de estreno y el total recaudado en concepto de inscripciones. Listar aquellos cursos sin inscripciones con total igual a $0.
select
	Inscripciones.IDCurso,
	Inscripciones.Costo
from Inscripciones order by Inscripciones.ID
go
select
	cursos.ID,
	Cursos.Nombre,
	Niveles.Nombre,
	Cursos.Estreno,
	isnull(sum(Inscripciones.Costo),0) as 'total recaudado'
from Cursos
inner join Niveles on Niveles.ID=Cursos.IDNivel
inner join Inscripciones on Inscripciones.IDCurso=Cursos.ID
group by cursos.ID, Cursos.Nombre, Niveles.Nombre, Cursos.Estreno
order by Cursos.ID
-- 23  Listado con Nombre del curso, costo de cursado y certificación y cantidad de usuarios distintos inscriptos cuyo costo de cursado sea menor a $10000 y cuya cantidad de usuarios inscriptos sea menor a 5. Listar aquellos cursos sin inscripciones con cantidad 0.
select
	Cursos.ID,
	Cursos.Nombre,
	Cursos.CostoCurso,
	Cursos.CostoCertificacion,
	count(distinct Inscripciones.IDUsuario)
from Cursos
left join Inscripciones on Inscripciones.IDCurso=Cursos.ID
where Cursos.CostoCertificacion<10000
group by Cursos.ID, Cursos.Nombre, Cursos.CostoCurso, Cursos.CostoCertificacion
having count(distinct Inscripciones.IDUsuario) <5
order by Cursos.ID
-- 24  Listado con Nombre del curso, fecha de estreno y nombre del nivel del curso que más recaudó en concepto de certificaciones.
select top 1
	Cursos.ID,
	Cursos.Nombre,
	Cursos.Estreno,
	Niveles.Nombre,
	sum(Certificaciones.Costo) as 'recaudacion'
from Cursos
inner join Niveles on Niveles.ID=Cursos.IDNivel
inner join Inscripciones on Inscripciones.IDCurso=Cursos.ID
inner join Certificaciones on Certificaciones.IDInscripcion=Inscripciones.ID
group by Cursos.ID, Cursos.Nombre, Cursos.Estreno, Niveles.Nombre
order by Cursos.ID
--
select
	Cursos.ID,
	Certificaciones.Costo
from Cursos
inner join Inscripciones on Inscripciones.IDCurso=Cursos.ID
inner join Certificaciones on Certificaciones.IDInscripcion=Inscripciones.ID
order by Cursos.ID
-- 25  Listado con Nombre del idioma del idioma más utilizado como subtítulo.
select top 1
	MAX(Idiomas.Nombre) as 'idioma mas utilizado'
from Idiomas
inner join Idiomas_x_Curso on Idiomas_x_Curso.IDIdioma=Idiomas.ID
group by Idiomas.Nombre
-- 26  Listado con Nombre del curso y promedio de puntaje de reseñas apropiadas.
select
	Cursos.Nombre,
	AVG(Reseñas.Puntaje) as 'promedio de puntaje'
from Cursos
inner join Inscripciones on Inscripciones.IDCurso=Cursos.ID
inner join Reseñas on Reseñas.IDInscripcion=Inscripciones.ID
group by Cursos.Nombre
order by Cursos.Nombre
-- 27  Listado con Nombre de usuario y la cantidad de reseñas inapropiadas que registró.
select
	Usuarios.NombreUsuario,
	COUNT(Reseñas.Inapropiada)
from Usuarios
left join Inscripciones on Inscripciones.IDUsuario=Usuarios.ID
left join Reseñas on Reseñas.IDInscripcion=Inscripciones.ID
where Reseñas.Inapropiada=1 or Reseñas.Inapropiada is null
group by Usuarios.NombreUsuario
order by Usuarios.NombreUsuario asc
-- 28  Listado con Nombre del curso, nombre y apellidos de usuarios y la cantidad de veces que dicho usuario realizó dicho curso. No mostrar cursos y usuarios que contabilicen cero.
select
	Cursos.Nombre,
	Datos_Personales.Apellidos + Datos_Personales.Nombres,
	count(Inscripciones.IDCurso) as 'cantidades cursadas'
from Datos_Personales
inner join Inscripciones on Inscripciones.IDUsuario=Datos_Personales.ID
inner join Cursos on cursos.ID=Inscripciones.IDCurso
group by Cursos.Nombre, Datos_Personales.Apellidos + Datos_Personales.Nombres
order by Cursos.Nombre
-- 29  Listado con Apellidos y nombres, mail y duración total en concepto de clases de cursos a los que se haya inscripto. Sólo listar información de aquellos registros cuya duración total supere los 400 minutos.
select
	Datos_Personales.Apellidos+Datos_Personales.Nombres,
	Datos_Personales.Email,
	sum(Clases.Duracion) as 'tiempo cursado'
from Datos_Personales
inner join Inscripciones on Inscripciones.IDUsuario=Datos_Personales.ID
inner join Cursos on cursos.ID=Inscripciones.IDCurso
inner join clases on clases.IDCurso=Cursos.ID
group by Datos_Personales.Apellidos+Datos_Personales.Nombres, Datos_Personales.Email
having sum(Clases.Duracion)>400
order by Datos_Personales.Apellidos+Datos_Personales.Nombres
-- 30  Listado con nombre del curso y recaudación total. La recaudación total consiste en la sumatoria de costos de inscripción y de certificación. Listarlos ordenados de mayor a menor por recaudación.
select
	Cursos.Nombre,
	sum(Cursos.CostoCertificacion+Cursos.CostoCurso) as 'recaudacion total'
from Cursos
group by Cursos.Nombre
order by 'recaudacion total' desc

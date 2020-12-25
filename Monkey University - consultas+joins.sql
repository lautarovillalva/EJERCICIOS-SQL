Use [Monkey University]
-- (1) Listado con nombre de usuario de todos los usuarios y sus respectivos nombres y apellidos.

select	Usuarios.NombreUsuario,
		Datos_Personales.Nombres,
		Datos_Personales.Apellidos
from Usuarios
inner join Datos_Personales on Usuarios.ID=Datos_Personales.ID
-- 2 Listado con apellidos, nombres, fecha de nacimiento y nombre del país de nacimiento.
select	Datos_Personales.Apellidos as 'ap',
		Datos_Personales.Nombres as 'no',
		Datos_Personales.Nacimiento as 'fe',
		Paises.Nombre as 'pa'
from Datos_Personales
inner join Paises on Datos_Personales.IDPais=Paises.ID
-- (3) Listado con nombre de usuario, apellidos, nombres, email o celular de todos los usuarios que vivan en una domicilio cuyo nombre contenga el término 'Presidente' o 'Obispo'. NOTA: Si no tiene email, obtener el celular.
select	Usuarios.ID,
		Datos_Personales.Apellidos,
		Datos_Personales.Nombres,
		isnull(Datos_Personales.Email,Datos_Personales.Celular) as 'contacto',
		Datos_Personales.Domicilio
from Usuarios
inner join Datos_Personales on Usuarios.ID=Datos_Personales.ID
where Datos_Personales.Domicilio like '%presidente%' or Datos_Personales.Domicilio like '%obispo%'
-- 4 Listado con nombre de usuario, apellidos, nombres, email o celular o domicilio como 
-- 'Información de contacto'.  NOTA: Si no tiene email, obtener el celular y si no posee 
-- celular obtener el domicilio.
select	Usuarios.NombreUsuario,
		Datos_Personales. Apellidos,
		Datos_Personales.Nombres,
		isnull (Datos_Personales.Email,ISNULL(Datos_Personales.Celular,Datos_Personales.Domicilio)) as 'datos personales'
from Usuarios
inner join Datos_Personales on Datos_Personales.ID=Usuarios.ID
-- (5) Listado con apellido y nombres, nombre del curso y costo de la inscripción de todos los usuarios 
--inscriptos a cursos.  NOTA: No deben figurar los usuarios que no se inscribieron a ningún curso.
select	Cursos.Nombre,
		Datos_Personales.Apellidos,
		Datos_Personales.Nombres,
		Cursos.CostoCurso
from Cursos
inner join Inscripciones on Cursos.ID=Inscripciones.IDCurso
inner join Usuarios on Inscripciones.ID=Usuarios.ID
inner join Datos_Personales on Datos_Personales.ID=Usuarios.ID
order by Cursos.Nombre asc, Datos_Personales.Apellidos asc, Datos_Personales.Nombres
-- Ejemplo de Union
-- 6 Listado con nombre de curso, nombre de usuario y mail de todos los inscriptos a cursos 
-- que se hayan estrenado en el año 2020.
select
	Cursos.Nombre,
	Usuarios.NombreUsuario,
	Datos_Personales.Email,
	--Cursos.Estreno
from Inscripciones
inner join Usuarios on Inscripciones.IDUsuario=Usuarios.ID
inner join Datos_Personales on Usuarios.ID=Datos_Personales.ID
inner join Cursos on Inscripciones.IDCurso=Cursos.ID
where year(Cursos.Estreno)>='2020'
-- 7 Listado con nombre de curso, nombre de usuario, apellidos y nombres, fecha de inscripción, 
--costo de inscripción, fecha de pago e importe de pago. Sólo listar información de aquellos que hayan pagado.
select
	Cursos.Nombre,
	Usuarios.NombreUsuario,
	Datos_Personales.Apellidos,
	Datos_Personales.Nombres,
	Inscripciones.Fecha as 'fecha ins',
	Inscripciones.Costo as 'costo ins',
	Pagos.Importe as 'importe de pago',
	Pagos.Fecha as 'fecha pago'
from Inscripciones
inner join Usuarios on Usuarios.ID=Inscripciones.IDUsuario
inner join Datos_Personales on Usuarios.ID=Datos_Personales.ID
inner join Cursos on Cursos.ID=Inscripciones.IDCurso
inner join Pagos on Pagos.IDInscripcion=Inscripciones.ID
-- 8 Listado con nombre y apellidos, genero, fecha de nacimiento, mail, nombre del curso y fecha 
--de certificación de todos aquellos usuarios que se hayan certificado.
select
	Datos_Personales.Nombres,
	Datos_Personales.Apellidos,
	Datos_Personales.Genero,
	Datos_Personales.Nacimiento,
	Datos_Personales.Email,
	Cursos.Nombre,
	Certificaciones.Fecha
from Datos_Personales
inner join Usuarios on Datos_Personales.ID=Usuarios.ID
inner join Inscripciones on Inscripciones.IDUsuario=Usuarios.ID
inner join Cursos on Inscripciones.IDCurso=Cursos.ID
inner join Certificaciones on Certificaciones.IDInscripcion=Inscripciones.ID
-- 9 Listado de cursos con nombre, costo de cursado y certificación, costo total 
--(cursado + certificación) con 10% de todos los cursos de nivel Principiante.
select
	Cursos.Nombre,
	Cursos.CostoCurso,
	Cursos.CostoCertificacion,
	(Cursos.CostoCertificacion+Cursos.CostoCurso)*0.9 as 'costo total',
	Niveles.Nombre
from Cursos
left join Niveles on Cursos.IDNivel=Niveles.ID
where Niveles.Nombre like '%principiante%'
-- 10 Listado con nombre y apellido y mail de todos los instructores. Sin repetir.
select distinct
	Datos_Personales.Apellidos,
	Datos_Personales.Nombres,
	Datos_Personales.Email
from Instructores_x_Curso
inner join Datos_Personales on Datos_Personales.ID=Instructores_x_Curso.IDUsuario
order by Datos_Personales.Apellidos asc
-- 11 Listado con nombre y apellido de todos los usuarios que hayan 
--cursado algún curso cuya categoría sea 'Historia'.
select distinct
	Datos_Personales.Nombres,
	Datos_Personales.Apellidos
from Datos_Personales
inner join Usuarios on Usuarios.ID=Datos_Personales.ID
inner join Inscripciones on Inscripciones.IDUsuario=Usuarios.ID
inner join Cursos on Inscripciones.IDCurso=Cursos.ID
inner join Categorias_x_Curso on Categorias_x_Curso.IDCurso=Cursos.ID
inner join Categorias on Categorias_x_Curso.IDCategoria=Categorias.ID
where Categorias.Nombre like '%historia%'
order by Datos_Personales.Apellidos asc
-- (12) Listado con nombre de idioma, código de curso y código de tipo de idioma. 
--Listar todos los idiomas indistintamente si no tiene cursos relacionados.
select Idiomas.Nombre, Idiomas_x_Curso.IDCurso, Idiomas_x_Curso.IDTipo
from Idiomas
left join Idiomas_x_Curso on Idiomas.ID= Idiomas_x_Curso.IDIdioma
select
	Idiomas.Nombre,
	Idiomas.ID,
	Idiomas_x_Curso.IDTipo
from Idiomas
left join Idiomas_x_Curso on Idiomas.ID=Idiomas_x_Curso.IDIdioma
-- 13 Listado con nombre de idioma de todos los idiomas que no tienen cursos relacionados.
select
	Idiomas.Nombre
from Idiomas
left join Idiomas_x_Curso on Idiomas.ID=Idiomas_x_Curso.IDIdioma
where Idiomas_x_Curso.IDIdioma is null
-- 14 Listado con nombres de idioma que figuren como audio de algún curso. Sin repeticiones.
select distinct
	Idiomas.Nombre,
	Idiomas.Nombre,
	TiposContenido.Nombre
from Idiomas
left join Idiomas_x_Curso on Idiomas_x_Curso.IDIdioma=Idiomas.ID
inner join clases on Idiomas_x_Curso.IDCurso=Clases.IDCurso
inner join Contenidos on contenidos.IDClase=Clases.ID
inner join TiposContenido on TiposContenido.ID=Contenidos.ID
where TiposContenido.Nombre like '%audio%'
-- (15) Listado con nombres y apellidos de todos los usuarios y el nombre del país en el que nacieron. Listar todos los países indistintamente si no tiene usuarios relacionados.
select 
	Datos_Personales.Nombres, 
	Datos_Personales.Apellidos, 
	Paises.Nombre
from Paises
right join Datos_Personales on Datos_Personales.IDPais=Paises.ID
-- 16 Listado con nombre de curso, fecha de estreno y nombres de usuario de todos los inscriptos. 
select 
	Cursos.Nombre,
	Cursos.Estreno,
	Usuarios.NombreUsuario
from Cursos
inner join Inscripciones on Inscripciones.IDCurso=Cursos.ID
inner join Usuarios on Inscripciones.IDUsuario=Usuarios.ID
--Listar todos los nombres de usuario indistintamente si no se inscribieron a ningún curso.
select 
	Usuarios.NombreUsuario
from Usuarios
-- 17 Listado con nombre de usuario, apellido, nombres, género, fecha de nacimiento y 
--mail de todos los usuarios que no cursaron ningún curso.
select
	Usuarios.NombreUsuario,
	Usuarios.ID,
	Datos_Personales.Apellidos,
	Datos_Personales.nombres,
	Datos_Personales.Genero,
	Datos_Personales.Nacimiento,
	Datos_Personales.Email
from Usuarios
inner join Datos_Personales on Usuarios.ID=Datos_Personales.ID
left join Inscripciones on Inscripciones.IDUsuario=Usuarios.ID
where Inscripciones.IDCurso is null
order by Usuarios.ID asc
-- 18 Listado con nombre y apellido, nombre del curso, puntaje otorgado y texto de la reseña. 
--Sólo de aquellos usuarios que hayan realizado una reseña inapropiada.
select
	Datos_Personales.Nombres,
	Datos_Personales.Apellidos,
	Cursos.Nombre,
	Reseñas.Puntaje,
	Reseñas.Observaciones
from Usuarios
inner join Datos_Personales on Datos_Personales.ID=Usuarios.ID
inner join Inscripciones on Datos_Personales.ID=Inscripciones.IDUsuario
inner join Cursos on Inscripciones.IDCurso=Cursos.ID
inner join Reseñas on Reseñas.IDInscripcion=Inscripciones.ID
where Reseñas.Inapropiada=1
-- 19 Listado con nombre del curso, costo de cursado, costo de certificación, 
--nombre del idioma y nombre del tipo de idioma de todos los cursos cuya fecha 
--de estreno haya sido antes del año actual. Ordenado por nombre del curso y luego 
--por nombre de tipo de idioma. Ambos ascendentemente.
select
	Cursos.Nombre,
	Cursos.CostoCurso,
	Cursos.CostoCertificacion,
	Idiomas.Nombre,
	TiposIdioma.Nombre
from Cursos
inner join Idiomas_x_Curso on Cursos.ID=Idiomas_x_Curso.IDCurso
inner join Idiomas on Idiomas_x_Curso.IDIdioma=Idiomas.ID
inner join TiposIdioma on TiposIdioma.ID=Idiomas_x_Curso.IDTipo
where year(Cursos.Estreno)<GETDATE()
order by Cursos.Nombre asc, TiposIdioma.Nombre asc
-- 20 Listado con nombre del curso y todos los importes de los pagos relacionados.
select
	Cursos.Nombre,
	Pagos.Importe
from Pagos
left join Inscripciones on Inscripciones.ID=Pagos.IDInscripcion
inner join Cursos on Inscripciones.IDCurso=Cursos.ID
order by Cursos.Nombre asc
-- 21 Listado con nombre de curso, costo de cursado y una leyenda que indique "Costoso" si el costo de cursado es mayor a $ 15000, "Accesible" si el costo de cursado está entre $2500 y $15000, "Barato" si el costo está entre $1 y $2499 y "Gratis" si el costo es $0.
select
	case
	when cursos.costocurso>15000 then 'costoso'
	when cursos.costocurso>=2500 then 'accesible'
	when cursos.costocurso>=1 then 'barato'
	else 'gratis'
	end as 'costo descritivo'
from cursos
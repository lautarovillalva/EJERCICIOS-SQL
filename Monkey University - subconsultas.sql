-- (1)  Listado con apellidos y nombres de los usuarios que no se hayan inscripto a cursos durante el año 2019.
Select * From Datos_Personales as DAT
Where DAT.ID Not IN (
    Select distinct IDUsuario From Inscripciones
    Where Year(Fecha) = 2019
)
select *
from Datos_Personales
where Datos_Personales.ID not in(
select distinct
	Usuarios.ID
from Usuarios
inner join Inscripciones on Inscripciones.IDUsuario=Usuarios.ID
where year(Inscripciones.Fecha)=2019
)

-- 2  Listado con apellidos y nombres de los usuarios que se hayan inscripto a cursos pero no hayan realizado ningún pago.
select
	--Datos_Personales.ID,
	Datos_Personales.Apellidos+', '+Datos_Personales.Nombres as 'apenom'
from Datos_Personales
where Datos_Personales.ID not in(
select distinct
	Inscripciones.IDUsuario
from Inscripciones
inner join Pagos on pagos.IDInscripcion=Inscripciones.ID
)
-- 3  Listado de países que no tengan usuarios relacionados.
select *
from Paises
where Paises.ID not in(
select distinct
	Paises.ID
from Paises
inner join Datos_Personales on Datos_Personales.IDPais=Paises.ID
)
-- (4)  Listado de clases cuya duración sea mayor a la duración promedio.
select
	Clases.ID,
	Clases.Numero,
	Clases.Duracion
from Clases
where Clases.Duracion>(
select
	AVG(Clases.Duracion)
from Clases
)
-- (5)  Listado de contenidos cuyo tamaño sea mayor al tamaño de todos los contenidos de tipo 'Audio de alta calidad'.
select *
from Contenidos
where Contenidos.Tamaño>(
select
	MAX(Contenidos.Tamaño)
from Contenidos
inner join TiposContenido on TiposContenido.ID=Contenidos.IDTipo
where TiposContenido.Nombre like '%Audio de alta calidad%'
)
-- 6  Listado de contenidos cuyo tamaño sea menor al tamaño de algún contenido de tipo 'Audio de alta calidad'.
select *
from Contenidos
where contenidos.Tamaño <any(
select
	Contenidos.Tamaño
from Contenidos
inner join TiposContenido on TiposContenido.ID=Contenidos.IDTipo
where TiposContenido.Nombre like '%Audio de alta calidad%'
)
-- (7)  Listado con nombre de país y la cantidad de usuarios de género masculino y la cantidad de usuarios de género femenino que haya registrado.
select
	Paises.ID,
	Paises.Nombre,
	(select
	count(Datos_Personales.Genero)
	from Datos_Personales where Datos_Personales.Genero= 'M' and Paises.ID=Datos_Personales.IDPais) as 'cantM',
	(select
	count(Datos_Personales.Genero)
	from Datos_Personales where Datos_Personales.Genero= 'F' and Paises.ID=Datos_Personales.IDPais) as 'cantF'
from Paises
--
select
	count(Datos_Personales.Genero)
from Datos_Personales where Datos_Personales.Genero= 'M'
select
	count(Datos_Personales.Genero)
from Datos_Personales where Datos_Personales.Genero= 'F'
-- 8  Listado con apellidos y nombres de los usuarios y la cantidad de inscripciones realizadas en el 2019 y la cantidad de inscripciones realizadas en el 2020.
select 
	Datos_Personales.Apellidos+', '+Datos_Personales.Nombres as 'apenom',
	(select
	count(Inscripciones.IDUsuario)
	from Inscripciones where year(Inscripciones.Fecha)=2019 and Datos_Personales.ID=Inscripciones.IDUsuario) as '2019',
	(select
	count(Inscripciones.IDUsuario)
	from Inscripciones where year(Inscripciones.Fecha)=2020 and Datos_Personales.ID=Inscripciones.IDUsuario) as '2020'
from Datos_Personales
--
select
	count(Inscripciones.IDUsuario)
from Inscripciones where year(Inscripciones.Fecha)=2019 and Datos_Personales.ID=Inscripciones.IDUsuario
select
	count(Inscripciones.IDUsuario)
from Inscripciones where year(Inscripciones.Fecha)=2020 and Datos_Personales.ID=Inscripciones.IDUsuario
-- 9  Listado con nombres de los cursos y la cantidad de idiomas de cada tipo. Es decir, la cantidad de idiomas de audio, la cantidad de subtítulos y la cantidad de texto de video.
select
	Cursos.ID,
	Cursos.Nombre,
	(select
	count(TiposIdioma.ID)
	from TiposIdioma
	inner join Idiomas_x_Curso on Idiomas_x_Curso.IDTipo=TiposIdioma.ID
	where TiposIdioma.Nombre like '%subtítulo%' and Cursos.ID=Idiomas_x_Curso.IDCurso) as'idiomas sub',
	(select
	count(TiposIdioma.ID)
	from TiposIdioma
	inner join Idiomas_x_Curso on Idiomas_x_Curso.IDTipo=TiposIdioma.ID
	where TiposIdioma.Nombre like '%Texto del video%' and Cursos.ID=Idiomas_x_Curso.IDCurso) as'idiomas texto',
	(select
	count(TiposIdioma.ID)
	from TiposIdioma
	inner join Idiomas_x_Curso on Idiomas_x_Curso.IDTipo=TiposIdioma.ID
	where TiposIdioma.Nombre like '%audio%' and Cursos.ID=Idiomas_x_Curso.IDCurso) as'idiomas audio'
from Cursos
-- consultas auxiliares --
use [Monkey University]
select
	count(TiposIdioma.ID)
from TiposIdioma
inner join Idiomas_x_Curso on Idiomas_x_Curso.IDTipo=TiposIdioma.ID
where TiposIdioma.Nombre like '%audio%'
select
	count(TiposIdioma.ID)
from TiposIdioma
inner join Idiomas_x_Curso on Idiomas_x_Curso.IDTipo=TiposIdioma.ID
where TiposIdioma.Nombre like '%Texto del video%'
select
	count(TiposIdioma.ID)
from TiposIdioma
inner join Idiomas_x_Curso on Idiomas_x_Curso.IDTipo=TiposIdioma.ID
where TiposIdioma.Nombre like '%Subtítulo%'
select * from Idiomas_x_Curso order by Idiomas_x_Curso.IDTipo asc


select c.Nombre,
(select count(ti.id) from TiposIdioma as ti join Idiomas_x_Curso as ixc on ti.ID = ixc.IDTipo where ti.Nombre = 'audio' and c.id = ixc.IDCurso ) AS 'CANTIDAD AUDIO',
(select count(ti.id) from TiposIdioma as ti join Idiomas_x_Curso as ixc on ti.ID = ixc.IDTipo where ti.Nombre = 'video' and c.id = ixc.IDCurso ) AS 'CANTIDAD VIDEO',
(select count(ti.id) from TiposIdioma as ti join Idiomas_x_Curso as ixc on ti.ID = ixc.IDTipo where ti.Nombre = 'SUBTITULOS' and c.id = ixc.IDCurso ) AS 'CANTIDAD SUBT.'
from Cursos as c
-- 10  Listado con apellidos y nombres de los usuarios, nombre de usuario y cantidad de cursos de nivel 'Principiante' que realizó y cantidad de cursos de nivel 'Avanzado' que realizó.
select
	Datos_Personales.Apellidos+', '+Datos_Personales.Nombres as 'apenom',
	Usuarios.NombreUsuario,
	(select
	count( Cursos.ID)
	from Cursos
	inner join Niveles on Niveles.ID=Cursos.IDNivel
	inner join Inscripciones on Inscripciones.IDCurso=Cursos.ID
	where Niveles.Nombre like '%principiante%' and Inscripciones.IDUsuario=Usuarios.ID) as 'cant c.principiante',
	(select
	count( Cursos.ID)
	from Cursos
	inner join Niveles on Niveles.ID=Cursos.IDNivel
	inner join Inscripciones on Inscripciones.IDCurso=Cursos.ID
	where Niveles.Nombre like '%avanzado%' and Inscripciones.IDUsuario=Usuarios.ID) as 'cant c.avanzado'
from Usuarios
inner join Datos_Personales on Datos_Personales.ID=Usuarios.ID
--
select
	count( Cursos.ID)
from Cursos
inner join Niveles on Niveles.ID=Cursos.IDNivel
inner join Inscripciones on Inscripciones.IDCurso=Cursos.ID
where Niveles.Nombre like '%principiante%'
select
	count(Cursos.ID)
from Cursos
inner join Niveles on Niveles.ID=Cursos.IDNivel
inner join Inscripciones on Inscripciones.IDCurso=Cursos.ID
where Niveles.Nombre like '%avanzado%'
select
	Cursos.ID,
	Cursos.IDNivel,
	Niveles.Nombre
from Cursos
inner join Niveles on Niveles.ID=Cursos.IDNivel
order by Niveles.ID asc
-- 11  Listado con nombre de los cursos y la recaudación de inscripciones de usuarios de género femenino que se inscribieron y la recaudación de inscripciones de usuarios de género masculino.
select
	Cursos.ID,
	Cursos.Nombre,
	(select
	isnull(SUM(Inscripciones.Costo), 0)
	from Inscripciones
	inner join Usuarios on Usuarios.ID=Inscripciones.IDUsuario
	inner join Datos_Personales on Datos_Personales.ID=Usuarios.ID
	where Datos_Personales.Genero like '%f%' and Cursos.ID=Inscripciones.IDCurso) as 'recaudacionF',
	(select
	isnull(SUM(Inscripciones.Costo), 0)
	from Inscripciones
	inner join Usuarios on Usuarios.ID=Inscripciones.IDUsuario
	inner join Datos_Personales on Datos_Personales.ID=Usuarios.ID
	where Datos_Personales.Genero like '%m%' and Cursos.ID=Inscripciones.IDCurso) as 'recaudacionM'
from Cursos
--
select
	SUM(Inscripciones.Costo)
from Inscripciones
inner join Usuarios on Usuarios.ID=Inscripciones.IDUsuario
inner join Datos_Personales on Datos_Personales.ID=Usuarios.ID
where Datos_Personales.Genero like '%m%'
select
	SUM(Inscripciones.Costo)
from Inscripciones
inner join Usuarios on Usuarios.ID=Inscripciones.IDUsuario
inner join Datos_Personales on Datos_Personales.ID=Usuarios.ID
where Datos_Personales.Genero like '%f%'
-- 12  Listado con nombre de país de aquellos que hayan registrado más usuarios de género masculino que de género femenino.
select
	AUX.Nombre
from(
		select
			Paises.Nombre,
			(select
			count(Datos_Personales.IDPais)
			from Datos_Personales
			where Datos_Personales.Genero='m' and Paises.ID=Datos_Personales.IDPais) as 'm',
			(select
			count(Datos_Personales.IDPais)
			from Datos_Personales
			where Datos_Personales.Genero='f' and Paises.ID=Datos_Personales.IDPais) as 'f'
		from Paises
	) as AUX
where AUX.m>AUX.f
--
select
	count(Datos_Personales.IDPais)
from Datos_Personales
where Datos_Personales.Genero='m'
select
	count(Datos_Personales.IDPais)
from Datos_Personales
where Datos_Personales.Genero='f'
select
* from Datos_Personales order by Datos_Personales.Genero asc
-- 13  Listado con nombre de país de aquellos que hayan registrado más usuarios de género masculino que de género femenino pero que haya registrado al menos un usuario de género femenino.
select
	AUX.Nombre
from(
		select
			Paises.Nombre,
			(select
			count(Datos_Personales.IDPais)
			from Datos_Personales
			where Datos_Personales.Genero='m' and Paises.ID=Datos_Personales.IDPais) as 'm',
			(select
			count(Datos_Personales.IDPais)
			from Datos_Personales
			where Datos_Personales.Genero='f' and Paises.ID=Datos_Personales.IDPais) as 'f'
		from Paises
	) as AUX
where AUX.m>AUX.f and AUX.f>=1
-- 14  Listado de cursos que hayan registrado la misma cantidad de idiomas de audio que de subtítulos.

select
	AUX.Nombre,
--	AUX.[cant. audio],
--	AUX.[cant. subtitulo]
from(
		select
			Cursos.Nombre,
			(select
			count(Contenidos.IDTipo)
			from Contenidos
			inner join TiposContenido on TiposContenido.ID=Contenidos.IDTipo
			inner join Clases on Clases.ID=Contenidos.IDClase
			where TiposContenido.Nombre like '%audio%' and Clases.IDCurso=Cursos.ID) as 'cant. audio',
			(select
			count(Contenidos.IDTipo)
			from Contenidos
			inner join TiposContenido on TiposContenido.ID=Contenidos.IDTipo
			inner join Clases on Clases.ID=Contenidos.IDClase
			where TiposContenido.Nombre like '%texto%' and Clases.IDCurso=Cursos.ID) as 'cant. subtitulo'
		from Cursos 
	)as AUX
where AUX.[cant. audio]=AUX.[cant. subtitulo]
--
select
	count(Contenidos.IDTipo)
from Contenidos
inner join TiposContenido on TiposContenido.ID=Contenidos.IDTipo
where TiposContenido.Nombre like '%audio%'
select
	count(Contenidos.IDTipo)
from Contenidos
inner join TiposContenido on TiposContenido.ID=Contenidos.IDTipo
where TiposContenido.Nombre like '%texto%'
-- 15  Listado de usuarios que hayan realizado más cursos en el año 2018 que en el 2019 y a su vez más cursos en el año 2019 que en el 2020.
select
	AUX.ID,
	AUX.NombreUsuario
from(
		select
			Usuarios.ID,
			Usuarios.NombreUsuario,
			(select
			COUNT(Inscripciones.Fecha)
			from Inscripciones
			where YEAR(Inscripciones.Fecha)=2018 and Inscripciones.IDUsuario=Usuarios.ID) as '2018',
			(select
			COUNT(Inscripciones.Fecha)
			from Inscripciones
			where YEAR(Inscripciones.Fecha)=2019 and Inscripciones.IDUsuario=Usuarios.ID) as '2019',
			(select
			COUNT(Inscripciones.Fecha)
			from Inscripciones
			where YEAR(Inscripciones.Fecha)=2020 and Inscripciones.IDUsuario=Usuarios.ID) as '2020'
		from Usuarios
	)as AUX
where AUX.[2018]>AUX.[2019] and AUX.[2020]<AUX.[2019]
--
select
	COUNT(Inscripciones.Fecha)
from Inscripciones
where YEAR(Inscripciones.Fecha)=2018
select
	COUNT(Inscripciones.Fecha)
from Inscripciones
where YEAR(Inscripciones.Fecha)=2019
select
	COUNT(Inscripciones.Fecha)
from Inscripciones
where YEAR(Inscripciones.Fecha)=2020
-- 16  Listado de apellido y nombres de usuarios que hayan realizado cursos pero nunca se hayan certificado.
select
	AUX.apenom
from(
		select
			Datos_Personales.Apellidos+', '+Datos_Personales.Nombres as 'apenom',
			(select
			count(Inscripciones.IDUsuario)
			from Inscripciones
			where Inscripciones.IDUsuario=Datos_Personales.ID) as 'cant. inscripciones',
			(select
			count(Certificaciones.IDInscripcion)
			from Certificaciones
			inner join Inscripciones on Inscripciones.ID=Certificaciones.IDInscripcion
			where Inscripciones.IDUsuario=Datos_Personales.ID) as 'cant. certificaciones'
		from Datos_Personales
	) as AUX
where AUX.[cant. inscripciones]>AUX.[cant. certificaciones] 
--
select
	count(Inscripciones.IDUsuario)
from Inscripciones
select
	count(Certificaciones.IDInscripcion)
from Certificaciones
inner join Inscripciones on Inscripciones.ID=Certificaciones.IDInscripcion
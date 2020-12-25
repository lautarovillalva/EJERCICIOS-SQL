--Apellido y nombres de los pacientes cuya cantidad de turnos de 'Protologia' sea mayor a 2.
use [parcial1]
select
	AUX.APELLIDO,
	AUX.NOMBRE
from(
	select
			PACIENTES.APELLIDO,
			pacientes.nombre,
			(
			select
				count (turnos.idturno)
			from turnos
			inner join medicos on turnos.idmedico=medicos.idmedico
			inner join especialidades on especialidades.idespecialidad=medicos.idespecialidad
			where especialidades.nombre like '%proctologia%' and pacientes.idpaciente=turnos.idpaciente) as 'cant'
			from pacientes
)as AUX
where AUX.cant>2

select
	AUX.apenom
from(
	select
		PACIENTES.APELLIDO+', '+PACIENTES.NOMBRE as 'apenom',
		(
		select
			count (TURNOS.IDPACIENTE)
		from TURNOS
		inner join MEDICOS on turnos.IDMEDICO=MEDICOS.IDMEDICO
		inner join ESPECIALIDADES on ESPECIALIDADES.IDESPECIALIDAD=MEDICOS.IDESPECIALIDAD
		where ESPECIALIDADES.NOMBRE like '%proctologia%' and PACIENTES.IDPACIENTE=TURNOS.IDPACIENTE) as 'cant'
		from PACIENTES
	)as AUX
where AUX.cant>2
--Los apellidos y nombres de los médicos cuyo costo de consulta sea mayor al costo de consulta
--de todos los médicos de especialidad 'Pediatria'

select
	MEDICOS.APELLIDO+', '+MEDICOS.NOMBRE as 'apenom'
from MEDICOS
where MEDICOS.COSTO_CONSULTA>(
	select
		MAX(MEDICOS.COSTO_CONSULTA)
	from MEDICOS
	inner join ESPECIALIDADES on ESPECIALIDADES.IDESPECIALIDAD=MEDICOS.IDESPECIALIDAD
	where ESPECIALIDADES.NOMBRE like '%pediatria%')
--Por cada paciente, el apellido y nombre y la cantidad de turnos realizados en el primer semestre
--y la cantidad de turnos realizados en el segundo semestre. Indistintamente del año.

select
	PACIENTES.APELLIDO+', '+PACIENTES.NOMBRE as 'apenom',
	(select
	count(TURNOS.IDTURNO)
	from TURNOS where MONTH(TURNOS.FECHAHORA)<=6 and TURNOS.IDPACIENTE=PACIENTES.IDPACIENTE) as 'cant semetre1',
	(select
	count(TURNOS.IDTURNO)
	from TURNOS where MONTH(TURNOS.FECHAHORA)>6 and TURNOS.IDPACIENTE=PACIENTES.IDPACIENTE) as 'cant semetre2'
from PACIENTES

--
select
count(TURNOS.IDTURNO)
from TURNOS where MONTH(TURNOS.FECHAHORA)<=6
select
count(TURNOS.IDTURNO)
from TURNOS where MONTH(TURNOS.FECHAHORA)>6
select COUNT(*) from TURNOS


--La cantidad de pacientes que se hayan atendido más veces en el primer semestre que en el segundo semestre. 
--Indistintamente del año.
select
	AUX.apenom
from(
	select
		PACIENTES.APELLIDO+', '+PACIENTES.NOMBRE as 'apenom',
		(select
		count(TURNOS.IDTURNO)
		from TURNOS where MONTH(TURNOS.FECHAHORA)<=6 and TURNOS.IDPACIENTE=PACIENTES.IDPACIENTE) as 'cant semetre1',
		(select
		count(TURNOS.IDTURNO)
		from TURNOS where MONTH(TURNOS.FECHAHORA)>6 and TURNOS.IDPACIENTE=PACIENTES.IDPACIENTE) as 'cant semetre2'
	from PACIENTES
	) as AUX
where AUX.[cant semetre1]>AUX.[cant semetre2]
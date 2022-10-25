create database defensa_hito3_unifranzitos1;
use defensa_hito3_unifranzitos;
drop table campeonato;
create table campeonato(
	id_campeonato varchar (10) primary key,
	nombre_campeonato varchar (30),
	sede varchar (30)
);

insert into campeonato(id_campeonato,nombre_campeonato,sede)
values ('camp-111','Campeonato Unifranz','El Alto')
insert into campeonato(id_campeonato,nombre_campeonato,sede)
values ('camp-222','Campeonato Unifranz','Cochabamba')
drop table equipo;
drop table premios;
drop table jugador;
create table equipo(
	id_equipo varchar (10) primary key,
	nombre_equipo varchar (50),
	categoria varchar (15),
	id_campeonato varchar (10),
	foreign key(id_campeonato) references campeonato(id_campeonato)
);

insert into equipo(id_equipo,nombre_equipo,categoria,id_campeonato)
values ('equ-111','Google','VARONES','camp-111');
insert into equipo(id_equipo,nombre_equipo,categoria,id_campeonato)
values ('equ-222','484 Not found','VARONES','camp-111');
insert into equipo(id_equipo,nombre_equipo,categoria,id_campeonato)
values ('equ-333','girls unifrnaz','Mujeres','camp-111');
select*
from equipo;
create table jugador(
	id_jugador varchar (100) primary key,
	nombres varchar (200),
	apellidos varchar (300),
	ci varchar (200),
	edad integer,
	id_equipo varchar (10),
	foreign key(id_equipo) references equipo(id_equipo)
);

insert into jugador(id_jugador,nombres,apellidos,ci,edad,id_equipo)
values ('jug-111','Carlos','Villa','8997811LP',19,'equ-222');
insert into jugador(id_jugador,nombres,apellidos,ci,edad,id_equipo)
values ('jug-222','Pedro','Salas','8997822LP',20,'equ-222');
insert into jugador(id_jugador,nombres,apellidos,ci,edad,id_equipo)
values ('jug-333','Saul','Araj','8997833LP',21,'equ-222');
insert into jugador(id_jugador,nombres,apellidos,ci,edad,id_equipo)
values ('jug-444','Sandra','Solis','8997844LP',20,'equ-333');
insert into jugador(id_jugador,nombres,apellidos,ci,edad,id_equipo)
values ('jug-555','Ana','Mica','8997855LP',23,'equ-333');
select *
from jugador;

create table premios(
	posicion varchar(30) primary key,
	puntos integer,
	premio varchar (20),
	nombre_equipo varchar (30),
	id_equipo varchar (10),
	foreign key (id_equipo) references equipo(id_equipo)
);

insert into premios(posicion,puntos,premio,nombre_equipo,id_equipo)
values ('primero',45,'500Bs','Google','equ-222')
insert into premios(posicion,puntos,premio,nombre_equipo,id_equipo)
values ('segundo',38,'300Bs','girls unifranz','equ-333')


select *
from premios




select ju.nombres,ju.apellidos,ju.edad
from jugador as ju inner join equipo as eq on ju.id_equipo = eq.id_equipo
where eq.nombre_equipo='404 Not found' and ju.edad <= 20



select ju.nombres,ju.apellidos,ju.edad,eq.id_equipo,eq.nombre_equipo
from campeonato as camp inner join equipo as eq on camp.id_campeonato = eq.id_campeonato 
inner join jugador as ju on ju.id_equipo = eq.id_equipo
where ju.edad>20 and eq.id_equipo = 'equ-333' and camp.sede = 'El Alto'


select count(*)
from jugador as ju
where ju.id_equipo = 'equ-222'

select *
from jugador as ju 
where ju.nombres like 's%' and ju.apellidos like '%s'

select ju.nombres,ju.apellidos
from premios as pre inner join jugador as ju on pre.id_equipo = ju.id_equipo
where pre.posicion='primero'

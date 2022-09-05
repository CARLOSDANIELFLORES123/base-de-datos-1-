create database tarea113_h2;
use tarea113_h2;
create table cliente5(
     Nombres varchar (100),
	 Apellidos varchar (100),
	 CI varchar (100) PRIMARY KEY,
	 
);

create table vehiculo5(
    ide_car varchar (100)primary key, 
	modelo varchar (100),
	color varchar(100),
	marca varchar (100),
	costo integer,


);
create table compra5(
    NIT varchar (100),
	numero_de_compra integer primary key ,
	ide_car varchar (100),
	foreign key (CI) references cliente5(CI),
	foreign key (ide_car)  references compra5(ide_car),
	foreign key (CI) references vehiculo5(CI),
);

-- añadiendo a la tabla cliente5 
insert into cliente5(Nombres_Apellidos_CI)
values ('Carlos','Flores','13372398');
insert into compra5(NIT,numero_de_compra,ide_car,precio)
values('´456445645','13372398','1450ZER',15000);
insert into vehiculo5(ide_car,modelo,color,marca,costo)
values('1450ZER','MINIBUS','BLANCO','TOYOTA',15000);

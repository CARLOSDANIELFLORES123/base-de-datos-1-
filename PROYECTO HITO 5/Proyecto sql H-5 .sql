create database Bancos_BOL
use Bancos_BOL

create table Users 
(
CI varchar (100) primary key not null,
Nombres varchar (100) not null,
Apellidos varchar (100) not null,
Direccion varchar (100) not null
);
insert into Users (CI,Nombres, Apellidos ,Direccion)
values ('891245Lp', 'Leonel ', 'Burgos De la fuente', 'Satelite calle 4')
insert into Users (CI,Nombres, Apellidos ,Direccion)
values ('8702528Or', 'Rodrigo ',  'Mamani Quispe', 'La birra calle 20 ')
insert into Users (CI,Nombres, Apellidos ,Direccion)
values ('6344855Cbba', 'Carlos ', 'Chavez Santander', 'Plaza Row calle 8 #50')

Create table Banco 
(
Nit integer primary key not null,
Nombre_Banco varchar (50) not null,
id_tipo_banco integer identity  not null,
foreign key (id_tipo_banco) references Tipo_Banco (id_tipo_banco),
Fecha datetime not null

);

insert into Banco (Nit,Nombre_Banco,Fecha)
values (7812478,'BOL BANCO',  4/12/2020 )

create table Tipo_Banco 
(
id_tipo_banco integer identity primary key not null,
tipo_Banco bit not null,

);

insert into Tipo_Banco ( tipo_Banco)
values (1)
, (0)


-- si la empresa en la base de datos ingreso los datos y el tipos de banco en 1 es que es fisica 
-- en caso de que la empresa en tipo de banco coloco 0 es que en banco en  


create table Direccion 
(
id_direccion varchar (100)primary key not null, 
Direccion varchar (100) not null, 
Nit integer  not null,
foreign key (Nit) references Banco (Nit)
);


insert into Direccion (id_direccion,Direccion,Nit) 
values ('7812478', 'Sopocachi calle 2', 7812478) 
,('63517', 'Palos Blancos ',7812478  )

create table Ciudad 
(
id_ciudad_o_provincia integer primary key not null,
nombre_ciudad_o_provincia varchar (100) not null,

);
insert into Ciudad (id_ciudad_o_provincia,nombre_ciudad_o_provincia)
values (7845778,'La-paz Bolivia ')
, (62315,'Oruro Bolivia')

create table Guardar 
(
Id_Guardar integer identity primary key not null,
id_busqueda integer not null,
foreign key (id_busqueda) references Busqueda (id_busqueda),
CI varchar (100)  not null,
foreign key (CI) references Users (CI)

);

Insert into Guardar (id_busqueda,CI)
values (2,'891245Lp')

create table Busqueda 
(
id_busqueda integer identity primary key not null,
id_ciudad_o_provincia integer not null,
foreign key (id_ciudad_o_provincia) references Ciudad (id_ciudad_o_provincia),
Nit integer not null,
foreign key (Nit) references Banco (Nit)
);

insert into Busqueda (id_ciudad_o_provincia,Nit)
values (7845778, 7812478)
insert into Busqueda (id_ciudad_o_provincia,Nit)
values (62315, 7812478)


select *
from Direccion as Dic 
inner join Banco as Banc on Dic.Nit = Banc.Nit
where Dic.Direccion = 'Sopocachi calle 2'


select us.Nombres,us.Apellidos,Bus.id_ciudad_o_provincia
from Users as us inner join Guardar as gu on us.CI = gu.CI 
inner join Busqueda as Bus on Bus.id_busqueda = gu.id_busqueda


select us.Nombres,us.Direccion,banc.Nombre_Banco
from Banco as banc inner join Busqueda as bus on banc.Nit = bus.Nit inner join Guardar as gu on gu.id_busqueda = bus.id_busqueda 
inner join Users as us on us.CI = gu.CI
where us.CI = '891245Lp' and us.Direccion = 'Satelite calle 4' and banc.Nombre_Banco = 'BOL BANCO'


select *
from Tipo_Banco as tip 
inner join Banco as banc on tip.id_tipo_banco = banc.id_tipo_banco


select count(tip.id_tipo_banco) as Fisicas
from Tipo_Banco as tip 
where tip.tipo_Banco = 1


 create function Nro_Direccion_Banco(@Direccion varchar(100))
 returns integer as
 begin
	declare @resp integer;

	select @resp = COUNT(Banc.Nit)
	from Direccion as Dic inner join Banco as Banc on Dic.Nit = Banc.Nit
	where Dic.Direccion = @Direccion

	return @resp;

 end;

 select dbo.Nro_Direccion_Banco('Sopocachi calle 2') as Nro_Sucursales



 create function Nro_Users_Ciudad(@ciudad varchar(100))
 returns integer as
 begin
	declare @resp integer;

	select @resp = COUNT(us.CI)
	from Users as us inner join Guardar as gu on us.CI = gu.CI inner join Busqueda as Bus on Bus.id_busqueda = gu.id_busqueda
	where Bus.id_ciudad_o_provincia = @ciudad

	return @resp;

 end;

 select dbo.Nro_Users_Ciudad(7845778) as Nro_Users_Ciudad




  create function Busqueda_User(@Ci varchar(20),@direccion varchar(50),@nom_banco varchar(20))
 returns integer as
 begin
	declare @resp integer;

	
	select @resp = count(us.CI)
	from Banco as banc inner join Busqueda as bus on banc.Nit = bus.Nit inner join Guardar as gu on gu.id_busqueda = bus.id_busqueda inner join Users as us on us.CI = gu.CI
	where us.CI = @Ci and us.Direccion = @direccion and banc.Nombre_Banco = @nom_banco


	return @resp;

 end;

 select dbo.Busqueda_User('891245Lp','Satelite calle 4','BOL BANCO') as Nro_busqueda_user




  create function Canct_Tip_Banc(@tipo bit)
 returns integer as
 begin
	declare @resp integer;

	select @resp = count(tip.id_tipo_banco)
	from Tipo_Banco as tip 
	where tip.tipo_Banco = @tipo

	return @resp;

 end;

 select dbo.Canct_Tip_Banc(1) as Nro_Users_Ciudad
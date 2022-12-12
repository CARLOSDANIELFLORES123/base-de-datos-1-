create database BD_TUPAC;
use BD_TUPAC

create table tienda 
(
Nit integer primary key not null,
ubicacion varchar (100) not null,
nombre varchar (20) not null

);

Insert into tienda (Nit,ubicacion,nombre)
values (6931,'Sopocachi calle 2', 'TUPAC')

Create table producto 
(
Cod_producto varchar (20) primary key not null ,
Precio integer not null,
Modelo varchar (100)not null,
Talla varchar (15)not null,
);





--------------------------------------------------------
insert into producto (Cod_producto,Precio,Modelo,Talla)
values ('9348LO',100,'Camisa','L')
,('6831KM',55,'Polera Azul','S')
,('938LO',80,'Polo Gris','S')
,('536YW',190,'Chauqueta Verde','L')
,('9348L',250,'Chaqueta de Cuero','L')
,('579IY',150,'Abrigo Caqui','M')
,('897RE',100,'Abrigo Negro','M')
,('5799Y',130,'Chaqueta Caqui','L')
,('25896OL',150,'Polera manga larga','M')
,('78236OP',50,'Chaqueta Roja','L')
,('61258WB',125,'Chaqueta Jean','L')
,('8945OO',160,'Rompe vientos caqui','L')


create table cliente 
(
CI varchar (100) primary key not null,
Nombre_apellido varchar (100) not null,
Num_celular integer not null,
Correo_electronico varchar (200) not null,
Direccion varchar (200) not null,

);
------------------------------------------------------------
Create table Pedido
(
Num_pedido integer identity primary key not null,
precio integer,
Cod_producto varchar (20),
foreign key (Cod_producto) references producto(Cod_producto)

);
------------------------------------------------------------------
create table pago(
Nro_pago integer identity primary key,
tipo_pago varchar (20),
)

create table factura 
(
Num_factura integer identity primary key not null,
Cantidad integer not null , 
CI varchar (100) not null,
foreign key (CI) references cliente (CI),
Num_pedido integer not null,
foreign key (Num_pedido) references Pedido (Num_pedido),
Nit integer not null,
foreign key (Nit) references tienda (Nit),
Nro_Pago integer,
foreign key (Nro_pago) references pago(Nro_pago)
);

--------------------------------------------------------------------------

-- mostrar el numero de productos que tiene la tienda

select count(pro.Cod_producto) as Nro_productos
from producto as pro 

-- mostar la cantidad de precio que sean igaules a 100

select count(pro.Cod_producto)
from producto as pro inner join Pedido as ped on pro.Cod_producto = ped.Cod_producto
where ped.precio = 100

-- mostrar que cuantos cuesta menos de 50

select count(pro.Cod_producto)
from producto as pro inner join Pedido as ped on pro.Cod_producto = ped.Cod_producto
where ped.precio < 50

-- mostrar el prodcuto mas barato de la tienda

select min(ped.precio)
from producto as pro inner join Pedido as ped on pro.Cod_producto = ped.Cod_producto


--------------------------------------------------------------------------------------------------------------------

-- mostrar el numero de productos que tiene la tienda

create function Nro_Productos ()
returns integer as 
begin 
	declare @resp integer ;

	select @resp = count(pro.Cod_producto)
	from producto as pro 
	return @resp

end;


select dbo.Nro_Productos()as Nro_Productos

-- mostar la cantidad de precio que sean igaules a un preci determinado por el usuario

create function Precio_Producto (@precio integer)
returns integer as 
begin 
	declare @resp integer ;

	select @resp = count(pro.Cod_producto)
	from producto as pro inner join Pedido as ped on pro.Cod_producto = ped.Cod_producto
	where ped.precio = @precio

	return @resp

end;


select dbo.Precio_Producto (100)as Nro_Productos


-- mostrar que cuantos cuesta menos de un precio determinado


create function MPrecio_Producto (@precio integer)
returns integer as 
begin 
	declare @resp integer ;

	select @resp = count(pro.Cod_producto)
	from producto as pro inner join Pedido as ped on pro.Cod_producto = ped.Cod_producto
	where ped.precio < 50


	return @resp

end;

select dbo.MPrecio_Producto (100)as Nro_Productos

-- mostrar el precio mas barato de la tienda


create function Precio_barato ()
returns integer as 
begin 
	declare @resp integer ;

	select @resp = min(ped.precio)
	from producto as pro inner join Pedido as ped on pro.Cod_producto = ped.Cod_producto
	return @resp

end;

select dbo. Precio_barato()as Nro_Productos


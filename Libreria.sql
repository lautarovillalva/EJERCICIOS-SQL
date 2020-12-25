--create database Libreria
use Libreria

create table Vendedor(
Legajo int not null primary key identity (1,1),
DNI int not null unique,
Apellido varchar(50) not null,
Nombre varchar(50) not null,
Sexo char null,
FechaNac datetime not null,
Edad int not null check(Edad>=18),
FechaIng datetime not null,
Direccion varchar(50) not null,
CodigoPostal varchar(4) not null,
Localidad varchar(50) not null,
Provincia varchar(50) not null,
Telefono varchar(20) not null,
Sueldo money not null,
TotalVentasUltimoMes int not null check(TotalVentasUltimoMes>=0),
TotalFacturadoUltimoMes money not null check(TotalFacturadoUltimoMes>=0),
)
create table Factura(
CodigoFactura bigint not null primary key identity(1,1),
Fecha date not null,
Cliente varchar(50) not null,
LegajoVendedor int not null foreign key references Vendedor(Legajo),
FormaPago char not null,
Importe money not null check (Importe>0),
)
create table Articulo(
Codigo int not null primary key identity (1,1),
Descripcion varchar(50) not null,
Marca varchar(50) null,
PrecioCompra money not null,
PrecioVenta money not null,
Ganancia money not null,
Tipo varchar(50) not null,
StockActual int not null,
StockMinimo int not null,
Estado bit not null,
)
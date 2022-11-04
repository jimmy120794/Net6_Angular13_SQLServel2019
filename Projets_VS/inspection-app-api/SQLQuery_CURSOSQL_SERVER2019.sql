SELECT * 
FROM AdventureWorks2019.Person.Person

/*ELIMINAR UN DB*/
--DROP DATABASE AdventureWorks2019

/*TIPOS DE DATOS*/
--ALFANUMERICOS: char, varchar, binary, varbinary,text, image, nchar,nvarchar, ntext
--NUMERICOS: tinyint,smallint, int, bigint, float, money, numeric, real, decimal, bit, smallmoney
--FECHA: smalldatetime, datetime, timestamp, date,  time, datetime2, detetimeoffset

/*CREAR UN DB*/
CREATE DATABASE Curso_SQL
USE Curso_SQL

/*CREAR TABLE*/
CREATE TABLE Empleado
(
    ID_Empleado int identity(1,1) primary key not null, -- Primary Key column
    Nombre varchar(30) not null,
    Apellido varchar(30) not null,
    Sexo varchar(30) not null,
    Salario money not null,
    Departamento varchar(50)

);

CREATE TABLE [dbo].[Cliente]
(
    Id int identity(1,1) primary key not null, -- Primary Key column
    Nombre varchar(30),
    Apellido varchar(30),
    Telefono varchar(30),
    Edad int,
    Fecha_Nac date
);

CREATE TABLE Producto
(
    Id_Producto int identity(1,1) primary key not null, -- Primary Key column
    Marca varchar(30),
    Descripcion varchar(200),
    Precio_compra int,
    Precio_venta int
);

/*ELIMINAR TABLA*/
IF OBJECT_ID('[dbo].[Empleado]', 'U') IS NOT NULL
DROP TABLE [dbo].[Empleado]
GO

/*INSERTAR DATOS A TABLA*/

INSERT INTO Cliente
(
 Nombre, Apellido, Telefono, Edad, Fecha_Nac
)
VALUES
( 
    'Jimmy', 'Celly', '0983377916', 28, '07/12/1994'
),
( 
    'Ramon', 'Perez', '0980856775', 34, '07/12/1987'
),
( 
    'Marvin', 'Celly', '0984968496', 20, '08/20/2000'
),
( 
    'Israel', 'Salinas', '0985467328', 27, '05/10/1995'
),
(
    'Ariel', 'Rodriguez', '0945786527', 26, '11/23/1996'
),
(
    'Jose', 'Urueta', '0935671845', 26, '03/17/1996'
),
(
    'Daniel', 'Santos', '0983672619', 28, '06/11/1994'
),
(
    'Alex', 'Guaman', '0976785616', 34, '06/09/1987'
),
(
    'Miguel', 'Jaya', '0967233214', 27, '02/23/1995'
)

INSERT INTO Producto
(
 Marca, Descripcion, Precio_compra, Precio_venta
)
VALUES
( 
    'Tropical', 'Pintura Semi gloss', 345, 616
),
( 
    'Tropical', 'Pintura acrilica', 345, 500
),
( 
    'Stroman', 'Clavos de pared', 1, 3
),
( 
    'Stanley', 'Martillo', 100, 150
),
(
    'Stanley', 'Sierra Electrica', 1500, 2500
),
(
    'Ironman', 'Alicate', 245, 320
),
(
    'Stanley', 'Cinta Metrica', 75, 130
),
(
    'Stroman', 'Brocha', 25, 35
),
(
    'Stroman', 'Espatula', 20, 35
)

INSERT INTO Empleado
VALUES
( 
    'Jose', 'Almanzar', 'Masculino', 13500, 'Finanzas'
),
( 
    'Anny', 'Peralta', 'Fenmenino', 14500, 'Recursos Humanos'
),
( 
    'Arisbech', 'Matias', 'Fenmenino', 15000, 'Computos'
),
( 
    'Raymond', 'Ciriaco', 'Masculino', 13500, 'Finanzas'
),
(
    'Luis', 'Almanzar', 'Masculino', 10000, 'Ventas'
),
(
    'Diego', 'Peralta', 'Masculino', 14500, 'Computos'
),
(
    'Maria', 'Binet', 'Fenmenino', 12000, 'Recepcion'
),
(
    'Natividad', 'Gonzalez', 'Fenmenino', 14500, 'Ventas'
)



/*REALIZANDO CONSULTAS A LAS TABLAS*/

select * from Cliente

select nombre, apellido, Edad, Fecha_Nac from Cliente

select * from Cliente where Edad = 34

select * from Cliente where Fecha_Nac between '07/12/1994' and '05/10/1995' order by Fecha_Nac DESC 

select * from Cliente where Fecha_Nac between '07/12/1994' and '05/10/1995' order by Fecha_Nac 

select * from Cliente where Apellido = 'Celly'

select * from Cliente where Apellido like  'C%'

select * from Cliente where Apellido like  '%ntos' 

select * from Cliente where Apellido like  '%lly' and Edad>20

select * from Cliente where (Apellido like  '%lly') and (Edad between 21 and 30)

select * from Cliente where (Apellido like  '%lly') and (Edad between 20 and 30) order by Nombre

select COUNT(Id) as Total, Apellido from cliente group by Apellido

select Apellido, COUNT(Id) as Total from cliente group by Apellido

select COUNT(Id) as Total, Apellido from cliente group by Apellido order by Apellido DESC

select * from cliente where Edad > 27

select * from cliente where Edad >= 27

select * from cliente where Edad <> 34

select * from cliente where Edad not in (27)

select Count(*) Total_registros from cliente where Edad <> 34

/*BORRAR TODA LA INFORMACION DE UNA TABLA*/

delete from Cliente

/*BORRAR  INFORMACION FILTRADA DE UNA TABLA*/

delete from Cliente where Nombre like 'Al%'

select * from Cliente

/*ACTUALIZAR DATOS DE UNA TABLA*/

UPDATE Cliente
SET
    Edad = 29
    -- Add more columns and values here
WHERE Nombre = 'Jimmy' and Apellido = 'Celly'

select * from Cliente

/*CONDICIONAL EN SQL SERVER 2019*/

IF OBJECT_ID('Cliente', 'U') IS NOT NULL
    select * from cliente

ELSE
    select Edad from cliente
 GO

 /*IDENTITY*/
 /*
    - Es muy usado en campos ID, para que sea autonumerico o autoincremento
    - Por defecto el valor campo comienza en 1 e incrementa 1
    - No nos permite introducir informaciones
 */

CREATE TABLE Usuario
(
    Id int identity(1,1) primary key not null, -- Primary Key column
    Nombre varchar(30),
);

select * from Usuario

INSERT INTO Usuario
(
 Nombre
)
VALUES
( 
    'Jacelly'
),
( 
    'RaPerez'
),
( 
    'MaCelly'
),
( 
    'IsSalinas'
)

/*FUNCIONES Sum, Min, Max, Avg*/

Select * from Cliente 

select Count(*) as TotalRegistros from Cliente

select Sum(Edad) as SumaAllEdad from Cliente

select Min(Edad) as MixAllEdad from Cliente

select Max(Edad) as MaxAllEdad from Cliente

select Avg(Edad) as AvgAllEdad from Cliente

select Avg(Edad)*Count(*) as SumaAllEdad2 from Cliente

select Count(*)/2 as Div from Cliente

select Count(*)%2 as ResiduoDiv from Cliente

/*CONCATENACION*/
/*
-Permite unir la informacion de dos campos o mas.
*/

select * from Cliente

select CONCAT(Edad,Id) as Edad_Id from Cliente

select CONCAT(Edad,Nombre) as ContraseniaSimple from Cliente

select CONCAT(Edad,Nombre,Id) + 'o@#!$' as ContraseniaCompleja from Cliente

/*CLAUSULA TOP*/

select   TOP(3)  Sum(Edad)/2 as Max_edad from Cliente

/*CLAUSULA GROUP BY*/

select Sum(Edad) as Suma, Edad from Cliente Group by Edad


/*LIKE*/

select * from Producto

select * from Producto where Precio_venta like '%5'

select * from Producto where Marca like 'Sta%'

select * from Producto where Marca like '%RoMa%'

select * from Producto where Marca like '%roma%'

select * from Producto where Marca like 'Tropical'

select * from Producto where Precio_compra like '%45'

select * from Producto where Precio_compra like '34%'

select * from Producto where Precio_compra like '%34%'

select * from Producto where Precio_compra like '345'

select * from Producto where Precio_compra like 345

/*GROUP BY*/

/*
Sintaxis:
select Columna from tabla group by columna
*/

select * from Empleado

select Apellido from Empleado group by Apellido

select Apellido, count(Apellido) as Cant_Empleado from Empleado group by Apellido order by Apellido desc

select Apellido, sum(Salario) as Total_Salario from Empleado group by Apellido

select Sexo, Count(Sexo) as Cantidad from Empleado group by Sexo

/*CLAUSULA HAVING*/
/*
- Filtrar resultados obtenidos ya realizados por un GROUP BY
- Se lo utiliza utilizando los operadores relacionales (<,>,<=, >=,=, <>)
- Se puede usar tambien funciones como Max, Min, Avg, Sum, Count entre otros.
*/

select Departamento,  avg(Salario) as Porciento 
from Empleado 
group by Departamento having avg(Salario) > 13000

select Departamento,  avg(Salario) as Porciento 
from Empleado 
where Departamento = 'Finanzas'
group by Departamento having avg(Salario) <= 15000

select Departamento, count(Nombre) as Cantidad_Empleado 
from Empleado 
group by Departamento having count(Nombre) <> 2


/*CLAUSULA DISTINCT*/
/*
    - Mostrar valores unicos o dependientes de una fila...
    - Es decir los valores repetidos los muestra una sola vez.
*/

select * from Producto

select distinct Marca from Producto

select distinct Marca, count(Marca) as Cantidad from Producto group by Marca

select  Marca, Precio_venta from Producto
select distinct Marca, count(Marca) as Cantidad, sum(Precio_venta) as Precio_Total_Venta from Producto group by Marca

/**/


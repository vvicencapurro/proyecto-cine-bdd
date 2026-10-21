drop database if exists cine;
create database cine;
use cine;


create table directores (
    id_director int primary key auto_increment,
    nombre_director varchar(100) not null,
    edad int,
    email varchar(100)
);

create table generos (
    id_genero int primary key auto_increment,
    nombre_genero varchar(50) not null
);

create table productoras (
    id_productora int primary key auto_increment,
    nombre_productora varchar(100) not null,
    pais varchar(50)
);

create table tipos_funciones (
    id_tipo_funcion int primary key auto_increment,
    descripcion varchar(100) not null
);

create table ciudades (
    id_ciudad int primary key auto_increment,
    nombre varchar(100) not null
);

create table puestos (
    id_puesto int primary key auto_increment,
    nombre varchar(50) not null
);

create table clientes (
    id_cliente int primary key auto_increment,
    nombre_cliente varchar(100) not null,
    email varchar(100),
    telefono varchar(20)
);

create table productos (
    id_producto int primary key auto_increment,
    nombre_producto varchar(100) not null,
    descripcion varchar(200),
    precio decimal(10,2) not null,
    stock int not null
);

create table promociones (
    id_promocion int primary key auto_increment,
    nombre_promocion varchar(100) not null,
    porc_descuento decimal(5,2) not null,
    fecha_inicio date not null,
    fecha_fin date not null
);



create table peliculas (
    id_pelicula int primary key auto_increment,
    nombre_pelicula varchar(100) not null,
    id_director int not null,
    duracion_en_min int not null,
    id_genero int not null,
    id_productora int not null,
    foreign key (id_director) references directores(id_director),
    foreign key (id_genero) references generos(id_genero),
    foreign key (id_productora) references productoras(id_productora)
);

create table sucursales (
    id_sucursal int primary key auto_increment,
    nombre_sucursal varchar(100) not null,
    id_ciudad int not null,
    foreign key (id_ciudad) references ciudades(id_ciudad)
);

create table empleados (
    id_empleado int primary key auto_increment,
    nombre_empleado varchar(100) not null,
    id_puesto int not null,
    id_sucursal int not null,
    foreign key (id_puesto) references puestos(id_puesto),
    foreign key (id_sucursal) references sucursales(id_sucursal)
);

create table salas (
    id_sala int primary key auto_increment,
    numero int not null,
    capacidad int not null,
    id_sucursal int not null,
    id_tipo_funcion int not null,
    foreign key (id_sucursal) references sucursales(id_sucursal),
    foreign key (id_tipo_funcion) references tipos_funciones(id_tipo_funcion)
);

create table funciones (
    id_funcion int primary key auto_increment,
    fecha date not null,
    hora time not null,
    id_pelicula int not null,
    id_sala int not null,
    id_tipo_funcion int not null,
    foreign key (id_pelicula) references peliculas(id_pelicula),
    foreign key (id_sala) references salas(id_sala),
    foreign key (id_tipo_funcion) references tipos_funciones(id_tipo_funcion)
);

create table butacas (
    id_butaca int primary key auto_increment,
    fila varchar(5) not null,
    numero int not null,
    estado varchar(30) not null,
    id_sala int not null,
    foreign key (id_sala) references salas(id_sala)
);

create table ventas (
    id_venta int primary key auto_increment,
    fecha date not null,
    hora time not null,
    metodo_pago varchar(50) not null,
    id_promocion int,
    id_cliente int not null,
    foreign key (id_promocion) references promociones(id_promocion),
    foreign key (id_cliente) references clientes(id_cliente)
);



create table productos_ventas (
    id_producto_venta int primary key auto_increment,
    precio_final decimal(10,2) not null,
    cantidad int not null,
    id_venta int not null,
    id_producto int not null,
    foreign key (id_venta) references ventas(id_venta),
    foreign key (id_producto) references productos(id_producto)
);

create table entradas (
    id_entrada int primary key auto_increment,
    precio decimal(10,2) not null,
    lugar varchar(50) not null,
    id_butaca int not null,
    id_funcion int not null,
    id_venta int not null,
    foreign key (id_butaca) references butacas(id_butaca),
    foreign key (id_funcion) references funciones(id_funcion),
    foreign key (id_venta) references ventas(id_venta)
);


create table usuarios (
    id_usuario int primary key auto_increment,
    nombre_usuario varchar(50) not null unique,
    email varchar(100) not null unique,
    password varchar(255) not null,
    fecha_registro datetime default current_timestamp
);
-- 1. CIUDADES
insert into ciudades values
(1, 'buenos aires'),
(2, 'cordoba'),
(3, 'rosario'),
(4, 'mendoza'),
(5, 'la plata'),
(6, 'mar del plata'),
(7, 'salta'),
(8, 'neuquen'),
(9, 'santa fe'),
(10, 'san juan');

-- 2. DIRECTORES
insert into directores values
(1, 'christopher nolan', 56, 'nolan@email.com'),
(2, 'james cameron', 72, 'cameron@email.com'),
(3, 'steven spielberg', 79, 'spielberg@email.com'),
(4, 'greta gerwig', 43, 'gerwig@email.com'),
(5, 'martin scorsese', 84, 'scorsese@email.com'),
(6, 'tim burton', 68, 'burton@email.com'),
(7, 'peter jackson', 65, 'jackson@email.com'),
(8, 'quentin tarantino', 63, 'tarantino@email.com'),
(9, 'guillermo del toro', 62, 'toro@email.com'),
(10, 'james wan', 49, 'wan@email.com');

-- 3. GENEROS
insert into generos values
(1, 'accion'),
(2, 'aventura'),
(3, 'ciencia ficcion'),
(4, 'drama'),
(5, 'comedia'),
(6, 'terror'),
(7, 'romance'),
(8, 'animacion'),
(9, 'suspenso'),
(10, 'fantasia');

-- 4. PRODUCTORAS
insert into productoras values
(1, 'warner bros', 'estados unidos'),
(2, 'universal pictures', 'estados unidos'),
(3, 'paramount pictures', 'estados unidos'),
(4, 'disney', 'estados unidos'),
(5, 'sony pictures', 'estados unidos'),
(6, '20th century studios', 'estados unidos'),
(7, 'netflix', 'estados unidos'),
(8, 'columbia pictures', 'estados unidos'),
(9, 'dreamworks', 'estados unidos'),
(10, 'lionsgate', 'estados unidos');

-- 5. TIPOS_FUNCIONES
insert into tipos_funciones values
(1, '2d'),
(2, '3d'),
(3, 'imax'),
(4, '4d'),
(5, 'doblada'),
(6, 'subtitulada'),
(7, 'premium'),
(8, 'vip'),
(9, 'matinee'),
(10, 'estreno');

-- 6. PUESTOS
insert into puestos values
(1, 'gerente'),
(2, 'cajero'),
(3, 'vendedor'),
(4, 'supervisor'),
(5, 'limpieza'),
(6, 'tecnico'),
(7, 'seguridad'),
(8, 'encargado de confiteria'),
(9, 'atencion al cliente'),
(10, 'administrativo');

-- 7. CLIENTES
insert into clientes values
(1, 'ana martinez', 'ana@email.com', '1111111111'),
(2, 'pedro lopez', 'pedro@email.com', '2222222222'),
(3, 'lucia fernandez', 'lucia@email.com', '3333333333'),
(4, 'martin gonzalez', 'martin@email.com', '4444444444'),
(5, 'carla rodriguez', 'carla@email.com', '5555555555'),
(6, 'diego perez', 'diego@email.com', '6666666666'),
(7, 'florencia diaz', 'florencia@email.com', '7777777777'),
(8, 'tomas castro', 'tomas@email.com', '8888888888'),
(9, 'julieta romero', 'julieta@email.com', '9999999999'),
(10, 'facundo torres', 'facundo@email.com', '1010101010');

-- 8. PRODUCTOS
insert into productos values
(1, 'pochoclos grandes', 'balde grande de pochoclos', 8500.00, 50),
(2, 'pochoclos chicos', 'vaso chico de pochoclos', 4500.00, 60),
(3, 'gaseosa grande', 'gaseosa de un litro', 6000.00, 40),
(4, 'gaseosa chica', 'gaseosa de medio litro', 3500.00, 70),
(5, 'agua mineral', 'botella de agua', 2500.00, 50),
(6, 'chocolate', 'barra de chocolate', 3000.00, 30),
(7, 'caramelos', 'bolsa de caramelos', 1800.00, 80),
(8, 'nachos', 'nachos con salsa', 5500.00, 35),
(9, 'pancho', 'pancho con aderezos', 4000.00, 25),
(10, 'combo familiar', 'pochoclos y cuatro bebidas', 18000.00, 20);

-- 9. PROMOCIONES
insert into promociones values
(1, 'descuento estudiantes', 15.00, '2026-01-01', '2026-12-31'),
(2, 'martes de cine', 20.00, '2026-01-01', '2026-12-31'),
(3, 'descuento jubilados', 10.00, '2026-01-01', '2026-12-31'),
(4, 'combo familiar', 25.00, '2026-01-01', '2026-12-31'),
(5, 'estreno especial', 10.00, '2026-10-01', '2026-10-31'),
(6, 'club cinemax', 15.00, '2026-01-01', '2026-12-31'),
(7, 'promo vacaciones', 20.00, '2026-07-01', '2026-12-31'),
(8, 'noche de terror', 12.00, '2026-10-01', '2026-10-31'),
(9, 'descuento online', 8.00, '2026-01-01', '2026-12-31'),
(10, 'dia del cine', 30.00, '2026-10-01', '2026-12-31');

-- 10. SUCURSALES
insert into sucursales values
(1, 'cinemax centro', 1, 'avenida corrientes 100', '1100000001'),
(2, 'cinemax norte', 1, 'avenida cabildo 200', '1100000002'),
(3, 'cinemax cordoba', 2, 'avenida colon 300', '3500000001'),
(4, 'cinemax rosario', 3, 'calle cordoba 400', '3400000001'),
(5, 'cinemax mendoza', 4, 'avenida san martin 500', '2600000001'),
(6, 'cinemax plata', 5, 'calle 7 numero 600', '2200000001'),
(7, 'cinemax costa', 6, 'avenida independencia 700', '2230000001'),
(8, 'cinemax salta', 7, 'calle belgrano 800', '3870000001'),
(9, 'cinemax neuquen', 8, 'avenida argentina 900', '2990000001'),
(10, 'cinemax santa fe', 9, 'calle san martin 1000', '3400000002');

-- 11. PELICULAS
insert into peliculas values
(1, 'oppenheimer', 1, 180, 4, 1),
(2, 'titanic', 2, 195, 7, 3),
(3, 'jurassic park', 3, 127, 2, 2),
(4, 'barbie', 4, 114, 5, 1),
(5, 'el lobo de wall street', 5, 180, 4, 1),
(6, 'el joven manos de tijera', 6, 105, 10, 6),
(7, 'el senor de los anillos', 7, 178, 10, 9),
(8, 'kill bill', 8, 111, 1, 3),
(9, 'la forma del agua', 9, 123, 7, 6),
(10, 'el conjuro', 10, 112, 6, 2);

-- 12. SALAS
insert into salas values
(1, 1, 100, 1, 1),
(2, 2, 120, 1, 2),
(3, 1, 80, 2, 3),
(4, 1, 150, 3, 1),
(5, 2, 100, 4, 2),
(6, 1, 90, 5, 5),
(7, 1, 110, 6, 6),
(8, 1, 130, 7, 7),
(9, 1, 70, 8, 8),
(10, 1, 140, 9, 10);

-- 13. EMPLEADOS
insert into empleados values
(1, 'juan perez', 1, 1),
(2, 'maria gomez', 2, 1),
(3, 'lucas rodriguez', 3, 2),
(4, 'sofia fernandez', 4, 3),
(5, 'mateo lopez', 5, 4),
(6, 'valentina diaz', 6, 5),
(7, 'santiago torres', 7, 6),
(8, 'camila ramirez', 8, 7),
(9, 'benjamin flores', 9, 8),
(10, 'martina castro', 10, 9);

-- 14. BUTACAS
insert into butacas values
(1, 'a', 1, 'disponible', 1),
(2, 'a', 2, 'ocupada', 1),
(3, 'a', 3, 'disponible', 2),
(4, 'b', 1, 'disponible', 2),
(5, 'b', 2, 'ocupada', 3),
(6, 'c', 1, 'disponible', 4),
(7, 'c', 2, 'disponible', 5),
(8, 'd', 1, 'ocupada', 6),
(9, 'd', 2, 'disponible', 7),
(10, 'e', 1, 'disponible', 8);

-- 15. FUNCIONES
insert into funciones values
(1, '2026-10-15', '14:00:00', 1, 1, 1),
(2, '2026-10-15', '17:00:00', 2, 2, 2),
(3, '2026-10-15', '20:00:00', 3, 3, 3),
(4, '2026-10-16', '15:00:00', 4, 4, 1),
(5, '2026-10-16', '18:00:00', 5, 5, 2),
(6, '2026-10-16', '21:00:00', 6, 6, 5),
(7, '2026-10-17', '14:30:00', 7, 7, 6),
(8, '2026-10-17', '17:30:00', 8, 8, 7),
(9, '2026-10-18', '19:00:00', 9, 9, 8),
(10, '2026-10-18', '21:30:00', 10, 10, 10);

-- 16. VENTAS
insert into ventas values
(1, '2026-10-15', '13:00:00', 'efectivo', 1, 1),
(2, '2026-10-15', '16:00:00', 'tarjeta', 2, 2),
(3, '2026-10-15', '19:00:00', 'debito', 3, 3),
(4, '2026-10-16', '14:00:00', 'credito', 4, 4),
(5, '2026-10-16', '17:00:00', 'efectivo', 5, 5),
(6, '2026-10-16', '20:00:00', 'transferencia', 6, 6),
(7, '2026-10-17', '13:30:00', 'tarjeta', 7, 7),
(8, '2026-10-17', '16:30:00', 'debito', 8, 8),
(9, '2026-10-18', '18:00:00', 'credito', 9, 9),
(10, '2026-10-18', '20:30:00', 'efectivo', 10, 10);

-- 17. ENTRADAS
insert into entradas values
(1, 8000.00, 'sala 1', 1, 1, 1),
(2, 8500.00, 'sala 2', 2, 2, 2),
(3, 9000.00, 'sala 3', 3, 3, 3),
(4, 7500.00, 'sala 4', 4, 4, 4),
(5, 8000.00, 'sala 5', 5, 5, 5),
(6, 9500.00, 'sala 6', 6, 6, 6),
(7, 8500.00, 'sala 7', 7, 7, 7),
(8, 10000.00, 'sala 8', 8, 8, 8),
(9, 9000.00, 'sala 9', 9, 9, 9),
(10, 11000.00, 'sala 10', 10, 10, 10);

-- 18. PRODUCTOS_VENTAS
insert into productos_ventas values
(1, 8500.00, 1, 1, 1),
(2, 4500.00, 1, 2, 2),
(3, 12000.00, 2, 3, 3),
(4, 3500.00, 1, 4, 4),
(5, 5000.00, 2, 5, 5),
(6, 3000.00, 1, 6, 6),
(7, 3600.00, 2, 7, 7),
(8, 5500.00, 1, 8, 8),
(9, 8000.00, 2, 9, 9),
(10, 18000.00, 1, 10, 10);

-- consulta 1
select
    peliculas.id_pelicula,
    peliculas.nombre_pelicula,
    peliculas.duracion_en_min,
    directores.nombre_director,
    generos.nombre_genero,
    productoras.nombre_productora
from peliculas
inner join directores on peliculas.id_director = directores.id_director
inner join generos on peliculas.id_genero = generos.id_genero
inner join productoras on peliculas.id_productora = productoras.id_productora;
-- consulta 2
select
    peliculas.nombre_pelicula,
    funciones.fecha,
    funciones.hora,
    salas.numero,
    tipos_funciones.descripcion
from funciones
inner join peliculas on funciones.id_pelicula = peliculas.id_pelicula
inner join salas on funciones.id_sala = salas.id_sala
inner join tipos_funciones on funciones.id_tipo_funcion = tipos_funciones.id_tipo_funcion;
-- 3
select
    peliculas.nombre_pelicula,
    peliculas.duracion_en_min,
    generos.nombre_genero
from peliculas
inner join generos on peliculas.id_genero = generos.id_genero
where generos.nombre_genero = 'romance';
-- 4
select
    funciones.id_funcion,
    peliculas.nombre_pelicula,
    funciones.fecha,
    funciones.hora,
    butacas.id_butaca,
    butacas.fila,
    butacas.numero,
    salas.numero as numero_sala
from funciones
inner join peliculas on funciones.id_pelicula = peliculas.id_pelicula
inner join salas on funciones.id_sala = salas.id_sala
inner join butacas on salas.id_sala = butacas.id_sala
where funciones.id_funcion = 5 and butacas.estado = 'disponible';
-- 5
select
    ventas.id_venta,
    clientes.nombre_cliente,
    peliculas.nombre_pelicula,
    funciones.fecha,
    funciones.hora,
    entradas.precio,
    entradas.lugar,
    ventas.metodo_pago
from entradas
inner join ventas on entradas.id_venta = ventas.id_venta
inner join clientes on ventas.id_cliente = clientes.id_cliente
inner join funciones on entradas.id_funcion = funciones.id_funcion
inner join peliculas on funciones.id_pelicula = peliculas.id_pelicula
where clientes.id_cliente = 1
order by ventas.fecha desc, ventas.hora desc;
-- 6
select
    peliculas.nombre_pelicula,
    count(entradas.id_entrada) as entradas_vendidas,
    sum(entradas.precio) as recaudacion_total
from peliculas
inner join funciones on peliculas.id_pelicula = funciones.id_pelicula
inner join entradas on funciones.id_funcion = entradas.id_funcion
group by
    peliculas.id_pelicula,
    peliculas.nombre_pelicula
order by recaudacion_total desc;
-- 7
select
    nombre_producto,
    descripcion,
    precio,
    stock
from productos
where stock <= 30
order by stock desc;
-- 8
select
    sucursales.nombre_sucursal,
    ciudades.nombre as ciudad,
    count(entradas.id_entrada) as entradas_vendidas,
    sum(entradas.precio) as ingresos_totales
from sucursales
inner join salas on sucursales.id_sucursal = salas.id_sucursal
inner join funciones on salas.id_sala = funciones.id_sala
inner join entradas on funciones.id_funcion = entradas.id_funcion
inner join ciudades on sucursales.id_ciudad = ciudades.id_ciudad
group by
    sucursales.id_sucursal,
    sucursales.nombre_sucursal,
    ciudades.nombre
order by ingresos_totales desc;

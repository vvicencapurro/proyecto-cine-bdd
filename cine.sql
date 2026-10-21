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

<?php
include 'auth.php';  
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proyecto Cine</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <div class="contenedor">
        <h1>Sistema De Cine</h1>
        <p>Hola, <?php echo htmlspecialchars($_SESSION['nombre_usuario']); ?>. Seleccione una tabla</p>

        <div class="botones">
            <a href="ver.php?tabla=peliculas">Peliculas</a>
            <a href="ver.php?tabla=productoras">Productoras</a>
            <a href="ver.php?tabla=funciones">Funciones</a>
            <a href="ver.php?tabla=salas">Salas</a>
            <a href="ver.php?tabla=entradas">Entradas</a>
            <a href="ver.php?tabla=sucursales">Sucursales</a>
            <a href="ver.php?tabla=empleados">Empleados</a>
            <a href="ver.php?tabla=tipos_funciones">Tipos de Funciones</a>
        </div>

        <p class="enlace"><a href="logout.php">Cerrar sesion</a></p>
    </div>
</body>
</html>

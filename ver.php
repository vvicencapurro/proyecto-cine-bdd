<?php
include 'auth.php';       // solo usuarios logueados
include 'conexion.php';

// Lista de tablas que se pueden mostrar (así nadie puede pedir otra cosa por la URL)
$permitidas = [
    "peliculas"       => "Películas",
    "productoras"     => "Productoras",
    "funciones"       => "Funciones",
    "salas"           => "Salas",
    "entradas"        => "Entradas",
    "sucursales"      => "Sucursales",
    "empleados"       => "Empleados",
    "tipos_funciones" => "Tipos de Funciones"
];

$tabla = $_GET['tabla'] ?? '';

if (!array_key_exists($tabla, $permitidas)) {
    die("Tabla no válida.");
}

$resultado = mysqli_query($conexion, "SELECT * FROM $tabla");
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $permitidas[$tabla]; ?> - Proyecto Cine</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <div class="contenedor">
        <h1><?php echo $permitidas[$tabla]; ?></h1>

        <?php if (!$resultado): ?>
            <p class="mensaje error">No se pudo leer la tabla: <?php echo htmlspecialchars(mysqli_error($conexion)); ?></p>

        <?php elseif (mysqli_num_rows($resultado) == 0): ?>
            <p>Todavía no hay registros en esta tabla.</p>

        <?php else: ?>
            <div class="tabla-scroll">
                <table>
                    <thead>
                        <tr>
                            <?php foreach (mysqli_fetch_fields($resultado) as $columna): ?>
                                <th><?php echo htmlspecialchars($columna->name); ?></th>
                            <?php endforeach; ?>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($fila = mysqli_fetch_assoc($resultado)): ?>
                            <tr>
                                <?php foreach ($fila as $valor): ?>
                                    <td><?php echo htmlspecialchars((string)$valor); ?></td>
                                <?php endforeach; ?>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        <?php endif; ?>

        <p class="enlace"><a href="index.php">← Volver al menú</a></p>
    </div>
</body>
</html>

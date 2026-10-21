<?php
// Datos para conectarse a la base de datos (valores por defecto de XAMPP)
$host = "localhost";
$user = "root";
$pass = "";
$db   = "cine";   // antes decía "curso_sql": tiene que ser la base del proyecto

// Hace que los errores no corten el programa de golpe, los manejamos nosotros
mysqli_report(MYSQLI_REPORT_OFF);

$conexion = mysqli_connect($host, $user, $pass, $db);

if (!$conexion) {
    die("Error de conexion: " . mysqli_connect_error());
}

// Para que se vean bien las tildes y la ñ
mysqli_set_charset($conexion, "utf8mb4");
?>

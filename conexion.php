<?php

$host = "localhost";
$user = "root";
$pass = "";
$db   = "cine";


mysqli_report(MYSQLI_REPORT_OFF);

$conexion = mysqli_connect($host, $user, $pass, $db);

if (!$conexion) {
    die("Error de conexion: " . mysqli_connect_error());
}


mysqli_set_charset($conexion, "utf8mb4");
?>

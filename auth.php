<?php
// Este archivo se incluye en las páginas que solo pueden ver los usuarios logueados.
// Si la persona no inició sesión, la mandamos al login.
session_start();

if (!isset($_SESSION['id_usuario'])) {
    header("Location: login.php");
    exit;
}
?>

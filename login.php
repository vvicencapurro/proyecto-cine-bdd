<?php
session_start();
include 'conexion.php';

// Si ya está logueado, lo mandamos directo al menú
if (isset($_SESSION['id_usuario'])) {
    header("Location: index.php");
    exit;
}

$error = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $dato  = trim($_POST['nombre_usuario'] ?? '');   // puede ser usuario o email
    $clave = $_POST['password'] ?? '';

    // Buscamos al usuario por nombre o por email
    $stmt = mysqli_prepare($conexion,
        "SELECT id_usuario, nombre_usuario, password
         FROM usuarios
         WHERE nombre_usuario = ? OR email = ?");
    mysqli_stmt_bind_param($stmt, "ss", $dato, $dato);
    mysqli_stmt_execute($stmt);
    $resultado = mysqli_stmt_get_result($stmt);
    $usuario = mysqli_fetch_assoc($resultado);

    // password_verify compara lo que escribió con el hash guardado
    if ($usuario && password_verify($clave, $usuario['password'])) {
        session_regenerate_id(true);
        $_SESSION['id_usuario'] = $usuario['id_usuario'];
        $_SESSION['nombre_usuario'] = $usuario['nombre_usuario'];
        header("Location: index.php");
        exit;
    } else {
        $error = "Usuario o contraseña incorrectos.";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión - Proyecto Cine</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <div class="contenedor chico">
        <h1>Iniciar sesión</h1>

        <?php if ($error != ""): ?>
            <p class="mensaje error"><?php echo htmlspecialchars($error); ?></p>
        <?php endif; ?>

        <form method="POST" action="login.php">
            <label>Usuario o email</label>
            <input type="text" name="nombre_usuario" required>

            <label>Contraseña</label>
            <input type="password" name="password" required>

            <button type="submit">Entrar</button>
        </form>

        <p class="enlace">¿No tenés cuenta? <a href="registro.php">Registrate</a></p>
    </div>
</body>
</html>

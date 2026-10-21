<?php
session_start();
include 'conexion.php';

$error = "";
$ok = "";
$nombre = "";
$email = "";


if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $nombre = trim($_POST['nombre_usuario'] ?? '');
    $email  = trim($_POST['email'] ?? '');
    $clave  = $_POST['password'] ?? '';
    $clave2 = $_POST['password2'] ?? '';

    // 1) Validaciones básicas
    if ($nombre == "" || $email == "" || $clave == "") {
        $error = "Completá todos los campos.";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = "El email no es válido.";
    } elseif (strlen($clave) < 6) {
        $error = "La contraseña tiene que tener al menos 6 caracteres.";
    } elseif ($clave != $clave2) {
        $error = "Las contraseñas no coinciden.";
    } else {

        // 2) Ver si ya existe ese usuario o ese email
        $stmt = mysqli_prepare($conexion,
            "SELECT id_usuario FROM usuarios WHERE nombre_usuario = ? OR email = ?");
        mysqli_stmt_bind_param($stmt, "ss", $nombre, $email);
        mysqli_stmt_execute($stmt);
        mysqli_stmt_store_result($stmt);

        if (mysqli_stmt_num_rows($stmt) > 0) {
            $error = "Ese usuario o ese email ya está registrado.";
        } else {

            // 3) Guardar la contraseña "mezclada" (hash), nunca el texto real
            $hash = password_hash($clave, PASSWORD_DEFAULT);

            $stmt2 = mysqli_prepare($conexion,
                "INSERT INTO usuarios (nombre_usuario, email, password) VALUES (?, ?, ?)");
            mysqli_stmt_bind_param($stmt2, "sss", $nombre, $email, $hash);

            if (mysqli_stmt_execute($stmt2)) {
                $ok = "Cuenta creada! Ya podes iniciar sesion.";
                $nombre = "";
                $email = "";
            } else {
                $error = "No se pudo crear la cuenta. Proba de nuevo.";
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - Proyecto Cine</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <div class="contenedor chico">
        <h1>Crear cuenta</h1>

        <?php if ($error != ""): ?>
            <p class="mensaje error"><?php echo htmlspecialchars($error); ?></p>
        <?php endif; ?>

        <?php if ($ok != ""): ?>
            <p class="mensaje ok"><?php echo htmlspecialchars($ok); ?></p>
        <?php endif; ?>

        <form method="POST" action="registro.php">
            <label>Nombre de usuario</label>
            <input type="text" name="nombre_usuario" value="<?php echo htmlspecialchars($nombre); ?>" required>

            <label>Email</label>
            <input type="email" name="email" value="<?php echo htmlspecialchars($email); ?>" required>

            <label>Contraseña</label>
            <input type="password" name="password" required>

            <label>Repetir contraseña</label>
            <input type="password" name="password2" required>

            <button type="submit">Crear cuenta</button>
        </form>

        <p class="enlace">Ya tenes cuenta? <a href="login.php">Iniciar sesion</a></p>
    </div>
</body>
</html>

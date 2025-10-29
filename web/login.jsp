<%-- 
    Document   : login
    Created on : 27/10/2025, 8:09:28 p. m.
    Author     : crisf
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - UMG</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex justify-content-center align-items-center vh-100 bg-light">
    <form action="sr_login" method="post" class="p-4 border rounded bg-white shadow-sm" style="width:300px;">
        <h4 class="text-center mb-3">Iniciar sesión</h4>
        <div class="mb-3">
            <label class="form-label">Usuario</label>
            <input type="text" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Contraseña</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Entrar</button>
    </form>
</body>
</html>
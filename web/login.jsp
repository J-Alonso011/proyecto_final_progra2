<%-- 
    Document   : login
    Created on : 27/10/2025
    Author     : Cris
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - UMG</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: url('img/login.jpg') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            margin: 0;
        }

        /* Fondo difuminado */
        .bg-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.55);
            backdrop-filter: blur(6px);
            z-index: 0;
        }

        .login-container {
            position: relative;
            z-index: 1;
        }

        .login-card {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 380px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.25);
        }

        .login-card h3 {
            font-weight: 700;
            color: #0d6efd;
            margin-bottom: 20px;
        }

        .form-control {
            border-radius: 10px;
        }

        .btn-primary {
            border-radius: 10px;
            font-weight: bold;
            letter-spacing: 0.5px;
        }

        .alert {
            font-size: 14px;
        }
    </style>
</head>

<body class="d-flex justify-content-center align-items-center">
    <div class="bg-overlay"></div>

    <div class="login-container text-center">
        <div class="login-card">
            <div class="mb-3">
                <i class="bi bi-building display-4 text-primary"></i>
            </div>
            <h3>Iniciar Sesión</h3>

            <%-- Mensaje de error si las credenciales son incorrectas --%>
            <%
                String error = request.getParameter("error");
                if (error != null) {
            %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    Usuario o contraseña incorrectos.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <%
                }
            %>

            <form action="sr_login" method="post">
                <div class="mb-3 text-start">
                    <label class="form-label fw-semibold">Usuario</label>
                    <input type="text" name="username" class="form-control" placeholder="Ingrese su usuario" required>
                </div>
                <div class="mb-3 text-start">
                    <label class="form-label fw-semibold">Contraseña</label>
                    <input type="password" name="password" class="form-control" placeholder="Ingrese su contraseña" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-2 mt-3">
                    <i class="bi bi-box-arrow-in-right"></i> Entrar
                </button>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Auto-cerrar alerta -->
    <script>
        const alert = document.querySelector('.alert');
        if (alert) {
            setTimeout(() => {
                alert.classList.remove('show');
            }, 4000); // desaparece en 4 segundos
        }
    </script>
</body>
</html>
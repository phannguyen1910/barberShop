<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Password Changed Successfully</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: url('https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1374&q=80') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .success-container {
            background: rgba(255, 245, 230, 0.95);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            max-width: 400px;
            width: 100%;
            text-align: center;
            border: 1px solid #d4a373;
        }
        h2, h3 {
            color: #333;
        }
        .btn-primary {
            background: #d4a373;
            border: none;
            transition: background 0.3s ease;
        }
        .btn-primary:hover {
            background: #b8860b;
        }
        .btn-home {
            margin-top: 15px;
        }
        p {
            color: #555;
        }
        .text-success {
            color: #28a745 !important;
        }
    </style>
</head>
<script>
    setTimeout(function () {
        window.location.href = "${pageContext.request.contextPath}/views/common/home.jsp";
    }, 5000);
</script>
<body>
    <div class="success-container">
        <h3><i class="fa fa-check-circle fa-3x text-success"></i></h3>
        <h2 class="my-3">Password Changed Successfully</h2>
        <p>Your password has been updated. You can now log in with your new password.</p>
        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary w-100 btn-home">
            <i class="fas fa-sign-in-alt"></i> Go to Login
        </a>
    </div>
</body>
</html>
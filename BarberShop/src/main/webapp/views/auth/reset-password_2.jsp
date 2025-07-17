<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Reset Password</title>
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
        .reset-container {
            background: rgba(255, 245, 230, 0.95);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            max-width: 400px;
            width: 100%;
            border: 1px solid #d4a373;
        }
        h2, h3 {
            color: #333;
        }
        .input-group-text {
            background: #d4a373;
            color: #fff;
        }
        .form-control {
            border: 1px solid #d4a373;
            background: #fff;
        }
        .btn-primary {
            background: #d4a373;
            border: none;
            transition: background 0.3s ease;
        }
        .btn-primary:hover {
            background: #b8860b;
        }
        .text-danger {
            color: #ff6f61 !important;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="reset-container text-center">
        <h3><i class="fa fa-lock fa-3x text-primary"></i></h3>
        <h2 class="my-3">Reset Password</h2>
        <% if (request.getAttribute("message") != null) { %>
            <p class="text-danger"><%= request.getAttribute("message") %></p>
        <% } %>
        <form action="change-password" method="post" onsubmit="return validatePassword()">
            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" id="password" class="form-control" name="password" placeholder="New Password" required>
                </div>
            </div>
            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" required>
                </div>
            </div>
            <p id="error-message" class="text-danger" style="display: none;">Passwords do not match!</p>
            <button type="submit" class="btn btn-primary w-100">Reset Password</button>
        </form>
    </div>

    <script>
        function validatePassword() {
            let password = document.getElementById("password").value;
            let confirmPassword = document.getElementById("confirmPassword").value;
            let errorMessage = document.getElementById("error-message");
            
            if (password !== confirmPassword) {
                errorMessage.style.display = "block";
                return false;
            }
            errorMessage.style.display = "none";
            return true;
        }
    </script>
</body>
</html>
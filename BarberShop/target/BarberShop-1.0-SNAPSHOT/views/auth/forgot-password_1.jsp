<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
        .forgot-container {
            background: rgba(255, 245, 230, 0.95); /* Màu trắng ngà với opacity */
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            max-width: 400px;
            width: 100%;
            border: 1px solid #d4a373; /* Viền vàng nhạt */
        }
        h2, h3 {
            color: #333;
        }
        .input-group-text {
            background: #d4a373; /* Màu vàng nhạt */
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
            background: #b8860b; /* Vàng đậm hơn khi hover */
        }
        .btn-danger {
            background: #8b4513; /* Màu nâu gỗ */
            border: none;
            transition: background 0.3s ease;
        }
        .btn-danger:hover {
            background: #6b3a0d; /* Nâu đậm hơn khi hover */
        }
        p[style="color: red"] {
            color: #ff6f61 !important; /* Màu đỏ san hô nhẹ */
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="forgot-container text-center">
        <h3><i class="fa fa-envelope fa-3x text-primary"></i></h3>
        <h2 class="my-3">Forgot Password?</h2>
        <p style="color: red"><%= request.getAttribute("message")!=null ? (request.getAttribute("message")) : "Enter your email to receive an OTP"%></p>
        <form action="${pageContext.request.contextPath}/send-otp" method="post" onsubmit="disableButton()">
            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                    <input type="email" class="form-control" name="email" placeholder="Enter your email" required>
                </div>
            </div>
            <button id="send-otp-btn" type="submit" class="btn btn-primary w-100">Send OTP</button>
        </form>
        <div class="mt-3">
            <button class="btn btn-danger w-100" onclick="window.location.href = '${pageContext.request.contextPath}/views/common/home.jsp'">Back to Home</button>
        </div>
    </div>
    <script>
        function disableButton() {
            let btn = document.getElementById("send-otp-btn");
            btn.innerHTML = "Sending...";
            btn.disabled = true;
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
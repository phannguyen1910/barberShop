<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Successful</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        .card {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            display: inline-block;
            max-width: 500px;
        }
        .success-icon {
            font-size: 60px;
            color: #2ecc71;
        }
        h2 {
            color: #333;
        }
        p {
            color: #666;
            font-size: 16px;
        }
        a {
            text-decoration: none;
            color: #3498db;
            display: inline-block;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="card">
        <div class="success-icon">✔</div>
        <h2>Payment Successful!</h2>
        <p>Your payment has been processed successfully.</p>
        <p>Thank you for using our service.</p>
        <a href="views/common/home.jsp">← Trở về trang chủ </a>
    </div>
</body>
</html>

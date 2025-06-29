<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kết quả thanh toán</title>
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
        .icon {
            font-size: 60px;
            margin-bottom: 20px;
        }
        .success {
            color: #2ecc71;
        }
        .fail {
            color: #e74c3c;
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
    <c:choose>
        <c:when test="${transResult == true}">
            <div class="icon success">✔</div>
            <h2>Thanh toán thành công!</h2>
            <p>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi.</p>
            <a href="views/common/home.jsp">← Trở về trang chủ</a>
        </c:when>
        <c:otherwise>
            <div class="icon fail">✖</div>
            <h2>Thanh toán thất bại!</h2>
            <p>Đã xảy ra lỗi trong quá trình xử lý. Vui lòng thử lại sau.</p>
            <a href="views/common/home.jsp">← Quay lại trang chủ</a>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>

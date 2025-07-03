<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile - Cut&Styles Barber</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/html.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        /* Giữ nguyên style của bạn */
    </style>
</head>
<body>
    <jsp:include page="/views/common/navbar.jsp"/>

    <div class="container mt-5">
        <h2 class="section-title text-center mb-4">Chỉnh sửa thông tin cá nhân</h2>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <div class="service-card shadow-sm">
            <div class="service-info">
                <form action="${pageContext.request.contextPath}/EditProfileServlet" method="post">
                    <div class="mb-3">
                        <label for="firstName" class="form-label">Tên</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" value="${sessionScope.firstName}" required>
                    </div>
                    <div class="mb-3">
                        <label for="lastName" class="form-label">Họ</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" value="${sessionScope.lastName}" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="${sessionScope.email}" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="phoneNumber" class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${sessionScope.phoneNumber}">
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                        <a href="${pageContext.request.contextPath}/views/customer/profile.jsp" class="btn btn-secondary">Hủy</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer class="footer">
        <!-- Giữ nguyên footer của bạn -->
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
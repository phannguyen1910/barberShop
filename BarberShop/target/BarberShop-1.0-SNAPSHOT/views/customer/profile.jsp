<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile - Cut&Styles Barber</title>
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
        <h2 class="section-title">Thông tin cá nhân</h2>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <div class="service-card shadow-sm">
            <div class="service-info">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="form-label mb-0">Thông tin cá nhân</h5>
                    <a href="${pageContext.request.contextPath}/views/customer/editProfile.jsp" class="btn btn-primary">
                        <i class="fa fa-edit"></i> Chỉnh sửa thông tin
                    </a>
                </div>
                <div class="table-responsive">
                    <table class="table table-borderless">
                        <tbody>
                            <tr>
                                <td class="fw-bold" style="width: 150px;">Họ:</td>
                                <td>${sessionScope.lastName}</td>
                            </tr>
                            <tr>
                                <td class="fw-bold">Tên:</td>
                                <td>${sessionScope.firstName}</td>
                            </tr>
                            <tr>
                                <td class="fw-bold">Email:</td>
                                <td>${sessionScope.email}</td>
                            </tr>
                            <tr>
                                <td class="fw-bold">Số điện thoại:</td>
                                <td>${sessionScope.phoneNumber}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <!-- Giữ nguyên footer của bạn -->
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
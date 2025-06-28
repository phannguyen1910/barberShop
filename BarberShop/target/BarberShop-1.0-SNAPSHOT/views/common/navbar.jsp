<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cut&Styles Barber</title>
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-expand-lg custom-navbar border-bottom shadow-sm">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Logo" width="55" height="55" class="me-2">
            Cut&Styles Barber
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-between" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/views/common/home.jsp">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/views/common/franchise.jsp">Nhượng quyền</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/BookingServlet">Đặt lịch</a>
                </li>

                <!-- Hiển thị Dashboard cho Admin và Staff -->
                <c:if test="${sessionScope.account != null}">
                    <c:choose>
                        <c:when test="${sessionScope.account.role == 'admin'}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/adminDashboard">Dashboard Admin</a>
                            </li>
                        </c:when>
                        <c:when test="${sessionScope.account.role == 'staff'}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/staffDashboard">Dashboard Staff</a>
                            </li>
                        </c:when>
                    </c:choose>
                </c:if>
            </ul>

            <!-- Hiển thị nút login và register nếu chưa đăng nhập -->
            <div class="d-flex gap-2 align-items-center">
                <c:if test="${sessionScope.account == null}">
                    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
                    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/views/auth/register.jsp">Đăng ký</a>
                </c:if>

                <!-- Hiển thị avatar và dropdown menu nếu đã đăng nhập -->
                <c:if test="${sessionScope.account != null}">
                    <span class="me-3" style="color: #FF9900"> Xin chào, <strong>${sessionScope.customer.lastName} ${sessionScope.customer.firstName}</strong></span>
                    <div class="dropdown">
                        <a class="dropdown-toggle d-flex align-items-center" href="#" role="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <div style="width: 40px; height: 40px; background-color: #FF9900; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 18px; font-weight: bold;">
                                ${fn:substring(sessionScope.customer.firstName, 0, 1)}
                            </div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Profile</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                        </ul>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<!-- Bootstrap 5.3.3 JavaScript (includes Popper.js) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
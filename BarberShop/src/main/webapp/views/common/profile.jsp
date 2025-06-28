<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    if (session.getAttribute("firstName") == null || session.getAttribute("account") == null) {
        response.sendRedirect(request.getContextPath() + "/profile");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile - Cut&Styles Barber</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/profile.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>
    <jsp:include page="/views/common/navbar.jsp"/>
    <div class="container mt-5">
        <h2 class="section-title">Thông tin cá nhân</h2>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>
       
        <div class="service-card shadow-sm">
            <div class="service-info">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <a href="${pageContext.request.contextPath}/views/common/editProfile.jsp" class="btn btn-primary">
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
                            <!-- ✅ SỬA: Kiểm tra role chính xác (có thể là 'Staff' hoặc 'staff') -->
                            <c:if test="${sessionScope.account.role == 'Staff' || sessionScope.account.role == 'staff'}">
                                <tr>
                                    <td class="fw-bold">Ảnh:</td>
                                    <td>
                                        <c:if test="${not empty sessionScope.img}">
                                            <img src="${pageContext.request.contextPath}/${sessionScope.img}" alt="Staff Image" width="100">
                                        </c:if>
                                        <c:if test="${empty sessionScope.img}">
                                            Không có ảnh
                                        </c:if>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
                                             
<footer class="footer">
    <div class="container">
        <div class="row">
            <!-- Logo and About -->
            <div class="col-lg-4 col-md-6 footer-col">
                <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Cut&Styles Logo" class="footer-logo">                      
            </div>

            <!-- Links -->
            <div class="col-lg-4 col-md-6 footer-col">
                <h4 class="footer-title">Liên kết nhanh</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/common/franchise.jsp">Liên hệ nhượng quyền</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/commit/details.jsp">Chính sách cam kết</a></li>
                </ul>
            </div>

            <!-- Contact -->
            <div class="col-lg-4 col-md-6 footer-col">
                <h4 class="footer-title">Thông tin liên hệ</h4>
                <div class="footer-contact">
                    <p><i class="bi bi-geo-alt-fill"></i> <span>Khu đô thị FPT city, Hòa Hải, Ngũ Hành Sơn, Đà Nẵng</span></p>
                    <p><i class="bi bi-telephone-fill"></i> <span>Liên hệ học nghề tóc: 0774511941</span></p>
                    <p><i class="bi bi-clock-fill"></i> <span>Giờ phục vụ: Thứ 2 đến Chủ Nhật, 8h30 - 20h30</span></p>
                </div>
            </div>
        </div>

        <!-- Footer bottom -->
        <div class="row footer-bottom">
            <div  class="col-12 text-center">
                <p>&copy; 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
            </div>
        </div>
    </div>
</footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
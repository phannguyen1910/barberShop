<%-- 
    Document   : cutHairService
    Created on : May 16, 2025, 11:07:31 AM
    Author     : LENOVO
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dịch Vụ Cắt Tóc - Cut&Styles</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/cutHairService.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@ include file="/views/common/navbar.jsp" %>
    <!-- Service Section -->
    <section class="service-section">
        <div class="container py-5">
            <h2 class="text-center mb-4">Dịch Vụ Cắt Tóc</h2>
            <div class="row g-4">
                <c:forEach var="service" items="${cutHairServices}">
                    <div class="col-md-6 col-lg-4">
                        <div class="service-card h-100">
                            <div class="service-header">
                                <h3>${service.name}</h3>
                                <div class="service-details">
                                    <p>${service.description}</p>
                                </div>
                            </div>
                            <div class="service-images">
                                <div class="main-image">
                                    <img src="${pageContext.request.contextPath}/image/${service.image}" alt="${service.name}" class="img-fluid rounded">
                                </div>
                                <div class="sub-images">
                                    <!-- Nếu có nhiều hình ảnh, tách chuỗi image (giả sử lưu dưới dạng "img1,img2") -->
                                    <c:forEach var="img" items="${fn:split(service.image, ',')}" varStatus="status">
                                        <c:if test="${status.index < 2}">
                                            <img src="${pageContext.request.contextPath}/image/${img}" alt="${service.name}" class="img-fluid rounded">
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="service-footer">
                                <div class="time">
                                    <span class="duration">${service.duration} Phút</span>
                                    <span class="price"><fmt:formatNumber value="${service.price}" type="currency" currencySymbol="VNĐ"/></span>
                                </div>
                                <a href="${pageContext.request.contextPath}/ViewServiceByIdServlet?id=${service.id}" class="more-info">Tìm hiểu thêm <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty cutHairServices}">
                    <div class="col-12 text-center">
                        <p>Chưa có dịch vụ cắt tóc nào.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Booking CTA Section -->
    <div class="booking-cta py-5 text-center">
        <a href="${pageContext.request.contextPath}/views/booking/booking.jsp" class="btn btn-primary btn-lg">Đặt lịch ngay</a>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6 footer-col">
                    <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Cut&Styles Logo" class="footer-logo">
                </div>
                <div class="col-lg-4 col-md-6 footer-col">
                    <h4 class="footer-title">Liên kết nhanh</h4>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a></li>
                        <li><a href="${pageContext.request.contextPath}/views/common/franchise.jsp">Liên hệ nhượng quyền</a></li>
                        <li><a href="${pageContext.request.contextPath}/views/commit/details.jsp">Chính sách cam kết</a></li>
                    </ul>
                </div>
                <div class="col-lg-4 col-md-6 footer-col">
                    <h4 class="footer-title">Thông tin liên hệ</h4>
                    <div class="footer-contact">
                        <p><i class="bi bi-geo-alt-fill"></i> <span>Khu đô thị FPT city, Hòa Hải, Ngũ Hành Sơn, Đà Nẵng</span></p>
                        <p><i class="bi bi-telephone-fill"></i> <span>Liên hệ học nghề tóc: 0774511941</span></p>
                        <p><i class="bi bi-clock-fill"></i> <span>Giờ phục vụ: Thứ 2 đến Chủ Nhật, 8h30 - 20h30</span></p>
                    </div>
                </div>
            </div>
            <div class="row footer-bottom">
                <div class="col-12 text-center">
                    <p>&copy; 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
                </div>
            </div>
        </div>
    </footer>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
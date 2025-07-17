<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <title>Combo Gội Thư Giãn Cổ Vai Gáy</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/spa2.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="/views/common/navbar.jsp" %>

        <div class="container py-5">
            <h1 class="combo-title text-center mb-4">COMBO GỘI CHĂM SÓC DA CHUYÊN SÂU</h1>
            <div class="mb-5">
                <img src="${pageContext.request.contextPath}/image/spa2/banner.png" class="img-fluid rounded shadow-lg" alt="Combo Banner">
            </div>

            <!-- Quy trình dịch vụ section -->
            <section class="process-section">
                <h2 class="section-title text-center mb-5">Quy trình dịch vụ</h2>
                <p class="text-center text-muted mb-5">Dịch vụ được yêu thích nhất bao gồm Gội - Thư giãn</p>
                <div class="process-grid">
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa2/1.png" class="process-img" alt="Tẩy trang & Rửa mặt sạch">
                        <p>Tẩy trang & Rửa mặt sạch</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa2/2.png" class="process-img" alt="Thư giãn vùng đầu">
                        <p>Thư giãn vùng đầu</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa2/3.png" class="process-img" alt="Chăm sóc da mặt nâng cơ">
                        <p>Chăm sóc da mặt nâng cơ</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa2/4.png" class="process-img" alt="Đắp mặt nạ & chiếu sáng sinh học">
                        <p>Đắp mặt nạ & chiếu sáng sinh học</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa2/5.png" class="process-img" alt="Tẩy da chết">
                        <p>Tẩy da chết</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa2/6.png" class="process-img" alt="Điện di tinh chất & Bôi kem chống nắng">
                        <p>Điện di tinh chất & Bôi kem chống nắng</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa2/7.png" class="process-img" alt="Gội đầu sạch gàu">
                        <p>Gội đầu sạch gàu</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa2/8.png" class="process-img" alt="Rửa tai bọt & Ngoáy tai">
                        <p>Rửa tai bọt & Ngoáy tai</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa2/9.png" class="process-img" alt="Thư giãn cổ vai gáy & tay">
                        <p>Thư giãn cổ vai gáy & tay</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa2/10.png" class="process-img" alt="Đấm lưng">
                        <p>Đấm lưng</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa2/11.png" class="process-img" alt="Sấy tóc">
                        <p>Sấy tóc</p>
                    </div>
                </div>
            </section>
        </div>

        <!-- Booking CTA Section -->
        <div class="booking-cta py-5 text-center">
            <a href="${pageContext.request.contextPath}/views/booking/booking.jsp" class="btn btn-primary btn-lg">Đặt lịch ngay</a>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="row">
                    <!-- Logo and About -->
                    <div class="col-lg-4 col-md-6 footer-col">
                        <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Cut&Styles Logo" class="footer-logo mb-3">
                        <p class="text-muted">Chăm sóc tóc và thư giãn chuyên nghiệp tại Cut & Styles.</p>
                    </div>

                    <!-- Links -->
                    <div class="col-lg-4 col-md-6 footer-col">
                        <h4 class="footer-title">Liên kết nhanh</h4>
                        <ul class="footer-links">
                            <li><a href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/common/franchise.jsp">Liên hệ nhượng quyền</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/commit/support.jsp">Chính sách cam kết</a></li>
                        </ul> 
                    </div>

                    <!-- Contact -->
                    <div class="col-lg-4 col-md-6 footer-col">
                        <h4 class="footer-title">Thông tin liên hệ</h4>
                        <div class="footer-contact">
                            <p><i class="bi bi-geo-alt-fill"></i> Khu đô thị FPT city, Hòa Hải, Ngũ Hành Sơn, Đà Nẵng</p>
                            <p><i class="bi bi-telephone-fill"></i> Liên hệ học nghề tóc: 0774511941</p>
                            <p><i class="bi bi-clock-fill"></i> Giờ phục vụ: 8h30 - 20h30, Thứ 2 - Chủ Nhật</p>
                        </div>
                    </div>
                </div>
                <div class="row footer-bottom">
                    <div class="col-12 text-center">
                        <p class="mb-0">&copy; 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
                        <div class="social-icons mt-3">
                            <a href="#"><i class="fab fa-facebook-f"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
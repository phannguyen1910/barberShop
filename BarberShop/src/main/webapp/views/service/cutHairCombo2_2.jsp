<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Combo Cắt Gội Dưỡng Sinh</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/combo2.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <body>
    <%@ include file="/views/common/navbar.jsp" %>

        <div class="container text-center py-4">
            <h2 class="combo-title">COMBO CẮT GỘI THƯ GIÃN CỔ VAI GÁY</h2>

            <!-- Banner image below title -->
            <div class="mb-4">
                <img src="${pageContext.request.contextPath}/image/combo2/banner.png" class="img-fluid rounded shadow" alt="Combo Banner">
            </div>

            <!-- Combo banner with two images -->


            <!-- Quy trình dịch vụ section -->
            <div class="text-start mt-5">
                <h4 class="section-title text-uppercase mb-3 fw-bolder" style="color: #201E15;">Quy trình dịch vụ</h4>
                <p class="text-muted mb-4 fw-bold" style="color: #201E15;">Dịch vụ được yêu thích nhất bao gồm Cắt - Gội - Thư giãn</p>
                <div class="process-grid">
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/combo2/1.png" class="img-fluid process-img shadow-sm mb-2" alt="Tác động sâu vùng cơ">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Tác động sâu vùng cơ</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/combo2/2.png" class="img-fluid process-img shadow-sm mb-2" alt="Thư giãn vùng đầu">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Thư giãn vùng đầu</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/combo2/3.png" class="img-fluid process-img shadow-sm mb-2" alt="Rửa mặt & chăm sóc da mặt">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Rửa mặt & chăm sóc da mặt</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/combo2/4.png" class="img-fluid process-img shadow-sm mb-2" alt="Hút mụn & Phun nước hoa hồng">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Hút mụn & Phun nước hoa hồng</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/combo2/5.png" class="img-fluid process-img shadow-sm mb-2" alt="Tẩy da chết & đắp mặt nạ">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Tẩy da chết & đắp mặt nạ</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/combo2/6.png" class="img-fluid process-img shadow-sm mb-2" alt="Thư giãn cổ vai gáy">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Thư giãn cổ vai gáy</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/combo2/7.png" class="img-fluid process-img shadow-sm mb-2" alt="Rửa tai & thư giãn tai">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Rửa tai & thư giãn tai</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/combo2/8.png" class="img-fluid process-img shadow-sm mb-2" alt="Xối nước thác đổ">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Xối nước thác đổ</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/combo2/9.png" class="img-fluid process-img shadow-sm mb-2" alt="Cắt tóc">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Cắt tóc</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/combo2/10.png" class="img-fluid process-img shadow-sm mb-2" alt="Sấy tóc">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Sấy tóc</p>
                    </div>
                </div>
            </div>
        </div>

        <section class="booking-cta">
            <div class="container py-5 text-center">
                <h2>Sẵn sàng để trải nghiệm dịch vụ của chúng tôi?</h2>
                <p class="lead mb-4">Đặt lịch ngay hôm nay để nhận ưu đãi đặc biệt cho lần đầu sử dụng dịch vụ</p>
                <a href="${pageContext.request.contextPath}/views/booking/booking.jsp" class="btn btn-primary btn-lg">Đặt lịch ngay</a>
            </div>
        </section>
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
                            <li><a href="${pageContext.request.contextPath}/views/commit/support.jsp">Chính sách cam kết</a></li>
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
                    <div class="col-12 text-center">
                        <p>© 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
                    </div>
                </div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
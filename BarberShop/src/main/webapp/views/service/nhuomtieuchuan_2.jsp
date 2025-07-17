<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <title>Uốn Tóc - Basic & Cao Cấp</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/nhuomtieuchuan.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .service-item p, .kperm-item p {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px; /* Consistent gap between name and price */
            }
        </style>
    </head>
    <body>
        <%@ include file="/views/common/navbar.jsp" %>

        <div class="container text-center py-4">
            <h2 class="combo-title">NHUỘM MÀU TIÊU CHUẨN</h2>

            <!-- Banner image below title -->
            <div class="mb-4">
                <img src="${pageContext.request.contextPath}/image/nhuomtieuchuan/banner.jpg" class="img-fluid rounded shadow" alt="Uốn Tóc Banner">
            </div>

            <!-- Service description section -->
            <div class="text-start mt-5">
                <h4 class="section-title text-uppercase mb-3 fw-bolder" style="color: #201E15;">Nhuộm công sở</h4>
                <p class="text-muted mb-4 fw-bold" style="color: #201E15;">Nhuộm tóc phong cách đơn giản, nhẹ nhàng và tinh tế</p>
                <div class="row row-cols-2 row-cols-md-4 g-4">
                    <div class="col">
                        <div class="service-item text-center">
                            <img src="${pageContext.request.contextPath}/image/nhuomtieuchuan/1.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Ánh cam">
                            <p class="mb-0 fw-bold" style="color: #000000;">Ánh cam</p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="service-item text-center">
                            <img src="${pageContext.request.contextPath}/image/nhuomtieuchuan/2.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Ánh cam">
                            <p class="mb-0 fw-bold" style="color: #000000;">Ánh cam</p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="service-item text-center">
                            <img src="${pageContext.request.contextPath}/image/nhuomtieuchuan/3.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Nâu">
                            <p class="mb-0 fw-bold" style="color: #000000;">Nâu</p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="service-item text-center">
                            <img src="${pageContext.request.contextPath}/image/nhuomtieuchuan/4.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Đỏ">
                            <p class="mb-0 fw-bold" style="color: #000000;">Đỏ</p>
                        </div>
                    </div>
                </div>
                <div class="pricing mt-4 d-none"></div> <!-- Hidden to avoid duplication -->
            </div>

            <!-- Nhuộm thời trang section -->
            <div class="text-start mt-5">
                <h4 class="section-title text-uppercase mb-3 fw-bolder" style="color: #201E15;">NHUỘM THỜI TRANG</h4>
                <p class="text-muted mb-4 fw-bold" style="color: #201E15;">Đa dạng phong cách, phù hợp với mọi khuôn mặt</p>
                <div class="row row-cols-2 row-cols-md-5 g-4">
                    <div class="col">
                        <div class="service-item text-center">
                            <img src="${pageContext.request.contextPath}/image/nhuomtieuchuan/5.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Hồng">
                            <p class="mb-0 fw-bold" style="color: #000000;">Hồng</p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="service-item text-center">
                            <img src="${pageContext.request.contextPath}/image/nhuomtieuchuan/6.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Tím">
                            <p class="mb-0 fw-bold" style="color: #000000;">Tím</p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="service-item text-center">
                            <img src="${pageContext.request.contextPath}/image/nhuomtieuchuan/7.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Cam">
                            <p class="mb-0 fw-bold" style="color: #000000;">Cam</p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="service-item text-center">
                            <img src="${pageContext.request.contextPath}/image/nhuomtieuchuan/8.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Nâu khói">
                            <p class="mb-0 fw-bold" style="color: #000000;">Nâu khói</p>
                        </div>
                    </div>
                </div>
                <div class="pricing mt-4 d-none"></div> <!-- Hidden to avoid duplication -->
            </div>

            <!-- Quy trình dịch vụ section -->
            <div class="text-start mt-5">
                <h4 class="section-title text-uppercase mb-3 fw-bolder" style="color: #201E15;">QUY TRÌNH DỊCH VỤ</h4>
                <p class="text-muted mb-4 fw-bold" style="color: #201E15;">Dịch vụ nhuộm tiêu chuẩn dùng cho những trường hợp tóc chắc khỏe, không khuyết điểm.</p>
                <div class="row row-cols-2 row-cols-md-4 g-4">
                    <div class="col">
                        <div class="process-item text-center">
                            <img src="${pageContext.request.contextPath}/image/nhuomtieuchuan/9.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Kiểm tra & đánh giá chất tóc">
                            <p class="mb-0 fw-bold" style="color: #000000;">Kiểm tra & đánh giá chất tóc</p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="process-item text-center">
                            <img src="${pageContext.request.contextPath}/image/nhuomtieuchuan/10.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Nhuộm màu">
                            <p class="mb-0 fw-bold" style="color: #000000;">Nhuộm màu</p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="process-item text-center">
                            <img src="${pageContext.request.contextPath}/image/nhuomtieuchuan/11.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Xả tóc">
                            <p class="mb-0 fw-bold" style="color: #000000;">Xả tóc</p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="process-item text-center">
                            <img src="${pageContext.request.contextPath}/image/nhuomtieuchuan/12.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Sấy vuốt tạo kiểu">
                            <p class="mb-0 fw-bold" style="color: #000000;">Sấy vuốt tạo kiểu</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Booking CTA Section -->
        <section class="booking-cta">
            <div class="container py-5 text-center">
                <h2>Sẵn sàng để trải nghiệm dịch vụ của chúng tôi?</h2>
                <p class="lead mb-4">Đặt lịch ngay hôm nay để nhận ưu đãi đặc biệt cho lần đầu sử dụng dịch vụ</p>
                <a href="${pageContext.request.contextPath}/views/booking/booking.jsp" class="btn btn-primary btn-lg">Đặt lịch ngay</a>
            </div>
        </section>

        <!-- Footer -->
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

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
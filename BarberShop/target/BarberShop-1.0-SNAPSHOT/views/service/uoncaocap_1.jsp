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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/uontieuchuan.css">
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
            <h2 class="combo-title">DỊCH VỤ UỐN TÓC - BASIC & CAO CẤP</h2>

            <!-- Banner image below title -->
            <div class="mb-4">
                <img src="${pageContext.request.contextPath}/image/uontieuchuan/banner.jpg" class="img-fluid rounded shadow" alt="Uốn Tóc Banner">
            </div>

            <!-- Service description section -->
            <div class="text-start mt-5">
                <h4 class="section-title text-uppercase mb-3 fw-bolder" style="color: #201E15;">Dịch vụ uốn tóc</h4>
                <p class="text-muted mb-4 fw-bold" style="color: #201E15;">Tóc uốn phong cách đơn giản, nhẹ nhàng và tinh tế</p>
                <div class="row row-cols-2 row-cols-md-4 g-4">
                    <div class="col">
                        <div class="service-item text-center">
                            <img src="${pageContext.request.contextPath}/image/uontieuchuan/basic.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Uốn Basic">
                            <p class="mb-0 fw-bold" style="color: #000000;">Uốn Basic<span style="color: #8B4513;"> 379,000 VND</span></p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="service-item text-center">
                            <img src="${pageContext.request.contextPath}/image/uontieuchuan/caocap.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Uốn Cao Cấp">
                            <p class="mb-0 fw-bold" style="color: #000000;">Uốn Cao Cấp<span style="color: #8B4513;"> 449,000 VND</span></p>
                        </div>
                    </div>
                </div>
                <div class="pricing mt-4 d-none"></div> <!-- Hidden to avoid duplication -->
            </div>

            <!-- Uốn Định Hình K-Perm section -->
            <div class="text-start mt-5">
                <h4 class="section-title text-uppercase mb-3 fw-bolder" style="color: #201E15;">Uốn định hình K-Perm</h4>
                <p class="text-muted mb-4 fw-bold" style="color: #201E15;">Đa dạng phong cách, phù hợp với mọi khuôn mặt</p>
                <div class="row row-cols-2 row-cols-md-5 g-4">
                    <div class="col">
                        <div class="kperm-item text-center">
                            <img src="${pageContext.request.contextPath}/image/uontieuchuan/fit.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Fit Perm">
                            <p class="mb-0 fw-bold" style="color: #000000;">Fit Perm<span style="color: #8B4513;"> 418,000 VND</span></p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="kperm-item text-center">
                            <img src="${pageContext.request.contextPath}/image/uontieuchuan/kid.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Kid Perm">
                            <p class="mb-0 fw-bold" style="color: #000000;">Kid Perm<span style="color: #8B4513;"> 348,000 VND</span></p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="kperm-item text-center">
                            <img src="${pageContext.request.contextPath}/image/uontieuchuan/roof.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Roof Perm">
                            <p class="mb-0 fw-bold" style="color: #000000;">Roof Perm<span style="color: #8B4513;"> 478,000 VND</span></p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="kperm-item text-center">
                            <img src="${pageContext.request.contextPath}/image/uontieuchuan/tailor.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Tailor Perm">
                            <p class="mb-0 fw-bold" style="color: #000000;">Tailor Perm<span style="color: #8B4513;"> 478,000 VND</span></p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="kperm-item text-center">
                            <img src="${pageContext.request.contextPath}/image/uontieuchuan/grass.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Grass Perm">
                            <p class="mb-0 fw-bold" style="color: #000000;">Grass Perm<span style="color: #8B4513;"> 478,000 VND</span></p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="kperm-item text-center">
                            <img src="${pageContext.request.contextPath}/image/uontieuchuan/wool.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Wool Perm">
                            <p class="mb-0 fw-bold" style="color: #000000;">Wool Perm<span style="color: #8B4513;"> 450,000 VND</span></p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="kperm-item text-center">
                            <img src="${pageContext.request.contextPath}/image/uontieuchuan/ruffled.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Ruffled Perm">
                            <p class="mb-0 fw-bold" style="color: #000000;">Ruffled Perm<span style="color: #8B4513;"> 460,000 VND</span></p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="kperm-item text-center">
                            <img src="${pageContext.request.contextPath}/image/uontieuchuan/timothy.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Timothy Perm">
                            <p class="mb-0 fw-bold" style="color: #000000;">Timothy Perm<span style="color: #8B4513;"> 470,000 VND</span></p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="kperm-item text-center">
                            <img src="${pageContext.request.contextPath}/image/uontieuchuan/consau.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Con Sâu Perm">
                            <p class="mb-0 fw-bold" style="color: #000000;">Con Sâu Perm<span style="color: #8B4513;"> 599,000 VND</span></p>
                        </div>
                    </div>
                    <div class="col">
                        <div class="kperm-item text-center">
                            <img src="${pageContext.request.contextPath}/image/uontieuchuan/premlock.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Premlock Perm">
                            <p class="mb-0 fw-bold" style="color: #000000;">Premlock Perm<span style="color: #8B4513;"> 899,000 VND</span></p>
                        </div>
                    </div>
                </div>

                <!-- Quy Trình Dịch Vụ Section -->
                <div class="text-start mt-5">
                    <h4 class="section-title text-uppercase mb-3 fw-bolder" style="color: #201E15;">Quy trình dịch vụ</h4>
                    <p class="text-muted mb-4 fw-bold" style="color: #201E15;">
                        Sử dụng thuốc uốn ATS cao cấp, bổ sung thành phần chất phục hồi tóc. Thương được được các KOLs, Celeb tin dùng.
                    </p>
                    <div class="row row-cols-2 row-cols-md-4 g-4">
                        <div class="col">
                            <div class="process-item text-center">
                                <img src="${pageContext.request.contextPath}/image/uoncaocap/1.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Kiểm tra & đánh giá chất tóc">
                                <p class="mb-0 fw-bold" style="color: #000000;">Kiểm tra & đánh giá chất tóc</p>
                            </div>
                        </div>
                        <div class="col">
                            <div class="process-item text-center">
                                <img src="${pageContext.request.contextPath}/image/uontieuchuan/2.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Lượn tóc">
                                <p class="mb-0 fw-bold" style="color: #000000;">Lượn tóc</p>
                            </div>
                        </div>
                        <div class="col">
                            <div class="process-item text-center">
                                <img src="${pageContext.request.contextPath}/image/uontieuchuan/3.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Định hình nếp tóc">
                                <p class="mb-0 fw-bold" style="color: #000000;">Định hình nếp tóc</p>
                            </div>
                        </div>
                        <div class="col">
                            <div class="process-item text-center">
                                <img src="${pageContext.request.contextPath}/image/uontieuchuan/4.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Xả tóc">
                                <p class="mb-0 fw-bold" style="color: #000000;">Xả tóc</p>
                            </div>
                        </div>
                        <div class="col">
                            <div class="process-item text-center">
                                <img src="${pageContext.request.contextPath}/image/uoncaocap/5.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Duỗi">
                                <p class="mb-0 fw-bold" style="color: #000000;">Duỗi</p>
                            </div>
                        </div>
                        <div class="col">
                            <div class="process-item text-center">
                                <img src="${pageContext.request.contextPath}/image/uoncaocap/6.jpg" class="img-fluid rounded shadow-sm mb-2" alt="Sấy vuốt tạo kiểu">
                                <p class="mb-0 fw-bold" style="color: #000000;">Sấy vuốt tạo kiểu</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="pricing mt-4 d-none"></div> <!-- Hidden to avoid duplication -->
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
                        <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.jpg" alt="Cut&Styles Logo" class="footer-logo">
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
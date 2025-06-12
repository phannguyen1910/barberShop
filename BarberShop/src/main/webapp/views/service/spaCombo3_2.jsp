<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <title>Combo Cắt Gội Dưỡng Sinh</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/combo1.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="/views/common/navbar.jsp" %>

        <div class="container text-center py-4">
            <h2 class="combo-title">COMBO CẮT GỘI DƯỠNG SINH ĐÁ NÓNG HIMALAYA</h2>

            <!-- Banner image below title -->
            <div class="mb-4">
                <img src="${pageContext.request.contextPath}/image/spa3/banner.png" class="img-fluid rounded shadow" alt="Combo Banner">
            </div>

            <!-- Quy trình dịch vụ section -->
            <div class="text-start mt-5">
                <h4 class="section-title text-uppercase mb-3 fw-bolder" style="color: #201E15;">Quy trình dịch vụ</h4>
                <p class="text-muted mb-4 fw-bold" style="color: #201E15;">Dịch vụ được yêu thích nhất bao gồm Cắt - Gội - Thư giãn</p>
                <div class="process-grid">
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa3/1.png" class="img-fluid process-img shadow-sm mb-2" alt="Thư giãn đá nóng">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Thư giãn đá nóng</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa3/2.png" class="img-fluid process-img shadow-sm mb-2" alt="Quấn đai nóng">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Quấn đai nóng</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa3/3.png" class="img-fluid process-img shadow-sm mb-2" alt="Thư giãn da mặt">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Thư giãn da mặt</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa3/4.png" class="img-fluid process-img shadow-sm mb-2" alt="Rửa mặt">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Rửa mặt</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa3/5.png" class="img-fluid process-img shadow-sm mb-2" alt="Chăm sóc da mặt">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Chăm sóc da mặt</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa3/6.png" class="img-fluid process-img shadow-sm mb-2" alt="Hút mụn">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Hút mụn</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa3/7.png" class="img-fluid process-img shadow-sm mb-2" alt="Phun hoa hồng">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Phun hoa hồng</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa3/8.png" class="img-fluid process-img shadow-sm mb-2" alt="Gội đầu">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Gội đầu</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa3/9.png" class="img-fluid process-img shadow-sm mb-2" alt="Thư giãn vùng đầu">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Thư giãn vùng đầu</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa3/10.png" class="img-fluid process-img shadow-sm mb-2" alt="Rửa tai & Ngoáy tai">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Rửa tai & Ngoáy tai</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa3/11.png" class="img-fluid process-img shadow-sm mb-2" alt="Xối nước thác đổ">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Xối nước thác đổ</p>
                    </div>
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa3/12.png" class="img-fluid process-img shadow-sm mb-2" alt="Thư giãn tay">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Thư giãn tay</p>
                    </div>                                    
                    <div class="process-item">
                        <img src="${pageContext.request.contextPath}/image/spa3/13.png" class="img-fluid process-img shadow-sm mb-2" alt="Sấy tóc">
                        <p class="mb-0 fw-bold" style="color: #201E15;">Sấy tóc</p>
                    </div>                
                </div>
            </div>
        </div>

        <!-- Fixed buttons for scroll to top and call -->
        <div class="fixed-buttons">
            <a href="#" class="btn btn-primary rounded-circle shadow mb-2"><i class="bi bi-chevron-up"></i></a>
            <a href="tel:0123456789" class="btn btn-primary rounded-circle shadow"><i class="bi bi-telephone"></i></a>
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
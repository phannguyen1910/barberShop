<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/raytai.css">
        <title>Combo Cắt Gội Dưỡng Sinh</title>
    </head>
    <body>
        <!-- Navbar -->
        <%@ include file="/views/common/navbar.jsp" %>

        <!-- Main Content -->
        <div class="container py-5">
            <h1 class="combo-title text-center mb-5">LẤY RÁY TAI HOÀNG CUNG</h1>

            <!-- Banner -->
            <div class="banner-section mb-5">
                <img src="${pageContext.request.contextPath}/image/raytai/banner.jpg" class="img-fluid rounded-3 shadow-lg banner-img mx-auto" alt="Combo Banner">
            </div>

            <!-- Process Section -->
            <section class="process-section mb-5">
                <h4 class="section-title text-uppercase mb-4">Quy trình dịch vụ</h4>
                <p class="text-muted mb-4 fs-5">Dịch vụ được yêu thích nhất bao gồm Cắt - Gội - Thư giãn</p>
                <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
                    <div class="col">
                        <div class="process-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/1.jpg" class="card-img-top rounded-top" alt="Làm sạch dụng cụ">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Làm sạch dụng cụ</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="process-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/2.jpg" class="card-img-top rounded-top" alt="Đắp khăn nóng & thư giãn vùng đầu">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Đắp khăn nóng & thư giãn vùng đầu</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="process-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/3.jpg" class="card-img-top rounded-top" alt="Cạo mặt & cạo râu">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Cạo mặt & cạo râu</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="process-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/4.jpg" class="card-img-top rounded-top" alt="Lau mặt bằng khăn ướt">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Lau mặt bằng khăn ướt</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="process-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/5.jpg" class="card-img-top rounded-top" alt="Phun nước hoa hồng">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Phun nước hoa hồng</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="process-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/6.jpg" class="card-img-top rounded-top" alt="Thư giãn mắt lông công & âm thoa">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Thư giãn mắt lông công & âm thoa</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="process-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/7.jpg" class="card-img-top rounded-top" alt="Dò ráy tai">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Dò ráy tai</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="process-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/8.jpg" class="card-img-top rounded-top" alt="Lấy ráy tai nhẹ nhàng & sạch sẽ">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Lấy ráy tai nhẹ nhàng & sạch sẽ</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="process-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/9.jpg" class="card-img-top rounded-top" alt="Vệ sinh tai">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Vệ sinh tai</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="process-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/10.jpg" class="card-img-top rounded-top" alt="Làm phê tai & thư giãn tai">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Làm phê tai & thư giãn tai</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="process-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/11.jpg" class="card-img-top rounded-top" alt="Lấy khăn ướt làm dịu tai">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Lấy khăn ướt làm dịu tai</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Unique Features Section -->
            <section class="unique-features-section mb-5">
                <h4 class="section-title text-uppercase mb-4">Điểm khác biệt</h4>
                <p class="text-muted mb-4 fs-5">35 phút tận hưởng sự tươi mới dưới làn nước mát lạnh & chăm sóc da mặt láng mịn</p>
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                    <div class="col">
                        <div class="feature-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/11.jpg" class="card-img-top rounded-top" alt="Giường lấy ráy tai êm ái">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Giường lấy ráy tai êm ái, dễ chịu xua tan mọi lo lắng, muộn phiền</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="feature-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/12.jpg" class="card-img-top rounded-top" alt="Kỹ thuật lấy ráy tai chuyên nghiệp">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Kỹ thuật lấy ráy tai chuyên nghiệp, sạch sẽ hơn rất nhiều so với sử dụng bông tăm</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="feature-item card h-100 border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/image/raytai/13.jpg" class="card-img-top rounded-top" alt="Đắp khăn nóng & cạo mặt">
                            <div class="card-body text-center">
                                <p class="card-text fw-bold">Đắp khăn nóng & cạo mặt dễ chịu, đem lại cảm giác nhẹ bẫng, sạch sẽ</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <!-- Booking CTA Section -->
        <section class="booking-cta text-center py-5">
            <div class="container">
                <h2 class="fw-bold mb-3">Sẵn sàng trải nghiệm dịch vụ đỉnh cao?</h2>
                <p class="lead mb-4">Đặt lịch ngay hôm nay để nhận ưu đãi đặc biệt dành riêng cho bạn!</p>
                <a href="${pageContext.request.contextPath}/views/booking/booking.jsp"" class="btn btn-primary btn-lg fw-medium">Đặt lịch ngay</a>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer py-5">
            <div class="container">
                <div class="row g-4">
                    <!-- Logo and About -->
                    <div class="col-lg-4 col-md-6">
                        <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Cut&Styles Logo" class="footer-logo">
                        <p class="text-muted">Cut&Styles Barber - Mang đến trải nghiệm chăm sóc tóc và thư giãn đỉnh cao với dịch vụ chuyên nghiệp.</p>
                    </div>

                    <!-- Links -->
                    <div class="col-lg-4 col-md-6">
                        <h4 class="footer-title">Liên kết nhanh</h4>
                        <ul class="footer-links">
                            <li><a href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/common/franchise.jsp">Liên hệ nhượng quyền</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/commit/support.jsp">Chính sách cam kết</a></li>
                        </ul> 
                    </div>

                    <!-- Contact -->
                    <div class="col-lg-4 col-md-6">
                        <h4 class="footer-title">Thông tin liên hệ</h4>
                        <ul class="footer-contact list-unstyled">
                            <li><i class="bi bi-geo-alt-fill me-2"></i> Khu đô thị FPT City, Hòa Hải, Ngũ Hành Sơn, Đà Nẵng</li>
                            <li><i class="bi bi-telephone-fill me-2"></i> Liên hệ: 0774511941</li>
                            <li><i class="bi bi-clock-fill me-2"></i> Giờ phục vụ: 8h30 - 20h30 (T2 - CN)</li>
                        </ul>
                    </div>
                </div>
                <div class="footer-bottom text-center mt-4 pt-4 border-top">
                    <p class="mb-0">© 2025 Cut&Styles Barber. All rights reserved.</p>
                </div>
            </div>
        </footer>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
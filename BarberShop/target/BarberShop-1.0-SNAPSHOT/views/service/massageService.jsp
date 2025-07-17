<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cut&Styles Carousel</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/massageService.css">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>
        <%@ include file="/views/common/navbar.jsp" %>

        <!-- Service Section -->
        <section class="service-section">
            <div class="container py-5">
                <h2 class="section-title text-center mb-5">GỘI ĐẦU DƯỠNG SINH THƯ GIÃN</h2>

                <div class="row g-4 justify-content-center">
                    <!-- Service Item 1 -->
                    <div class="col-md-4">
                        <div class="service-card h-100">
                            <div class="service-header">
                                <h3>Gội Combo 1</h3>
                                <div class="service-details">
                                    <p>Combo gội thư giản cổ vai gáy giảm căng thẳng</p>
                                </div>
                            </div>
                            <div class="service-images">
                                <div class="main-image">
                                    <img src="${pageContext.request.contextPath}/image/image_service/massageCombo1_main.png" alt="Uốn Tiêu Chuẩn" class="img-fluid rounded">
                                </div>
                                <div class="sub-images">
                                    <img src="${pageContext.request.contextPath}/image/image_service/massageCombo1_sub1.png" alt="Uốn Tiêu Chuẩn" class="img-fluid rounded">
                                    <img src="${pageContext.request.contextPath}/image/image_service/massageCombo1_sub2.png" alt="Uốn Tiêu Chuẩn" class="img-fluid rounded">
                                </div>
                            </div>
                            <div class="service-footer">
                                <div class="price">
                                    <span class="amount">25 phút</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/views/service/spaCombo1.jsp" class="more-info">Tìm hiểu thêm <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- Service Item 2 -->
                    <div class="col-md-4">
                        <div class="service-card h-100">
                            <div class="service-header">
                                <h3>Gội combo 2</h3>
                                <div class="service-details">
                                    <p>Combo gội thư giãn và chăm sóc gia chuyên sâu sáng đều màu gia bằng thiết bị công nghệ cao </p>
                                </div>
                            </div>
                            <div class="service-images">
                                <div class="main-image">
                                    <img src="${pageContext.request.contextPath}/image/image_service/massageCombo2_main.png" alt="Uốn Cao Cấp" class="img-fluid rounded">
                                </div>
                                <div class="sub-images">
                                    <img src="${pageContext.request.contextPath}/image/image_service/massageCombo2_sub1.png" alt="Uốn Cao Cấp" class="img-fluid rounded">
                                    <img src="${pageContext.request.contextPath}/image/image_service/massageCombo1_main.png" alt="Uốn Cao Cấp" class="img-fluid rounded">
                                </div>
                            </div>
                            <div class="service-footer">
                                <div class="price">
                                    <span class="amount">35 phút</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/views/service/spaCombo2.jsp" class="more-info">Tìm hiểu thêm <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- Service Item 3 -->
                    <div class="col-md-4">
                        <div class="service-card h-100">
                            <div class="service-header">
                                <h3>Gội combo 3</h3>
                                <div class="service-details">
                                    <p>Combo gội thư giãn tác động sau vùng đầu và giân cơ lưng giảm đau bằng đá nóng Himalaya </p>
                                </div>
                            </div>
                            <div class="service-images">
                                <div class="main-image">
                                    <img src="${pageContext.request.contextPath}/image/image_service/massageCombo3_main.png" alt="Uốn Cao Cấp" class="img-fluid rounded">
                                </div>
                                <div class="sub-images">
                                    <img src="${pageContext.request.contextPath}/image/image_service/massageCombo3_sub1.png" alt="Uốn Cao Cấp" class="img-fluid rounded">
                                    <img src="${pageContext.request.contextPath}/image/image_service/massageCombo3_sub2.png" alt="Uốn Cao Cấp" class="img-fluid rounded">
                                </div>
                            </div>
                            <div class="service-footer">
                                <div class="price">
                                    <span class="amount">45 phút</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/views/service/spaCombo3.jsp" class="more-info">Tìm hiểu thêm <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>

                <h2 class="section-title text-center my-5">Lấy ráy tai</h2>

                <div class="row g-4 justify-content-center" id="nhuom-toc">
                    <!-- Service Item 3 -->
                    <div class="col-md-6 col-lg-4">
                        <div class="service-card h-100">
                            <div class="service-header">
                                <h3>Lấy ráy tai êm</h3>
                                <div class="service-details">
                                    <p>Kĩ thuật lấy ráy tai nhẹ nhàng & thư thái trong không gian yên tĩnh, sạch sẽ</p>
                                </div>
                            </div>
                            <div class="service-images">
                                <div class="main-image">
                                    <img src="${pageContext.request.contextPath}/image/image_service/layRayTai_main.png" alt="Nhuộm Tiêu Chuẩn" class="img-fluid rounded">
                                </div>
                                <div class="sub-images">
                                    <img src="${pageContext.request.contextPath}/image/image_service/layRayTai_sub1.png" alt="Nhuộm Tiêu Chuẩn" class="img-fluid rounded">
                                    <img src="${pageContext.request.contextPath}/image/image_service/layRayTai_sub2.png" alt="Nhuộm Tiêu Chuẩn" class="img-fluid rounded">
                                </div>
                            </div>
                            <div class="service-footer">
                                <div class="price">
                                    <span class="amount">30 phút</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/views/service/raytai.jsp" class="more-info">Tìm hiểu thêm <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>

        <!-- Booking CTA Section -->
        <div class="booking-cta py-5 text-center">
            <a href="${pageContext.request.contextPath}/views/common/booking.jsp" class="btn btn-primary btn-lg">Đặt lịch ngay</a>
        </div>

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
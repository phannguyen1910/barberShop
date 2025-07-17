<%-- 
    Document   : cutHairService
    Created on : May 16, 2025, 11:07:31 AM
    Author     : LENOVO
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cut&Styles Carousel</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/cutHairService.css">
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
                <div class="row g-4">
                    <!-- Service Item 1 -->
                    <div class="col-md-6 col-lg-4">
                        <div class="service-card h-100">
                            <div class="service-header">
                                <h3>Cắt gội khoang thương gia</h3>
                                <div class="service-details">
                                    <p>Combo cắt kỹ</p>
                                    <p>Combo gội dưỡng sinh</p>
                                </div>
                            </div>
                            <div class="service-images">
                                <div class="main-image">
                                    <img src="${pageContext.request.contextPath}/image/image_service/thuongGia1.png" alt="Cắt tóc thương gia" class="img-fluid rounded">
                                </div>
                                <div class="sub-images">
                                    <img src="${pageContext.request.contextPath}/image/image_service/thuongGia.png" alt="Gội đầu" class="img-fluid rounded">
                                    <img src="${pageContext.request.contextPath}/image/image_service/hutMun.png" alt="Tạo kiểu" class="img-fluid rounded">
                                </div>
                            </div>
                            <div class="service-footer">
                                <div class="time">
                                    <span class="duration">50 Phút</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/views/service/catgoithuonggia.jsp" class="more-info">Tìm hiểu thêm <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- Service Item 2 -->
                    <div class="col-md-6 col-lg-4">
                        <div class="service-card h-100">
                            <div class="service-header">
                                <h3>Cắt gội Combo 1</h3>
                                <div class="service-details">
                                    <p>Combo cắt kỹ</p>
                                    <p>Combo gội dưỡng sinh</p>
                                </div>
                            </div>
                            <div class="service-images">
                                <div class="main-image">
                                    <img src="${pageContext.request.contextPath}/image/image_service/catToc.png" alt="Cắt Combo 1" class="img-fluid rounded">
                                </div>
                                <div class="sub-images">
                                    <img src="${pageContext.request.contextPath}/image/image_service/doiNuoc.png" alt="Gội đầu" class="img-fluid rounded">
                                    <img src="${pageContext.request.contextPath}/image/image_service/hutMun.png" alt="Tạo kiểu" class="img-fluid rounded">
                                </div>
                            </div>
                            <div class="service-footer">
                                <div class="time">
                                    <span class="duration">45 Phút</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/views/service/cutHairCombo1.jsp" class="more-info">Tìm hiểu thêm <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- Service Item 3 -->
                    <div class="col-md-6 col-lg-4">
                        <div class="service-card h-100">
                            <div class="service-header">
                                <h3>Cắt gội Combo 2</h3>
                                <div class="service-details">
                                    <p>Combo cắt kỹ</p>
                                    <p>Combo gội thư giãn có vai gãy</p>
                                </div>
                            </div>
                            <div class="service-images">
                                <div class="main-image">
                                    <img src="${pageContext.request.contextPath}/image/image_service/combo2.2.png" alt="Cắt Combo 2" class="img-fluid rounded">
                                </div>
                                <div class="sub-images">
                                    <img src="${pageContext.request.contextPath}/image/image_service/combo2.1.png" alt="Gội đầu" class="img-fluid rounded">
                                    <img src="${pageContext.request.contextPath}/image/image_service/combo2.png" alt="Tạo kiểu" class="img-fluid rounded">
                                </div>
                            </div>
                            <div class="service-footer">
                                <div class="time">
                                    <span class="duration">55 Phút</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/views/service/cutHairCombo2.jsp" class="more-info">Tìm hiểu thêm <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- Service Item 4 -->
                    <div class="col-md-6 col-lg-4">
                        <div class="service-card h-100">
                            <div class="service-header">
                                <h3>Cắt gội Combo 3</h3>
                                <div class="service-details">
                                    <p>Combo cắt kỹ</p>
                                    <p>Combo gội dưỡng sinh chăm sóc da</p>
                                </div>
                            </div>
                            <div class="service-images">
                                <div class="main-image">
                                    <img src="${pageContext.request.contextPath}/image/image_service/combo3_main.png" alt="Cắt Combo 3" class="img-fluid rounded">
                                </div>
                                <div class="sub-images">
                                    <img src="${pageContext.request.contextPath}/image/image_service/combo3_sub1.png" alt="Gội đầu" class="img-fluid rounded">
                                    <img src="${pageContext.request.contextPath}/image/image_service/combo3_sub2.png" alt="Tạo kiểu" class="img-fluid rounded">
                                </div>
                            </div>
                            <div class="service-footer">
                                <div class="time">
                                    <span class="duration">65 Phút</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/views/service/cutHairCombo3.jsp" class="more-info">Tìm hiểu thêm <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- Service Item 5 -->
                    <div class="col-md-6 col-lg-4">
                        <div class="service-card h-100">
                            <div class="service-header">
                                <h3>Cắt gội Combo 4</h3>
                                <div class="service-details">
                                    <p>Combo cắt kỹ</p>
                                    <p>Combo gội thư giãn chuyên sâu bằng đá nóng</p>
                                </div>
                            </div>
                            <div class="service-images">
                                <div class="main-image">
                                    <img src="${pageContext.request.contextPath}/image/image_service/combo4_main.png" alt="Cắt Combo 4" class="img-fluid rounded">
                                </div>
                                <div class="sub-images">
                                    <img src="${pageContext.request.contextPath}/image/image_service/combo4_sub1.png" alt="Gội đầu" class="img-fluid rounded">
                                    <img src="${pageContext.request.contextPath}/image/image_service/catToc.png" alt="Tạo kiểu" class="img-fluid rounded">
                                </div>
                            </div>
                            <div class="service-footer">
                                <div class="time">
                                    <span class="duration">75 Phút</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/views/service/cutHairCombo4.jsp" class="more-info">Tìm hiểu thêm <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>


        <!-- Booking CTA Section -->
        <div class="booking-cta py-5 text-center">
            <a href="#" class="btn btn-primary btn-lg">Đặt lịch ngay</a>
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
                    <div  class="col-12 text-center">
                        <p>&copy; 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
                    </div>
                </div>
            </div>
        </footer>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
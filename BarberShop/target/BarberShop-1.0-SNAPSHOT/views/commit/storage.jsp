<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cut&Styles Barber - Premium Experience</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/storage.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
        <!-- Custom CSS -->

    </head>
    <body>
        <!-- Navbar -->
        <%@ include file="/views/common/navbar.jsp" %>

        <!-- Support Section -->
        <section class="commitment-section py-5">
            <div class="container">
                <div class="section-header text-center mb-5">
                    <h2 class="section-title" lang="vi">Cam Kết Bảo Vệ Tài Sản</h2>
                    <div class="section-divider">
                        <span class="divider-line"></span>
                        <span class="divider-icon"><i class="fas fa-cut"></i></span>
                        <span class="divider-line"></span>
                    </div>
                    <p class="section-subtitle" lang="vi">An tâm tuyệt đối với dịch vụ giữ xe và bảo quản đồ cá nhân</p>
                </div>

                <div class="row">
                    <div class="support-card mb-5">
                        <div class="support-row">
                            <div class="support-img col-md-5 mb-4 mb-md-0">
                                <img src="${pageContext.request.contextPath}/image/image_service/support2.png" alt="Giữ xe an toàn" class="img-fluid">
                            </div>
                            <div class="support-text col-md-6">
                                <h3 class="support-title" lang="vi">An Tâm Với Dịch Vụ Giữ Xe</h3>
                                <p lang="vi">Để trải nghiệm tại Cut&Styles thực sự trọn vẹn, chúng tôi loại bỏ mọi lo lắng, bao gồm cả việc mất xe.</p>
                                <p lang="vi">Với đội ngũ bảo vệ chuyên nghiệp và hệ thống giám sát hiện đại, tài sản của bạn luôn được đảm bảo an toàn tuyệt đối, ngay cả trong giờ cao điểm.</p>
                            </div>
                        </div>
                    </div>

                    <div class="support-card mb-5">
                        <div class="support-row flex-md-row-reverse">
                            <div class="support-img col-md-5 mb-4 mb-md-0">
                                <img src="${pageContext.request.contextPath}/image/image_service/support3.png" alt="Tủ locker bảo vệ đồ" class="img-fluid">
                            </div>
                            <div class="support-text col-md-6">
                                <h3 class="support-title" lang="vi">Bảo Quản Đồ Cá Nhân An Toàn</h3>
                                <p lang="vi">Đồ dùng cá nhân như balo, áo khoác được lưu trữ an toàn trong tủ locker có khóa riêng.</p>
                                <p lang="vi">Các vật phẩm giá trị như laptop, máy ảnh được lễ tân hoặc trưởng cửa hàng trực tiếp bảo quản, với hệ thống camera giám sát 24/7 đảm bảo không có rủi ro.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="row">
                    <!-- Logo and About -->
                    <div class="col-lg-4 col-md-6 footer-col">
                        <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Cut&Styles Logo" class="footer-logo">
                        <p lang="vi">Cut&Styles Barber - Nơi mang đến phong cách và sự tự tin cho bạn.</p>
                    </div>

                    <!-- Links -->
                    <div class="col-lg-4 col-md-6 footer-col">
                        <h4 class="footer-title" lang="vi">Liên kết nhanh</h4>
                        <ul class="footer-links">
                            <li><a href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/common/franchise.jsp">Liên hệ nhượng quyền</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/commit/details.jsp">Chính sách cam kết</a></li>
                        </ul>
                    </div>

                    <!-- Contact -->
                    <div class="col-lg-4 col-md-6 footer-col">
                        <h4 class="footer-title" lang="vi">Thông tin liên hệ</h4>
                        <div class="footer-contact">
                            <p lang="vi"><i class="bi bi-geo-alt-fill"></i> <span>Khu đô thị FPT City, Hòa Hải, Ngũ Hành Sơn, Đà Nẵng</span></p>
                            <p lang="vi"><i class="bi bi-telephone-fill"></i> <span>Liên hệ học nghề tóc: 0774511941</span></p>
                            <p lang="vi"><i class="bi bi-clock-fill"></i> <span>Giờ phục vụ: Thứ 2 - Chủ Nhật, 8h30 - 20h30</span></p>
                        </div>
                    </div>
                </div>

                <div class="row footer-bottom">
                    <div class="col-12 text-center">
                        <p lang="vi">© 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
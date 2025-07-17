<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cut&Styles Carousel</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/details.css">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>
        <!-- Navbar -->
        <%@ include file="/views/common/navbar.jsp" %>

        <!-- Commitment Section -->
        <section class="commitment-section py-5">
            <div class="container">
                <div class="section-header text-center mb-5">
                    <h2 class="section-title">CAM KẾT CỦA CUT&STYLES BARBER</h2>
                    <div class="section-divider">
                        <span class="divider-line"></span>
                        <span class="divider-icon"><i class="fas fa-cut"></i></span>
                        <span class="divider-line"></span>
                    </div>
                    <p class="section-subtitle">Vì chúng tôi tin rằng chất lượng phục vụ là hàng đầu</p>
                </div>

                <div class="row">
                    <div class="col-lg-6 mb-4">
                        <div class="commitment-card">
                            <div class="commitment-icon">
                                <i class="fas fa-calendar-check"></i>
                            </div>
                            <div class="commitment-content">
                                <h3 class="commitment-title">7 ngày chỉnh sửa tóc miễn phí</h3>
                                <p class="commitment-text">Nếu bạn chưa hài lòng về kiểu tóc sau khi về nhà vì bất kỳ lý do gì, Cut&Styles Barber sẽ hỗ trợ bạn sửa lại mái tóc đó hoàn toàn miễn phí trong vòng 7 ngày. Chỉ cần đặt lịch bình thường và thông báo với lễ tân khi đến.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 mb-4">
                        <div class="commitment-card">
                            <div class="commitment-icon">
                                <i class="fas fa-medal"></i>
                            </div>
                            <div class="commitment-content">
                                <h3 class="commitment-title">7 ngày bảo hành Uốn/Nhuộm</h3>
                                <p class="commitment-text">Mái tóc sau khi uốn nhuộm có thể không đúng ý bạn sau khi về nhà. Cut&Styles Barber sẽ hỗ trợ bạn chỉnh sửa hoàn toàn miễn phí trong vòng 7 ngày. Chỉ cần đặt lịch bình thường và chọn dịch vụ bảo hành.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 mb-4">
                        <div class="commitment-card">
                            <div class="commitment-icon">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="commitment-content">
                                <h3 class="commitment-title">Chính sách đặc biệt khi chờ đợi</h3>
                                <p class="commitment-text">Cut&Styles Barber cam kết phục vụ bạn đúng giờ đặt lịch. Nếu bạn phải chờ đợi quá 20 phút so với giờ đã đặt, chúng tôi sẽ áp dụng chính sách giá đặc biệt dành riêng cho bạn.</p>
                                <p class="commitment-note"><i class="fas fa-info-circle"></i> Áp dụng khi bạn đến đúng giờ đã đặt</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 mb-4">
                        <div class="commitment-card">
                            <div class="commitment-icon">
                                <i class="fas fa-thumbs-up"></i>
                            </div>
                            <div class="commitment-content">
                                <h3 class="commitment-title">Chất lượng sản phẩm cam kết</h3>
                                <p class="commitment-text">100% sản phẩm sử dụng tại Cut&Styles Barber đều có nguồn gốc rõ ràng và đã được kiểm định chất lượng tại Việt Nam. Chúng tôi cam kết sử dụng những sản phẩm tốt nhất cho mái tóc của bạn.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-12">
                        <div class="commitment-premium">
                            <div class="commitment-premium-header">
                                <i class="fas fa-star premium-icon"></i>
                                <h3>HỖ TRỢ KHÁCH HÀNG TRONG VÒNG 2 GIỜ</h3>
                                <i class="fas fa-star premium-icon"></i>
                            </div>
                            <div class="commitment-premium-content">
                                <ul class="premium-list">
                                    <li>
                                        <i class="fas fa-check-circle"></i>
                                        <span>Nếu bạn chưa được thông báo giá cả hoặc thông tin dịch vụ rõ ràng, minh bạch trước khi sử dụng, chúng tôi cam kết hoàn trả 100% giá trị thanh toán.</span>
                                    </li>
                                    <li>
                                        <i class="fas fa-check-circle"></i>
                                        <span>Nếu kiểu tóc mới chưa phù hợp hoặc cần điều chỉnh, đội ngũ Cut&Styles Barber luôn sẵn sàng hỗ trợ bạn trong vòng 2 giờ.</span>
                                    </li>
                                    <li>
                                        <i class="fas fa-check-circle"></i>
                                        <span>Với mọi vấn đề về trải nghiệm khách hàng, từ thái độ phục vụ, không gian salon, thời gian chờ đợi hay các vấn đề về sức khỏe da và tóc, chúng tôi luôn lắng nghe và giải quyết kịp thời.</span>
                                    </li>
                                </ul>
                                <div class="premium-guarantee">
                                    <p><i class="fas fa-thumbs-up"></i> 100% sản phẩm sử dụng tại Cut&Styles Barber đều có nguồn gốc rõ ràng và đã được kiểm định chất lượng.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                        <div class="booking-cta py-5 text-center">
                            <h4 class="mb-4">Trải nghiệm ngay dịch vụ chất lượng tại Cut&Styles Barber</h4>
                            <p class="mb-4">Tại chi nhánh duy nhất: Khu đô thị FPT city, Hòa Hải, Ngũ Hành Sơn, Đà Nẵng</p>
                            <a href="${pageContext.request.contextPath}/views/booking/booking.jsp" class="btn btn-primary btn-lg">Đặt lịch ngay</a>
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
</html>F
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cut and Style - Franchies </title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/franchise.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    </head>
    <body>
        <%@ include file="/views/common/navbar.jsp" %>

        <!-- Content overlay pour l'effet glassmorphism -->
        <div class="content-overlay">
            <!-- Section Hero -->
            <section class="hero-section">
                <div class="container">
                    <h2 class="hero-title fade-in">Nhượng quyền  thương hiệu</h2>
                    <p class="hero-subtitle fade-in">Gia nhập mạng lưới salon nam cao cấp hàng đầu Việt Nam</p>
                    <div class="golden-line"></div>
                </div>
            </section>
            

            <!-- Đặc điểm nổi bật -->
            <section class="features-section">
                <div class="container">
                    <h2 class="section-title fade-in">Tại Sao Chọn Cut & Style?</h2>
                    <div class="golden-line"></div>

                    <div class="row">
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="feature-card fade-in">
                                <div class="feature-icon">
                                    <i class="fas fa-crown"></i>
                                </div>
                                <h4>Thương Hiệu Uy Tín</h4>
                                <p>10 năm kinh nghiệm trong ngành làm đẹp nam giới với thương hiệu được tin tưởng</p>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="feature-card fade-in">
                                <div class="feature-icon">
                                    <i class="fas fa-graduation-cap"></i>
                                </div>
                                <h4>Đào Tạo Chuyên Nghiệp</h4>
                                <p>Chương trình đào tạo toàn diện từ kỹ thuật cắt tóc đến quản lý kinh doanh</p>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="feature-card fade-in">
                                <div class="feature-icon">
                                    <i class="fas fa-chart-line"></i>
                                </div>
                                <h4>Lợi Nhuận Cao</h4>
                                <p>Mô hình kinh doanh hiệu quả với ROI trung bình 25-30% trong năm đầu</p>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="feature-card fade-in">
                                <div class="feature-icon">
                                    <i class="fas fa-tools"></i>
                                </div>
                                <h4>Hỗ Trợ Toàn Diện</h4>
                                <p>Hỗ trợ thiết kế, trang thiết bị, marketing và vận hành từ A-Z</p>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="feature-card fade-in">
                                <div class="feature-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <h4>Vị Trí Chiến Lược</h4>
                                <p>Tư vấn chọn địa điểm kinh doanh tối ưu dựa trên phân tích thị trường</p>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="feature-card fade-in">
                                <div class="feature-icon">
                                    <i class="fas fa-mobile-alt"></i>
                                </div>
                                <h4>Công Nghệ Hiện Đại</h4>
                                <p>Hệ thống đặt lịch online, quản lý khách hàng và báo cáo doanh thu</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Form đăng ký -->
            <section class="form-section">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="form-container fade-in">
                                <h2 class="form-title">Đăng Ký Nhận Tư Vấn</h2>
                                <div class="golden-line"></div>

                                <form id="franchiseForm" action="processFranchise.jsp" method="POST">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="fullName" class="form-label">Họ và Tên *</label>
                                            <input type="text" 
                                                   class="form-control luxury-input" 
                                                   id="fullName" 
                                                   name="fullName" 
                                                   required 
                                                   placeholder="Nhập họ và tên của bạn">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="phone" class="form-label">Số Điện Thoại *</label>
                                            <input type="tel" 
                                                   class="form-control luxury-input" 
                                                   id="phone" 
                                                   name="phone" 
                                                   required 
                                                   placeholder="0123 456 789">
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email *</label>
                                        <input type="email" 
                                               class="form-control luxury-input" 
                                               id="email" 
                                               name="email" 
                                               required 
                                               placeholder="example@gmail.com">
                                    </div>

                                    <div class="mb-3">
                                        <label for="capabilities" class="form-label">Giới Thiệu Năng Lực *</label>
                                        <textarea class="form-control luxury-input luxury-textarea" 
                                                  id="capabilities" 
                                                  name="capabilities" 
                                                  required 
                                                  placeholder="Hãy cho chúng tôi biết về kinh nghiệm, năng lực và sự chuẩn bị của bạn cho việc kinh doanh..."></textarea>
                                    </div>

                                    <div class="mb-4">
                                        <label for="proposal" class="form-label">Đề Xuất Hợp Tác</label>
                                        <textarea class="form-control luxury-input luxury-textarea" 
                                                  id="proposal" 
                                                  name="proposal" 
                                                  placeholder="Chia sẻ ý tưởng, kế hoạch kinh doanh và mong muốn hợp tác của bạn..."></textarea>
                                    </div>

                                    <div class="text-center">
                                        <button type="submit" class="luxury-btn">
                                            <i class="fas fa-paper-plane me-2"></i>
                                            Gửi Thông Tin Đăng Ký
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
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


        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
            // Animation on scroll
            function animateOnScroll() {
                const elements = document.querySelectorAll('.fade-in');

                elements.forEach(element => {
                    const elementTop = element.getBoundingClientRect().top;
                    const elementVisible = 150;

                    if (elementTop < window.innerHeight - elementVisible) {
                        element.classList.add('visible');
                    }
                });
            }

            window.addEventListener('scroll', animateOnScroll);
            window.addEventListener('load', animateOnScroll);

            // Form validation và submission
            document.getElementById('franchiseForm').addEventListener('submit', function (e) {
                e.preventDefault();

                // Validation
                const fullName = document.getElementById('fullName').value.trim();
                const phone = document.getElementById('phone').value.trim();
                const email = document.getElementById('email').value.trim();
                const capabilities = document.getElementById('capabilities').value.trim();

                if (!fullName || !phone || !email || !capabilities) {
                    alert('Vui lòng điền đầy đủ các thông tin bắt buộc!');
                    return;
                }

                // Email validation
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alert('Vui lòng nhập email hợp lệ!');
                    return;
                }

                // Phone validation
                const phoneRegex = /^[0-9]{10,11}$/;
                const cleanPhone = phone.replace(/\s+/g, '');
                if (!phoneRegex.test(cleanPhone)) {
                    alert('Vui lòng nhập số điện thoại hợp lệ (10-11 chữ số)!');
                    return;
                }

                // Success simulation
                const submitBtn = document.querySelector('.luxury-btn');
                const originalText = submitBtn.innerHTML;

                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang gửi...';
                submitBtn.disabled = true;

                setTimeout(() => {
                    alert('Cảm ơn bạn đã đăng ký! Chúng tôi sẽ liên hệ với bạn trong vòng 24h.');
                    this.reset();
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                }, 2000);
            });

            // Smooth scrolling
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });

            // Floating animation
            setInterval(() => {
                const floatingElements = document.querySelector('.floating-elements');
                if (floatingElements) {
                    floatingElements.style.transform = `translateY(${Math.sin(Date.now() / 1000) * 5}px)`;
                }
            }, 100);
        </script>
    </body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Về Chúng Tôi - Cut&Styles Barber</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/aboutUs.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="CSS/html.css">

    </head>
    <body>
        <!-- Navbar -->
        <%@ include file="/views/common/navbar.jsp" %>

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-8 mx-auto text-center hero-content">
                        <h1 class="hero-title">Cut&Styles - Điểm Tựa Cho Phong Cách</h1>
                        <p class="hero-subtitle">Mỗi người đàn ông đều có một hành trình riêng, một thế giới muốn chinh phục.</p>
                        <div class="hero-text">
                            <p>Có người đang tiến về đích, có người vẫn đang tìm hướng đi.</p>
                            <p class="highlight-text">Dù bạn đang ở đâu trên hành trình ấy, bản lĩnh và sự tự tin luôn có trong chính bạn.</p>
                            <p>Cut&Styles không tạo ra chúng. <strong>Chúng tôi là điểm tựa</strong>, giúp bạn thể hiện phong thái.</p>
                        </div>
                    </div>
                </div>
            </div>
            
            
        </section>

        <!-- About Section -->
        <section class="content-section animate-on-scroll">
            <div class="container">
                <div class="content-card">
                    <h2 class="section-title">Kiểu Tóc Đẹp Không Phải Đích Đến – Mà Là Điểm Khởi Đầu</h2>
                    <div class="row">
                        <div class="col-lg-8 mx-auto">
                            <p class="content-text">Một kiểu tóc đẹp không chỉ để ngắm nhìn – mà còn để cảm nhận:</p>
                            <p class="content-text">Cảm nhận sự thoải mái, tự tin, sẵn sàng đối mặt với mọi thử thách.</p>
                            <p class="content-text">Cảm nhận một phiên bản tốt hơn của chính mình.</p>
                            <p class="content-text highlight-text">Với đội ngũ thợ tận tâm và các dịch vụ chăm sóc tóc chuyên nghiệp, Cut&Styles không chỉ mang đến một diện mạo mới.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- Logo Section -->
        <section class="content-section logo-section animate-on-scroll">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-3 col-md-4 text-center mb-4 mb-lg-0">
                        <div class="logo-container">
                            <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Cut&Styles Logo" class="brand-logo img-fluid">
                        </div>
                    </div>
                    <div class="col-lg-9 col-md-8">
                        <div class="brand-story">
                            <h2 class="brand-title">Ý Nghĩa Logo Và Thương Hiệu</h2>
                            <div class="brand-content">
                                <p class="brand-description">
                                    <span class="highlight-accent">Cut&Styles</span> đại diện cho sự tỏa sáng, khát vọng vươn lên và phong cách mạnh mẽ của mỗi người đàn ông hiện đại. Logo của chúng tôi thể hiện sự kết hợp hoàn hảo giữa <strong>sự hiện đại và sự tự tin</strong>, với mong muốn khẳng định vị thế của bạn trong xã hội.
                                </p>
                                <p class="brand-description">
                                    Màu sắc chủ đạo của Cut&Styles, với <span class="highlight-accent">màu vàng đồng sang trọng</span>, là biểu tượng của sự đổi mới không ngừng, tinh thần khởi nghiệp mạnh mẽ và sự <em>tinh tế trong từng chi tiết</em>.
                                </p>
                                <div class="brand-values">
                                    <div class="value-item">
                                        <i class="bi bi-diamond-fill"></i>
                                        <span>Chất lượng cao cấp</span>
                                    </div>
                                    <div class="value-item">
                                        <i class="bi bi-star-fill"></i>
                                        <span>Phong cách độc đáo</span>
                                    </div>
                                    <div class="value-item">
                                        <i class="bi bi-heart-fill"></i>
                                        <span>Tận tâm phục vụ</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>



        <!-- WILLS Section -->
        <section class="content-section animate-on-scroll">
            <div class="container">
                <div class="content-card">
                    <h2 class="section-title">WILLS – Văn Hoá Tinh Thần Của Những Người Dám Tiến Lên</h2>
                    <p class="content-text">
                        Tại Cut&Styles, chúng tôi không chỉ tạo ra diện mạo tuyệt vời, mà còn phục vụ những người đàn ông luôn muốn tốt hơn mỗi ngày. Dù bạn đang bắt đầu, bứt phá hay khẳng định chính mình, tinh thần WILLS luôn đồng hành cùng bạn:
                    </p>
                    <ul class="wills-list">
                        <li><strong>W - Warrior (Chiến binh)</strong> – Kiên cường, không lùi bước trước thử thách</li>
                        <li><strong>I - Intervention (Can thiệp)</strong> – Tạo ra cơ hội, không đợi hoàn hảo</li>
                        <li><strong>L - Learning (Ham học hỏi)</strong> – Phát triển không giới hạn, không ngừng nâng cấp bản thân</li>
                        <li><strong>L - Leadership (Đổi mới)</strong> – Sáng tạo và dẫn đầu sự thay đổi</li>
                        <li><strong>S - Sincerity (Chân thành)</strong> – Minh bạch, đáng tin cậy, tạo dựng giá trị bền vững</li>
                    </ul>
                    <p class="content-text highlight-text">
                        Không có đúng hay sai – chỉ có phiên bản tốt nhất của chính mình, và Cut&Styles luôn đồng hành cùng bạn để giúp bạn tự tin thể hiện điều đó.
                    </p>
                </div>
            </div>
        </section>

        <!-- Mission Section -->
        <section class="content-section animate-on-scroll">
            <div class="container">
                <div class="content-card">
                    <h2 class="section-title">Sứ Mệnh – Tôn Vinh Đôi Bàn Tay Tài Hoa Người Thợ Việt</h2>
                    <p class="content-text">
                        Cut&Styles không chỉ là điểm tựa giúp đàn ông thể hiện phong độ, mà còn mang trong mình một sứ mệnh lớn hơn:
                    </p>
                    <p class="content-text highlight-text">
                        Chúng tôi tôn vinh và nâng tầm đôi bàn tay tài hoa của người thợ Việt trên bản đồ thế giới. Với tay nghề vượt trội, các thợ cắt tóc tại Cut&Styles không chỉ giỏi mà còn có thể vươn xa, khẳng định bản thân trong ngành tóc quốc tế.
                    </p>
                    <p class="content-text">
                        Bằng việc không ngừng đổi mới, nâng cao chất lượng dịch vụ và xây dựng môi trường phát triển chuyên nghiệp, Cut&Styles giúp người thợ Việt phát triển bản thân, nghề nghiệp và vị thế trong ngành tóc toàn cầu.
                    </p>
                </div>
            </div>
        </section>

        <!-- End Note Section -->
        <section class="content-section animate-on-scroll">
            <div class="container">
                <div class="content-card">
                    <h2 class="section-title">Ai Cũng Có Việc Lớn Của Riêng Mình – Chỉ Cần Một Điểm Tựa</h2>
                    <p class="content-text text-center">
                        Không có lộ trình nào giống nhau. Không có đích đến nào là duy nhất. Tại Cut&Styles, chúng tôi sẽ là điểm tựa cho bạn trên hành trình tìm kiếm phong cách riêng của chính mình.
                    </p>
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
                    <div class="col-12 text-center">
                        <p>&copy; 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Scroll to top button -->
        <button class="scroll-top" id="scrollTop">
            <i class="bi bi-arrow-up"></i>
        </button>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Scroll animations
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver(function (entries) {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('animate');
                    }
                });
            }, observerOptions);

            // Observe all animate-on-scroll elements
            document.querySelectorAll('.animate-on-scroll').forEach(el => {
                observer.observe(el);
            });

            // Scroll to top functionality
            const scrollTopBtn = document.getElementById('scrollTop');

            window.addEventListener('scroll', function () {
                if (window.pageYOffset > 300) {
                    scrollTopBtn.classList.add('show');
                } else {
                    scrollTopBtn.classList.remove('show');
                }
            });

            scrollTopBtn.addEventListener('click', function () {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });

            // Smooth scrolling for navbar links
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

            // Add parallax effect to hero section
            window.addEventListener('scroll', function () {
                const scrolled = window.pageYOffset;
                const parallax = document.querySelector('.hero-section');
                const speed = scrolled * 0.5;

                if (parallax) {
                    parallax.style.backgroundPositionY = speed + 'px';
                }
            });

            // Add hover effects to cards
            document.querySelectorAll('.content-card').forEach(card => {
                card.addEventListener('mouseenter', function () {
                    this.style.transform = 'translateY(-10px) scale(1.02)';
                });

                card.addEventListener('mouseleave', function () {
                    this.style.transform = 'translateY(0) scale(1)';
                });
            });

            // Add loading animation
            window.addEventListener('load', function () {
                document.body.classList.add('loaded');

                // Animate hero content
                const heroElements = document.querySelectorAll('.hero-content > *');
                heroElements.forEach((el, index) => {
                    setTimeout(() => {
                        el.style.opacity = '1';
                        el.style.transform = 'translateY(0)';
                    }, index * 200);
                });
            });

            // Add dynamic navbar background on scroll
            window.addEventListener('scroll', function () {
                const navbar = document.querySelector('.custom-navbar');
                if (window.scrollY > 100) {
                    navbar.style.backgroundColor = 'rgba(32, 30, 21, 0.95)';
                    navbar.style.backdropFilter = 'blur(15px)';
                } else {
                    navbar.style.backgroundColor = '#201E15';
                    navbar.style.backdropFilter = 'none';
                }
            });
        </script>
    </body>
</html>

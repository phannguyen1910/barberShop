<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gửi Feedback - BarberShop</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/feedback.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg custom-navbar border-bottom shadow-sm">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Logo" width="" height="55" class="me-2">
                Cut&Styles Barber
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-between" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/views/common/home.jsp">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/views/common/franchise.jsp">Nhượng quyền</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/BookingServlet">Đặt lịch</a>
                    </li>

                    <!-- Hiển thị Dashboard cho Admin và Staff -->
                    <c:if test="${sessionScope.account != null}">
                        <c:choose>
                            <c:when test="${sessionScope.account.role == 'admin'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/adminDashboard">Dashboard Admin</a>
                                </li>
                            </c:when>
                            <c:when test="${sessionScope.account.role == 'staff'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/staffDashboard">Dashboard Staff</a>
                                </li>
                            </c:when>
                        </c:choose>
                    </c:if>
                </ul>

                <!-- Hiển thị nút login và register nếu chưa đăng nhập -->
                <div class="d-flex gap-2 align-items-center">
                    <c:if test="${sessionScope.account == null}">
                        <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
                        <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/views/auth/register.jsp">Đăng ký</a>
                    </c:if>

                    <!-- Hiển thị avatar và dropdown menu nếu đã đăng nhập -->
                    <c:if test="${sessionScope.account != null}">
                        <span class="me-3" style="color: #FF9900"> Xin chào, <strong>${sessionScope.customer.lastName} ${sessionScope.customer.firstName}</strong></span>
                        <div class="dropdown">
                            <a class="dropdown-toggle d-flex align-items-center" href="#" role="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <div style="width: 40px; height: 40px; background-color: #FF9900; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 18px; font-weight: bold;">
                                    ${fn:substring(sessionScope.customer.firstName, 0, 1)}
                                </div>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Profile</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                            </ul>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <div class="floating-shapes">
            <div class="shape"></div>
            <div class="shape"></div>
            <div class="shape"></div>
        </div>

        <div class="feedback-container">
            <div class="feedback-header">
                <div class="feedback-icon">
                    <i class="fas fa-comments"></i>
                </div>
                <h1>Gửi Phản Hồi</h1>
                <p>Chia sẻ trải nghiệm của bạn với chúng tôi</p>
            </div>

            <div class="feedback-info">
                <h3><i class="fas fa-info-circle"></i> Thông tin dịch vụ</h3>
                <p>Phản hồi của bạn sẽ giúp chúng tôi cải thiện chất lượng dịch vụ</p>
            </div>

            <form action="${pageContext.request.contextPath}/addFeedback" method="post">
                <div class="hidden-inputs">
                    <input type="hidden" name="customerId" value="${param.customerId}" />
                    <input type="hidden" name="staffId" value="${param.staffId != null && param.staffId != '' ? param.staffId : '0'}" />
                    <input type="hidden" name="appointmentId" value="${param.appointmentId}" />
                    <input type="hidden" name="serviceId" value="${param.serviceId != null ? param.serviceId : '1'}" />
                </div>

                <div class="form-group">
                    <label for="comment">
                        <i class="fas fa-edit"></i> Nội dung phản hồi
                    </label>
                    <textarea 
                        id="comment" 
                        name="comment" 
                        class="form-control" 
                        required 
                        placeholder="Hãy chia sẻ trải nghiệm của bạn về dịch vụ..."></textarea>
                </div>

                <div class="form-group">
                    <label>
                        <i class="fas fa-star"></i> Đánh giá của bạn
                    </label>
                    <div class="star-rating-container">
                        <div class="star-rating" id="starRating">
                            <span class="star" data-value="1" title="Rất không hài lòng">★</span>
                            <span class="star" data-value="2" title="Không hài lòng">★</span>
                            <span class="star" data-value="3" title="Bình thường">★</span>
                            <span class="star" data-value="4" title="Hài lòng">★</span>
                            <span class="star" data-value="5" title="Rất hài lòng">★</span>
                        </div>
                        <div class="rating-text" id="ratingText">Rất hài lòng</div>
                    </div>
                    <input type="hidden" id="rating" name="rating" value="5" required />
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-paper-plane"></i>
                    Gửi Phản Hồi
                </button>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6 footer-col">
                    <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Logo" class="footer-logo">
                    <h4 class="footer-title">Cut&Styles Barber</h4>
                    <p>Chúng tôi cam kết mang đến những trải nghiệm cắt tóc và chăm sóc tóc tốt nhất cho bạn.</p>
                </div>
                <div class="col-lg-2 col-md-6 footer-col">
                    <h4 class="footer-title">Liên kết</h4>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/views/common/home.jsp">Trang chủ</a></li>
                        <li><a href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a></li>
                        <li><a href="${pageContext.request.contextPath}/views/common/franchise.jsp">Nhượng quyền</a></li>
                        <li><a href="${pageContext.request.contextPath}/BookingServlet">Đặt lịch</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6 footer-col">
                    <h4 class="footer-title">Dịch vụ</h4>
                    <ul class="footer-links">
                        <li><a href="#">Cắt tóc nam</a></li>
                        <li><a href="#">Nhuộm tóc</a></li>
                        <li><a href="#">Uốn tóc</a></li>
                        <li><a href="#">Chăm sóc tóc</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6 footer-col">
                    <h4 class="footer-title">Liên hệ</h4>
                    <div class="footer-contact">
                        <p><i class="fas fa-map-marker-alt"></i> 123 Đường ABC, Quận 1, TP.HCM</p>
                        <p><i class="fas fa-phone"></i> +84 123 456 789</p>
                        <p><i class="fas fa-envelope"></i> info@cutstyles.com</p>
                        <p><i class="fas fa-clock"></i> 8:00 - 22:00 (T2-CN)</p>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="row">
                   <div  class="col-12 text-center">
                <p>&copy; 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
            </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5.3.3 JavaScript (includes Popper.js) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const stars = document.querySelectorAll('#starRating .star');
            const ratingInput = document.getElementById('rating');
            const ratingText = document.getElementById('ratingText');
            let selectedRating = 5;

            const ratingDescriptions = {
                1: 'Rất không hài lòng',
                2: 'Không hài lòng',
                3: 'Bình thường',
                4: 'Hài lòng',
                5: 'Rất hài lòng'
            };

            stars.forEach(star => {
                star.addEventListener('mouseover', function() {
                    const val = parseInt(this.getAttribute('data-value'));
                    highlightStars(val);
                    ratingText.textContent = ratingDescriptions[val];
                });

                star.addEventListener('mouseout', function() {
                    highlightStars(selectedRating);
                    ratingText.textContent = ratingDescriptions[selectedRating];
                });

                star.addEventListener('click', function() {
                    selectedRating = parseInt(this.getAttribute('data-value'));
                    ratingInput.value = selectedRating;
                    highlightStars(selectedRating);
                    ratingText.textContent = ratingDescriptions[selectedRating];
                    // Thêm hiệu ứng click
                    this.style.transform = 'scale(1.3)';
                    setTimeout(() => {
                        this.style.transform = 'scale(1)';
                    }, 200);
                });
            });

            function highlightStars(rating) {
                stars.forEach(star => {
                    const val = parseInt(star.getAttribute('data-value'));
                    if (val <= rating) {
                        star.classList.add('selected');
                    } else {
                        star.classList.remove('selected');
                    }
                });
            }

            // Khởi tạo mặc định 5 sao
            highlightStars(selectedRating);

            // Thêm hiệu ứng cho form submit
            const form = document.querySelector('form');
            form.addEventListener('submit', function(e) {
                const submitBtn = document.querySelector('.submit-btn');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang gửi...';
                submitBtn.disabled = true;
            });
        });
    </script>
</body>
</html> 
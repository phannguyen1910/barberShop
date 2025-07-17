<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Cá Nhân - Cut & Styles</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
    <style>
        :root {
            --primary-gold: #D4AF37;
            --dark-charcoal: #1a1a1a;
            --light-gray: #f8f9fa;
            --text-muted: #6c757d;
            --shadow-luxury: 0 12px 25px rgba(0, 0, 0, 0.1);
            --shadow-soft: 0 8px 25px rgba(212, 175, 55, 0.15);
            --glass-bg: rgba(255, 255, 255, 0.15);
            --glass-border: rgba(255, 255, 255, 0.2);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            height: 100vh;
            overflow-x: hidden;
            font-family: 'Inter', sans-serif;
            line-height: 1.5;
            color: var(--dark-charcoal);
            background: url('https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1374&q=80') center center/cover fixed no-repeat;
            display: flex;
            flex-direction: column;
        }

        .content-overlay {
            background: transparent;
            flex: 1;
            padding: 2rem 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .custom-navbar {
            background-color: #201E15 !important;
            backdrop-filter: blur(10px);
        }

        .custom-navbar .navbar-brand {
            color: #ffffff !important;
            font-weight: 700;
            font-size: 1.4rem;
            letter-spacing: 1px;
        }

        .custom-navbar .nav-link {
            color: #f5f5f5 !important;
            font-weight: 500;
            font-size: 1.05rem;
            letter-spacing: 0.5px;
            position: relative;
            padding-bottom: 6px;
            transition: color 0.2s ease;
        }

        .custom-navbar .nav-link::after {
            content: "";
            position: absolute;
            width: 0%;
            height: 2px;
            left: 0;
            bottom: 0;
            background-color: #d4af37;
            transition: width 0.3s ease-in-out;
        }

        .custom-navbar .nav-link:hover::after,
        .custom-navbar .nav-link:focus::after {
            width: 100%;
        }

        .custom-navbar .nav-link:hover {
            color: #ffe58a !important;
        }

        .custom-navbar .btn-outline-primary {
            border: 1px solid #d4af37;
            color: #d4af37;
            font-weight: 500;
            padding: 6px 16px;
            transition: all 0.3s ease;
        }

        .custom-navbar .btn-outline-primary:hover {
            background-color: #d4af37;
            color: #201E15;
        }

        .profile-container {
            max-width: 800px;
            margin: 1rem auto;
            padding: 2.5rem;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-luxury);
            position: relative;
            overflow: hidden;
            width: 100%;
            animation: fadeInUp 0.8s ease-out;
        }

        .profile-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-gold), #B8860B);
            border-radius: 25px 25px 0 0;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid rgba(212, 175, 55, 0.2);
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-gold), #B8860B);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            color: white;
            font-size: 3rem;
            box-shadow: var(--shadow-soft);
            position: relative;
            overflow: hidden;
        }

        .profile-avatar::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transform: rotate(-45deg);
            animation: shimmer 3s infinite;
        }


        .profile-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.4rem;
            font-weight: 700;
            color: var(--dark-charcoal);
            margin-bottom: 0.5rem;
        }

        .profile-subtitle {
            color: var(--text-muted);
            font-size: 1.1rem;
            font-weight: 500;
        }

        .golden-line {
            width: 100px;
            height: 2px;
            background: linear-gradient(90deg, transparent, var(--primary-gold), transparent);
            margin: 1rem auto;
            border-radius: 2px;
        }

        .profile-field {
            margin-bottom: 1.8rem;
            padding: 1.2rem;
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            border: 1px solid rgba(212, 175, 55, 0.2);
            transition: all 0.3s ease;
            position: relative;
        }

        .profile-field:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-soft);
        }

        .profile-field label {
            font-weight: 600;
            color: var(--dark-charcoal);
            margin-bottom: 0.8rem;
            display: flex;
            align-items: center;
            font-size: 0.95rem;
            letter-spacing: 0.3px;
        }

        .profile-field label i {
            color: var(--primary-gold);
            margin-right: 0.5rem;
            width: 20px;
        }

        .profile-field .value {
            font-size: 1.1rem;
            color: var(--dark-charcoal);
            font-weight: 500;
            padding: 0.5rem 0;
        }

        .profile-field input {
            display: none;
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid rgba(212, 175, 55, 0.3);
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 500;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(5px);
            transition: all 0.3s ease;
            color: var(--dark-charcoal);
        }

        .profile-field input:focus {
            outline: none;
            border-color: var(--primary-gold);
            box-shadow: 0 0 0 4px rgba(212, 175, 55, 0.2);
            background: rgba(255, 255, 255, 0.95);
            transform: translateY(-1px);
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .btn-custom {
            padding: 0.8rem 1.8rem;
            border-radius: 30px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            font-size: 0.95rem;
            letter-spacing: 0.5px;
        }

        .btn-custom::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3));
            transition: left 0.6s;
        }

        .btn-custom:hover::before {
            left: 100%;
        }

        .btn-primary-custom {
            background: linear-gradient(135deg, var(--primary-gold), #B8860B);
            color: white;
            box-shadow: var(--shadow-soft);
        }

        .btn-primary-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(212, 175, 55, 0.4);
            background: linear-gradient(135deg, #E6C547, var(--primary-gold));
            color: white;
        }

        .btn-warning-custom {
            background: linear-gradient(135deg, #f093fb, #f5576c);
            color: white;
            box-shadow: 0 8px 25px rgba(245, 87, 108, 0.3);
        }

        .btn-warning-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(245, 87, 108, 0.4);
            color: white;
        }

        .btn-info-custom {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            color: white;
            box-shadow: 0 8px 25px rgba(79, 172, 254, 0.3);
        }

        .btn-info-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(79, 172, 254, 0.4);
            color: white;
        }

        .btn-secondary-custom {
            background: rgba(255, 255, 255, 0.2);
            color: var(--dark-charcoal);
            border: 2px solid rgba(212, 175, 55, 0.5);
            backdrop-filter: blur(10px);
        }

        .btn-secondary-custom:hover {
            background: rgba(212, 175, 55, 0.1);
            border-color: var(--primary-gold);
            color: var(--dark-charcoal);
            transform: translateY(-3px);
        }

        .modal-content {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            box-shadow: var(--shadow-luxury);
        }

        .modal-header {
            background: linear-gradient(135deg, var(--primary-gold), #B8860B);
            color: white;
            border-radius: 20px 20px 0 0;
            border-bottom: none;
            padding: 1.5rem;
        }

        .modal-header .btn-close {
            filter: invert(1);
            opacity: 0.8;
        }

        .modal-body {
            padding: 2rem;
        }

        .modal-footer {
            border-top: 1px solid rgba(212, 175, 55, 0.2);
            padding: 1.5rem 2rem;
        }

        .form-control {
            border: 2px solid rgba(212, 175, 55, 0.3);
            border-radius: 10px;
            padding: 0.8rem 1rem;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(5px);
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-gold);
            box-shadow: 0 0 0 4px rgba(212, 175, 55, 0.2);
            background: rgba(255, 255, 255, 0.95);
        }

        .edit-mode .profile-field .value {
            display: none;
        }

        .edit-mode .profile-field input {
            display: block;
        }

        .save-buttons {
            display: none;
            gap: 1rem;
            justify-content: center;
            margin-top: 1.5rem;
            flex-wrap: wrap;
        }

        .edit-mode .save-buttons {
            display: flex;
        }

        .edit-mode .action-buttons {
            display: none;
        }

        .alert-custom {
            border-radius: 15px;
            margin-bottom: 1.5rem;
            border: none;
            backdrop-filter: blur(10px);
            font-weight: 500;
            animation: slideIn 0.5s ease-out;
        }

        .alert-success {
            background: linear-gradient(135deg, rgba(40, 167, 69, 0.9), rgba(32, 201, 151, 0.9));
            color: white;
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
        }

        .alert-danger {
            background: linear-gradient(135deg, rgba(220, 53, 69, 0.9), rgba(200, 35, 51, 0.9));
            color: white;
            box-shadow: 0 8px 25px rgba(220, 53, 69, 0.3);
        }

        @keyframes slideIn {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .profile-container {
                padding: 1.5rem;
                margin: 0.5rem;
                max-width: 95%;
            }

            .profile-title {
                font-size: 2rem;
            }

            .btn-custom {
                padding: 0.7rem 1.5rem;
                font-size: 0.9rem;
                width: 100%;
                max-width: 280px;
            }

            .action-buttons {
                flex-direction: column;
                align-items: center;
            }

            .save-buttons {
                flex-direction: column;
                align-items: center;
            }
        }

        @media (max-width: 480px) {
            .profile-container {
                padding: 1rem;
            }

            .profile-title {
                font-size: 1.8rem;
            }

            .profile-field {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg custom-navbar border-bottom shadow-sm">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/index.jsp">
                <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Logo" width="55" height="55" class="me-2">                   
                Cut&Styles Barber
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-between" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/views/common/franchise.jsp">Nhượng quyền</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/views/booking/booking.jsp">Đặt lịch</a>
                    </li>
                </ul>
                <div class="d-flex gap-2">
                    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/views/auth/login.jsp">Đăng nhập</a>
                    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/views/auth/register.jsp">Đăng ký</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="content-overlay">
        <div class="container">
            <div class="profile-container">
                <!-- Alert Messages -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-custom" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${successMessage}
                    </div>
                </c:if>
                
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-custom" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                    </div>
                </c:if>

                <!-- Profile Header -->
                <div class="profile-header">
                    <div class="profile-avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <h2 class="profile-title">Hồ Sơ Cá Nhân</h2>
                    <p class="profile-subtitle">Quản lý thông tin tài khoản của bạn</p>
                    <div class="golden-line"></div>
                </div>

                <!-- Profile Form -->
                <form id="profileForm" action="EditProfileServlet" method="post">
                    <div class="row">
                        
                        <div class="col-md-6">
                            <div class="profile-field">
                                <label><i class="fas fa-user"></i>Họ</label>
                                <div class="value" id="lastName-display">${user.lastName}</div>
                                <input type="text" name="lastName" id="lastName" value="${user.lastName}" required>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="profile-field">
                                <label><i class="fas fa-user"></i>Tên</label>
                                <div class="value" id="firstName-display">${user.firstName}</div>
                                <input type="text" name="firstName" id="firstName" value="${user.firstName}" required>
                            </div>
                        </div>
                    </div>

                    <div class="profile-field">
                        <label><i class="fas fa-envelope"></i>Email</label>
                        <div class="value">Cuong123@gmail.com</div>
                        <input style="text" name="email" value="Cuong123@gmail.com" readonly>
                    </div>

                    <div class="profile-field">
                        <label><i class="fas fa-phone"></i>Số Điện Thoại</label>
                        <div class="value" id="phone-display">${user.phone}</div>
                        <input type="tel" name="phone" id="phone" value="${user.phone}" required>
                    </div>

                    <div class="profile-field">
                        <label><i class="fas fa-lock"></i>Mật Khẩu</label>
                        <div class="value">••••••••</div>
                    </div>

                    <!-- Save/Cancel Buttons (Hidden by default) -->
                    <div class="save-buttons">
                        <button type="submit" class="btn-custom btn-primary-custom">
                            <i class="fas fa-save me-2"></i>Lưu Thay Đổi
                        </button>
                        <button type="button" class="btn-custom btn-secondary-custom" onclick="cancelEdit()">
                            <i class="fas fa-times me-2"></i>Hủy
                        </button>
                    </div>
                </form>

                <!-- Action Buttons -->
                <div class="action-buttons">
                    <button class="btn-custom btn-primary-custom" onclick="enableEdit()">
                        <i class="fas fa-edit me-2"></i>Chỉnh Sửa Hồ Sơ
                    </button>
                    <button class="btn-custom btn-warning-custom" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                        <i class="fas fa-key me-2"></i>Đổi Mật Khẩu
                    </button>
                    <a href="BookingHistoryServlet" class="btn-custom btn-info-custom">
                        <i class="fas fa-history me-2"></i>Lịch Sử Đặt Lịch
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Change Password Modal -->
    <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="changePasswordModalLabel">
                        <i class="fas fa-key me-2"></i>Đổi Mật Khẩu
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="changePasswordForm" action="ChangePasswordServlet" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">
                                <i class="fas fa-lock me-2 text-warning"></i>Mật Khẩu Hiện Tại
                            </label>
                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" required placeholder="Nhập mật khẩu hiện tại">
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">
                                <i class="fas fa-key me-2 text-success"></i>Mật Khẩu Mới
                            </label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" required minlength="6" placeholder="Nhập mật khẩu mới (tối thiểu 6 ký tự)">
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">
                                <i class="fas fa-check-circle me-2 text-info"></i>Xác Nhận Mật Khẩu Mới
                            </label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required placeholder="Nhập lại mật khẩu mới">
                        </div>
                        <div id="passwordError" class="alert alert-danger d-none" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <span id="passwordErrorMessage"></span>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Hủy
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-check me-2"></i>Xác Nhận
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function enableEdit() {
            document.querySelector('.profile-container').classList.add('edit-mode');
        }

        function cancelEdit() {
            document.querySelector('.profile-container').classList.remove('edit-mode');
            // Reset form values
            document.getElementById('firstName').value = '${user.firstName}';
            document.getElementById('lastName').value = '${user.lastName}';
            document.getElementById('phone').value = '${user.phone}';
        }

        // Password confirmation validation
        document.getElementById('changePasswordForm').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const errorDiv = document.getElementById('passwordError');
            const errorMessage = document.getElementById('passwordErrorMessage');

            if (newPassword !== confirmPassword) {
                e.preventDefault();
                errorMessage.textContent = 'Mật khẩu mới và xác nhận mật khẩu không khớp!';
                errorDiv.classList.remove('d-none');
            } else if (newPassword.length < 6) {
                e.preventDefault();
                errorMessage.textContent = 'Mật khẩu mới phải có ít nhất 6 ký tự!';
                errorDiv.classList.remove('d-none');
            } else {
                errorDiv.classList.add('d-none');
            }
        });

        // Hide password error when user types
        document.getElementById('newPassword').addEventListener('input', function() {
            document.getElementById('passwordError').classList.add('d-none');
        });

        document.getElementById('confirmPassword').addEventListener('input', function() {
            document.getElementById('passwordError').classList.add('d-none');
        });

        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert-custom');
            alerts.forEach(function(alert) {
                alert.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-20px)';
                setTimeout(function() {
                    alert.remove();
                }, 500);
            });
        }, 5000);

        // Add smooth scrolling and animation effects
        document.addEventListener('DOMContentLoaded', function() {
            // Add hover effects to profile fields
            const profileFields = document.querySelectorAll('.profile-field');
            profileFields.forEach(field => {
                field.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-2px)';
                    this.style.transition = 'all 0.3s ease';
                });
                
                field.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
        });
    </script>
</body>
</html>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const changePasswordBtn = document.getElementById('changePasswordBtn');
                const popupOverlay = document.getElementById('popupOverlay');
                const popupBox = document.getElementById('popupBox');
                const confirmPopupBtn = document.getElementById('confirmPopupBtn');
                const cancelPopupBtn = document.getElementById('cancelPopupBtn');
                const changePasswordForm = document.getElementById('changePasswordForm');
                const currentPasswordInput = document.getElementById('currentPassword');
                const newPasswordInput = document.getElementById('newPassword');
                const confirmNewPasswordInput = document.getElementById('confirmNewPassword');

                function showPopup() {
                    popupOverlay.style.display = 'block';
                    popupBox.style.display = 'block';
                }

                function hidePopup() {
                    popupOverlay.style.display = 'none';
                    popupBox.style.display = 'none';
                    changePasswordForm.reset();
                }

                function showSuccessMessage(message) {
                    const successDiv = document.createElement('div');
                    successDiv.className = 'success-message';
                    successDiv.textContent = message;
                    document.body.appendChild(successDiv);
                    setTimeout(() => {
                        successDiv.remove();
                    }, 3000);
                }

                changePasswordBtn.addEventListener('click', showPopup);
                cancelPopupBtn.addEventListener('click', hidePopup);
                popupOverlay.addEventListener('click', function (e) {
                    if (e.target === popupOverlay) {
                        hidePopup();
                    }
                });

                confirmPopupBtn.addEventListener('click', function () {
                    const currentPassword = currentPasswordInput.value.trim();
                    const newPassword = newPasswordInput.value.trim();
                    const confirmNewPassword = confirmNewPasswordInput.value.trim();

                    console.log('Confirm button clicked');
                    console.log('Current Password:', currentPassword);
                    console.log('New Password:', newPassword);
                    console.log('Confirm New Password:', confirmNewPassword);

                    if (!currentPassword || !newPassword || !confirmNewPassword) {
                        alert('Vui lòng điền đầy đủ tất cả các trường.');
                        return;
                    }

                    if (newPassword !== confirmNewPassword) {
                        alert('Mật khẩu mới và xác nhận mật khẩu không khớp.');
                        return;
                    }

                    if (newPassword.length < 6) {
                        alert('Mật khẩu mới phải có ít nhất 6 ký tự.');
                        return;
                    }

                    const formData = new FormData(changePasswordForm);
                    console.log('Form Data:', Object.fromEntries(formData));
                    console.log('Form action:', changePasswordForm.action);

                    fetch('${pageContext.request.contextPath}/ChangePasswordServlet', {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => {
                        return response.text().then(text => ({
                            ok: response.ok,
                            status: response.status,
                            text: text
                        }));
                    })
                    .then(data => {
                        if (data.ok) {
                            showSuccessMessage('Đổi mật khẩu thành công!');
                            hidePopup();
                        } else {
                            throw new Error(data.text || 'Đổi mật khẩu thất bại.');
                        }
                    })
                    .catch(error => {
                        alert(error.message);
                    });
                });
            });
        </script>
    </body>
</html>

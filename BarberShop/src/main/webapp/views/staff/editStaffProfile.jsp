<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Staff Profile - Cut&Styles Barber</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/editprofile.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <style>
                    .custom-navbar {
                background: rgba(29, 29, 27, 0.95) !important;
                backdrop-filter: blur(10px);
                border-bottom: 2px solid rgba(218, 165, 32, 0.3) !important;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1100;
                height: 70px;
            }

            .navbar-brand img {
                border-radius: 50%;
                border: 2px solid #DAA520;
            }

            .custom-navbar .btn-warning {
                background-color: #DAA520;
                border-color: #DAA520;
                color: #1d1d1b;
                font-weight: 500;
                padding: 8px 16px;
                border-radius: 25px;
                transition: all 0.3s ease;
            }

            .custom-navbar .btn-warning:hover {
                background-color: #B8860B;
                border-color: #B8860B;
            }

            .navbar-toggler {
                border-color: #DAA520;
            }

            .navbar-toggler-icon {
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='%23DAA520' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
            }

            .dashboard-layout {
                display: flex;
                min-height: 100vh;
                padding-top: 70px;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(rgba(29, 29, 27, 0.7), rgba(29, 29, 27, 0.7)),
                    url('https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1374&q=80');
                background-size: cover;
                background-position: center;
                background-attachment: fixed;
                min-height: 100vh;
                color: #fff;
            }

            .sidebar {
                width: 280px;
                background: rgba(29, 29, 27, 0.95);
                backdrop-filter: blur(10px);
                border-right: 2px solid rgba(218, 165, 32, 0.3);
                position: fixed;
                height: calc(100vh - 70px);
                left: 0;
                top: 70px;
                z-index: 1000;
                transition: transform 0.3s ease;
                overflow-y: auto;
            }

            .sidebar-header {
                padding: 30px 20px;
                text-align: center;
                border-bottom: 1px solid rgba(218, 165, 32, 0.2);
            }

            .logo {
                font-size: 2rem;
                color: #DAA520;
                margin-bottom: 10px;
            }

            .logo-text {
                font-size: 1.3rem;
                font-weight: 600;
                color: #fff;
                margin-bottom: 5px;
            }

            .logo-subtitle {
                font-size: 0.9rem;
                color: #ccc;
            }

            .nav-menu {
                padding: 20px 0;
            }

            .nav-item {
                margin: 8px 0;
            }

            .nav-link {
                display: flex;
                align-items: center;
                padding: 15px 25px;
                color: #ccc;
                text-decoration: none;
                transition: all 0.3s ease;
                border-left: 3px solid transparent;
            }

            .nav-link:hover, .nav-link.active {
                background: rgba(218, 165, 32, 0.1);
                color: #DAA520;
                border-left-color: #DAA520;
            }

            .nav-link i {
                width: 20px;
                margin-right: 15px;
                font-size: 1.1rem;
            }

            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 20px;
            }

            .header {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 10px;
                padding: 15px 20px;
                margin-bottom: 20px;
                border: 1px solid rgba(218, 165, 32, 0.2);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .header h1 {
                font-size: 1.8rem;
                color: #DAA520;
                margin-bottom: 5px;
            }

            .header p {
                font-size: 1rem;
                color: #ccc;
                margin: 0;
            }

            .info-cards {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
            }

            .info-card {
                flex: 1;
                background: rgba(29, 29, 27, 0.9);
                border: 1px solid rgba(218, 165, 32, 0.2);
                border-radius: 10px;
                padding: 15px;
                text-align: center;
            }

            .info-card h3 {
                font-size: 1rem;
                color: #DAA520;
                margin-bottom: 10px;
            }

            .info-card .value {
                font-size: 1.5rem;
                font-weight: 600;
                color: #fff;
            }

            .info-card .description {
                font-size: 0.9rem;
                color: #ccc;
            }

            .schedule-container {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 10px;
                padding: 15px;
                border: 1px solid rgba(218, 165, 32, 0.2);
                margin-bottom: 15px;
            }

            .month-selector {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .month-nav-btn {
                background: transparent;
                border: none;
                color: #DAA520;
                font-size: 1rem;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 5px;
                padding: 5px 10px;
                border-radius: 5px;
                transition: background 0.3s ease;
            }

            .month-nav-btn:hover {
                background: rgba(218, 165, 32, 0.1);
            }

            .current-month {
                font-size: 1.2rem;
                font-weight: 600;
                color: #fff;
            }

            .legend {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }

            .legend-item {
                display: flex;
                align-items: center;
                gap: 5px;
                font-size: 0.9rem;
                color: #ccc;
            }

            .legend-color {
                width: 20px;
                height: 20px;
                border-radius: 3px;
            }

            .calendar-grid {
                display: grid;
                grid-template-columns: repeat(7, 1fr);
                gap: 5px;
            }

            .calendar-header {
                text-align: center;
                font-weight: 600;
                color: #DAA520;
                padding: 10px 0;
                background: rgba(218, 165, 32, 0.1);
                border-radius: 5px;
            }

            .calendar-day {
                position: relative;
                padding: 15px;
                text-align: center;
                border: 1px solid rgba(218, 165, 32, 0.2);
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.3s ease;
                background: rgba(255, 255, 255, 0.05);
            }

            .calendar-day:hover:not(.disabled):not(.other-month):not(.full) {
                background: rgba(218, 165, 32, 0.1);
            }

            .calendar-day.disabled {
                background: rgba(244, 67, 54, 0.2);
                color: #F44336;
                cursor: not-allowed;
            }

            .calendar-day.other-month {
                color: #555;
                background: rgba(255, 255, 255, 0.02);
                cursor: default;
            }

            .calendar-day.full {
                background: rgba(255, 152, 0, 0.2);
                color: #FF9800;
                cursor: not-allowed;
            }

            .calendar-day.selected {
                background: linear-gradient(45deg, #DAA520, #B8860B);
                color: #1d1d1b;
                font-weight: 600;
                border-color: #DAA520;
            }

            .day-count {
                position: absolute;
                top: 5px;
                right: 5px;
                background: #F44336;
                color: #fff;
                font-size: 0.7rem;
                padding: 2px 6px;
                border-radius: 10px;
            }

            .action-buttons {
                display: flex;
                gap: 10px;
                justify-content: flex-end;
                margin-top: 20px;
            }

            .btn-primary {
                background-color: #DAA520;
                border-color: #DAA520;
                color: #1d1d1b;
                padding: 8px 16px;
                border-radius: 25px;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                background-color: #B8860B;
                border-color: #B8860B;
            }

            .btn-primary:disabled {
                background-color: #666;
                border-color: #666;
                cursor: not-allowed;
            }

            .btn-secondary {
                background-color: #666;
                border-color: #666;
                color: #fff;
                padding: 8px 16px;
                border-radius: 25px;
                transition: all 0.3s ease;
            }

            .btn-secondary:hover {
                background-color: #555;
                border-color: #555;
            }

            .toast {
                position: fixed;
                bottom: 20px;
                right: 20px;
                min-width: 200px;
                z-index: 1200;
                display: none;
            }

            .toast.show {
                display: block;
                animation: fadeIn 0.3s ease, fadeOut 0.3s ease 2.7s;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @keyframes fadeOut {
                from {
                    opacity: 1;
                    transform: translateY(0);
                }
                to {
                    opacity: 0;
                    transform: translateY(20px);
                }
            }

            .toast-body {
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 0.9rem;
            }

            .bg-success {
                background-color: #4CAF50;
            }
            .bg-danger {
                background-color: #F44336;
            }

            .mobile-menu-btn {
                display: none;
                position: fixed;
                top: 80px;
                left: 20px;
                z-index: 1001;
                background: rgba(29, 29, 27, 0.9);
                color: #DAA520;
                border: none;
                padding: 8px;
                border-radius: 4px;
                font-size: 1rem;
            }

            .form-label {
                color: #DAA520 !important;
                font-weight: 600;
                letter-spacing: 0.5px;
            }
            .form-control {
                background: rgba(255,255,255,0.85) !important;
                color: #222 !important;
                border: 1.5px solid #DAA520 !important;
                border-radius: 12px !important;
                box-shadow: 0 2px 8px rgba(218,165,32,0.07);
                font-size: 1.08rem;
                font-weight: 500;
                transition: border-color 0.3s, box-shadow 0.3s;
            }
            .form-control:focus {
                border-color: #B8860B !important;
                box-shadow: 0 0 0 2px rgba(218,165,32,0.18);
                background: #fff !important;
                color: #111 !important;
            }
            .input-group-text {
                background: #DAA520;
                color: #fff;
                border: none;
                border-radius: 12px 0 0 12px;
                font-size: 1.1rem;
            }
            .form-section {
                background: rgba(255,255,255,0.92);
                border-radius: 18px;
                box-shadow: 0 4px 18px rgba(218,165,32,0.08);
                padding: 2rem 1.5rem 1.5rem 1.5rem;
                margin-bottom: 2rem;
            }
            .form-section-title {
                color: #B8860B;
                font-family: 'Playfair Display', serif;
                font-size: 1.3rem;
                font-weight: 700;
                margin-bottom: 1.2rem;
                letter-spacing: 0.5px;
            }
            .btn-primary, .btn-secondary {
                margin: 0.2rem 0.3rem;
            }
            @media (max-width: 600px) {
                .form-section { padding: 1rem 0.5rem; }
            }
        </style>
        
        <script>
            function validateForm() {
                const action = document.querySelector('button[type="submit"]:focus').value;
                const phoneNumber = document.getElementById("phoneNumber").value;
                const currentPassword = document.getElementById("currentPassword").value;
                const newPassword = document.getElementById("newPassword").value;
                const confirmPassword = document.getElementById("confirmPassword").value;
                const errorDiv = document.getElementById("formError");

                if (action === "updateProfile") {
                    const phonePattern = /^[0-9]{10,15}$/;
                    if (phoneNumber && !phonePattern.test(phoneNumber)) {
                        errorDiv.innerText = "Số điện thoại phải chứa 10-15 chữ số.";
                        return false;
                    }
                } else if (action === "changePassword") {
                    if (!currentPassword || !newPassword || !confirmPassword) {
                        errorDiv.innerText = "Vui lòng nhập đầy đủ thông tin mật khẩu.";
                        return false;
                    }
                    if (newPassword !== confirmPassword) {
                        errorDiv.innerText = "Mật khẩu mới và xác nhận mật khẩu không khớp.";
                        return false;
                    }
                    if (newPassword.length < 6) {
                        errorDiv.innerText = "Mật khẩu mới phải có ít nhất 6 ký tự.";
                        return false;
                    }
                }
                errorDiv.innerText = "";
                return true;
            }
        </script>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg custom-navbar border-bottom shadow-sm">
            <div class="container-fluid px-4">
                <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/views/staff/dashboard.jsp">
                    <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Logo Barbershop" width="55" height="55" class="me-2">
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <div class="d-flex gap-2 align-items-center">
                        <div class="text-warning d-none d-lg-block me-3">
                            <i class="fas fa-user-tie me-1"></i>
                            <span class="me-3" style="color: #FF9900"> Nhân viên: <strong>${sessionScope.staff.lastName} ${sessionScope.staff.firstName}</strong></span>
                        </div>
                        <a class="btn btn-warning" href="${pageContext.request.contextPath}/logout" onclick="return confirm('Bạn có chắc chắn muốn đăng xuất?')" aria-label="Đăng xuất">
                            <i class="fas fa-sign-out-alt me-1"></i>
                            Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            
            <nav class="sidebar" id="sidebar" aria-label="Menu điều hướng">
                <div class="sidebar-header">
                    <div class="logo"><i class="fas fa-cut"></i></div>
                    <div class="logo-text">BarberShop Pro</div>
                    <div class="logo-subtitle">Staff Dashboard</div>
                </div>
                <div class="nav-menu">
                    <div class="nav-item"><a href="${pageContext.request.contextPath}/views/staff/registerForAShift.jsp" class="nav-link active" aria-label="Đăng ký lịch làm việc"><i class="fas fa-calendar-alt"></i><span>Đăng ký Lịch Làm</span></a></div>
                    <div class="nav-item"><a href="${pageContext.request.contextPath}/StaffAppointment" class="nav-link" aria-label="Lịch hẹn của tôi"><i class="fas fa-clock"></i><span>Lịch Hẹn của Tôi</span></a></div>
                    <div class="nav-item"><a href="${pageContext.request.contextPath}/profile" class="nav-link" aria-label="Thông tin cá nhân"><i class="fas fa-user"></i><span>Thông Tin Cá Nhân</span></a></div>
                </div>
            </nav>
            
                <h2 class="section-title text-center mb-4" style="padding-top: 50px">Chỉnh sửa hồ sơ nhân viên</h2>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <div class="service-card shadow-sm">
                <div class="service-info">
                    <form action="${pageContext.request.contextPath}/EditStaffProfileServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm()" autocomplete="off">
                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-user-edit me-2"></i>Thông tin cá nhân</div>
                            <div class="mb-3 input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control" id="firstName" name="firstName" value="${sessionScope.firstName}" required placeholder="Tên">
                            </div>
                            <div class="mb-3 input-group">
                                <span class="input-group-text"><i class="fas fa-user-tag"></i></span>
                                <input type="text" class="form-control" id="lastName" name="lastName" value="${sessionScope.lastName}" required placeholder="Họ">
                            </div>
                            <div class="mb-3 input-group">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" value="${sessionScope.email}" readonly placeholder="Email">
                            </div>
                            <div class="mb-3 input-group">
                                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${sessionScope.phoneNumber}" placeholder="Số điện thoại">
                            </div>
                            <div class="mb-3 input-group">
                                <span class="input-group-text"><i class="fas fa-store"></i></span>
                                <input type="text" class="form-control" id="branchName" name="branchName" value="${sessionScope.branchName}" readonly placeholder="Chi nhánh">
                            </div>
                            <div class="mb-3">
                                <label for="img" class="form-label"><i class="fas fa-image me-1"></i>Ảnh đại diện</label>
                                <input type="file" class="form-control" id="img" name="img" accept="image/*">
                                <c:if test="${not empty sessionScope.img}">
                                    <img src="${pageContext.request.contextPath}/${sessionScope.img}" alt="Current Staff Image" width="100" class="mt-2 rounded shadow">
                                </c:if>
                            </div>
                        </div>
                        <div id="formError" class="text-danger mb-3"></div>
                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-key me-2"></i>Thay đổi mật khẩu</div>
                            <div class="mb-3 input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="password" class="form-control" id="currentPassword" name="currentPassword" autocomplete="new-password" placeholder="Mật khẩu hiện tại">
                            </div>
                            <div class="mb-3 input-group">
                                <span class="input-group-text"><i class="fas fa-unlock-alt"></i></span>
                                <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Mật khẩu mới">
                            </div>
                            <div class="mb-3 input-group">
                                <span class="input-group-text"><i class="fas fa-check"></i></span>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu mới">
                            </div>
                        </div>
                        <div class="text-center">
                            <button type="submit" name="action" value="updateProfile" class="btn btn-primary"><i class="fas fa-save me-1"></i>Lưu thay đổi hồ sơ</button>
                            <button type="submit" name="action" value="changePassword" class="btn btn-primary"><i class="fas fa-key me-1"></i>Thay đổi mật khẩu</button>
                            <a href="${pageContext.request.contextPath}/profileOfStaff" class="btn btn-secondary">Hủy</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
  
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

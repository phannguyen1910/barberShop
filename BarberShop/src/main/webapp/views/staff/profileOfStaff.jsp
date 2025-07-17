<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Thay đổi kiểm tra session: Đảm bảo đối tượng Account có trong session
    // (Vì navbar và sidebar hiển thị thông tin Account chung)
    if (session.getAttribute("account") == null) {
        response.sendRedirect(request.getContextPath() + "/login"); // Chuyển hướng về trang login nếu chưa đăng nhập
        return;
    }
    // Lấy đối tượng staff từ session (cần thiết cho nội dung profile)
    // Nếu staff là null ở đây, có thể do lỗi logic trong ProfileServlet hoặc người dùng không phải staff nhưng truy cập trang này
    model.Staff staff = (model.Staff) session.getAttribute("staff");
    if (staff == null) {
        // Nếu không phải staff nhưng truy cập trang này, chuyển hướng về profile chung hoặc trang lỗi
        response.sendRedirect(request.getContextPath() + "/profile");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hồ Sơ Nhân Viên - Cut&Styles Barber</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <style>
            /* Reset body padding to allow fixed navbar/sidebar */
            body {
                padding-top: 0 !important; /* Managed by dashboard-layout padding-top */
                font-family: 'Inter', sans-serif; /* Kept from previous profile.jsp, ensure consistency */
                background: linear-gradient(rgba(29, 29, 27, 0.7), rgba(29, 29, 27, 0.7)),
                    url('https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1374&q=80');
                background-size: cover;
                background-position: center;
                background-attachment: fixed;
                min-height: 100vh;
                color: #e0e0e0;
            }

            /* --- Styles from the provided registerForAShift.jsp for Navbar and Sidebar layout --- */
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
                padding-top: 70px; /* Space for fixed navbar */
            }

            .sidebar {
                width: 280px;
                background: rgba(29, 29, 27, 0.95);
                backdrop-filter: blur(10px);
                border-right: 2px solid rgba(218, 165, 32, 0.3);
                position: fixed;
                height: calc(100vh - 70px);
                left: 0;
                top: 70px; /* Aligned with navbar bottom */
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
                margin-left: 280px; /* Space for fixed sidebar */
                padding: 20px;
            }

            .mobile-menu-btn {
                display: none; /* Hidden by default, shown on smaller screens */
                position: fixed;
                top: 80px; /* Below navbar */
                left: 20px;
                z-index: 1001;
                background: rgba(29, 29, 27, 0.9);
                color: #DAA520;
                border: none;
                padding: 8px;
                border-radius: 4px;
                font-size: 1rem;
                cursor: pointer;
            }
            /* --- End of Navbar and Sidebar layout styles --- */


            /* --- Styles specific to the profile content from provided profileOfStaff.jsp (optimized) --- */
            .section-title {
                font-family: 'Playfair Display', serif;
                font-size: 2.5rem;
                font-weight: 700;
                color: #DAA520;
                text-align: center;
                margin-bottom: 3rem; /* Adjusted for better spacing below main-content header */
                position: relative;
                padding-bottom: 0.5rem;
            }

            .section-title::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 3px;
                background-color: #DAA520;
                border-radius: 2px;
            }

            .profile-container {
                max-width: 1000px; /* Max width for the profile card */
                margin: 0 auto;
                padding: 0 15px; /* Add some padding on smaller screens */
            }

            .profile-card {
                background: rgba(29, 29, 27, 0.95);
                backdrop-filter: blur(15px);
                border-radius: 20px;
                padding: 0; /* Padding will be managed by profile-body */
                border: 1px solid rgba(218, 165, 32, 0.2);
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
                color: #e0e0e0;
                overflow: hidden; /* Ensures border-radius applies correctly */
                margin-bottom: 30px;
            }

            .profile-header {
                background: linear-gradient(135deg, #DAA520 0%, #B8860B 100%);
                padding: 2rem;
                text-align: center;
                position: relative;
            }

            .profile-header::before { /* Decorative grain effect */
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="50" cy="10" r="0.5" fill="rgba(255,255,255,0.1)"/><circle cx="10" cy="50" r="0.5" fill="rgba(255,255,255,0.1)"/><circle cx="90" cy="30" r="0.5" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
                opacity: 0.3;
            }

            .profile-avatar {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                margin: 0 auto 1.5rem; /* Center and add margin below */
                border: 4px solid rgba(255, 255, 255, 0.2);
                position: relative;
                z-index: 1; /* Ensure it's above the ::before pseudo-element */
                overflow: hidden;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
            }

            .profile-avatar img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .profile-avatar.no-image {
                background: rgba(255, 255, 255, 0.1);
                display: flex;
                align-items: center;
                justify-content: center;
                color: #fff;
                font-size: 2.5rem;
            }

            .profile-name {
                font-family: 'Playfair Display', serif;
                font-size: 1.8rem;
                font-weight: 600;
                color: #fff;
                margin-bottom: 0.5rem;
                position: relative;
                z-index: 1;
            }

            .profile-role {
                color: rgba(255, 255, 255, 0.9);
                font-size: 1.1rem;
                font-weight: 400;
                position: relative;
                z-index: 1;
            }

            .profile-body {
                padding: 2.5rem;
            }

            .profile-actions {
                display: flex;
                justify-content: center;
                gap: 1rem; /* Space between buttons */
                margin-bottom: 2.5rem; /* Space below buttons */
                flex-wrap: wrap; /* Allow buttons to wrap on small screens */
            }

            .btn-primary {
                background: linear-gradient(135deg, #DAA520 0%, #B8860B 100%);
                border: none;
                color: #fff;
                font-weight: 500;
                padding: 12px 24px;
                border-radius: 25px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(218, 165, 32, 0.3);
                text-decoration: none; /* For <a> tags */
                display: inline-flex; /* Align icon and text */
                align-items: center;
                gap: 8px; /* Space between icon and text */
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(218, 165, 32, 0.4);
                color: #fff; /* Ensure text remains white on hover */
            }

            .btn-primary:active {
                transform: translateY(0);
            }

            .info-grid {
                display: grid;
                grid-template-columns: 1fr; /* Single column on small screens */
                gap: 1.5rem;
                background-color: white; /* White background for the grid container */
                border-radius: 12px;
                padding: 1.5rem;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .info-item {
                background-color: white; /* White background for individual items */
                border-radius: 12px;
                padding: 1.5rem;
                border-left: 4px solid #DAA520; /* Gold border as an accent */
                transition: all 0.3s ease;
                color: #333; /* Dark text for readability on white background */
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); /* Subtle shadow for depth */
            }

            .info-item:hover {
                background-color: #FFFACD; /* Lighter gold on hover for visual feedback */
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            .info-label {
                font-size: 0.9rem;
                color: #DAA520; /* Gold color for labels */
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                gap: 8px; /* Space between label icon and text */
            }

            .info-value {
                font-size: 1.1rem;
                color: #555; /* Slightly lighter black for values */
                font-weight: 400;
                line-height: 1.4;
            }

            .info-value.empty {
                color: #999;
                font-style: italic;
            }

            .alert-success {
                background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
                color: #155724;
                border: 1px solid #c3e6cb;
                text-align: center;
                margin-bottom: 2rem;
                border-radius: 12px;
                padding: 1rem;
                font-weight: 500;
            }

            .alert-danger {
                background: linear-gradient(135deg, #f8d7da 0%, #f1aeb5 100%);
                color: #721c24;
                border: 1px solid #f1aeb5;
                text-align: center;
                margin-bottom: 2rem;
                border-radius: 12px;
                padding: 1rem;
                font-weight: 500;
            }

            /* Footer Styles */
            .footer {
                background: rgba(29, 29, 27, 0.95);
                backdrop-filter: blur(10px);
                color: #f5f5f5;
                padding: 40px 0;
                margin-top: 60px;
                border-top: 2px solid rgba(218, 165, 32, 0.3);
            }

            .footer .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 15px;
            }

            .footer-col {
                margin-bottom: 30px;
            }

            .footer-logo {
                width: 120px;
                margin-bottom: 20px;
                filter: brightness(1.2);
            }

            .footer-title {
                font-size: 1.2rem;
                font-weight: 600;
                color: #DAA520;
                margin-bottom: 20px;
            }

            .footer-links {
                list-style: none;
                padding: 0;
            }

            .footer-links li {
                margin-bottom: 10px;
            }

            .footer-links a {
                color: #cccccc;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .footer-links a:hover {
                color: #DAA520;
            }

            .footer-contact p {
                color: #cccccc;
                margin-bottom: 8px;
                display: flex;
                align-items: flex-start;
            }

            .footer-contact i {
                margin-right: 10px;
                color: #DAA520;
                font-size: 1.1em;
                flex-shrink: 0;
            }

            .footer-bottom {
                border-top: 1px solid rgba(255, 255, 255, 0.1);
                padding-top: 20px;
                margin-top: 20px;
                color: #999999;
                font-size: 0.9rem;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .section-title {
                    font-size: 2rem;
                }

                .profile-header {
                    padding: 1.5rem;
                }

                .profile-avatar {
                    width: 100px;
                    height: 100px;
                }

                .profile-name {
                    font-size: 1.5rem;
                }

                .profile-body {
                    padding: 1.5rem;
                }

                .profile-actions {
                    flex-direction: column;
                    align-items: center;
                }

                .btn-primary {
                    width: 100%;
                    max-width: 250px;
                    justify-content: center;
                }

                .footer-col {
                    text-align: center;
                }

                .footer-contact p {
                    justify-content: center;
                }

                .footer-logo {
                    margin-left: auto;
                    margin-right: auto;
                }

                .sidebar {
                    transform: translateX(-100%);
                }

                .sidebar.active {
                    transform: translateX(0);
                }

                .main-content {
                    margin-left: 0; /* Full width when sidebar is hidden */
                    padding-top: 20px; /* Adjust padding for mobile */
                }

                .mobile-menu-btn {
                    display: block; /* Show on small screens */
                }

                .info-grid {
                    grid-template-columns: 1fr; /* Single column on mobile */
                }
            }

            @media (min-width: 769px) {
                .info-grid {
                    grid-template-columns: repeat(2, 1fr); /* Two columns on larger screens */
                }
            }
        </style>
    </head>
    <body>
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <%-- Navbar (copied directly from provided profileOfStaff.jsp) --%>
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
                            <span class="me-3" style="color: #FF9900"> Nhân viên: <strong><c:out value="${sessionScope.staff.lastName} ${sessionScope.staff.firstName}"/></strong></span>
                        </div>
                        <a class="btn btn-warning" href="${pageContext.request.contextPath}/logout" onclick="return confirm('Bạn có chắc chắn muốn đăng xuất?')" aria-label="Đăng xuất">
                            <i class="fas fa-sign-out-alt me-1"></i>
                            Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <button class="mobile-menu-btn" onclick="toggleSidebar()" aria-label="Mở/đóng menu">
            <i class="fas fa-bars"></i>
        </button>

        <div class="dashboard-layout">
            <%-- Sidebar (copied directly from provided profileOfStaff.jsp) --%>
            <nav class="sidebar" id="sidebar" aria-label="Menu điều hướng">
                <div class="sidebar-header">
                    <div class="logo"><i class="fas fa-cut"></i></div>
                    <div class="logo-text">BarberShop Pro</div>
                    <div class="logo-subtitle">Staff Dashboard</div>
                </div>
                <div class="nav-menu">
                    <div class="nav-item"><a href="${pageContext.request.contextPath}/views/staff/registerForAShift.jsp" class="nav-link" aria-label="Đăng ký lịch làm việc"><i class="fas fa-calendar-alt"></i><span>Đăng ký Lịch Làm</span></a></div>
                    <div class="nav-item"><a href="${pageContext.request.contextPath}/StaffAppointment" class="nav-link" aria-label="Lịch hẹn của tôi"><i class="fas fa-clock"></i><span>Lịch Hẹn của Tôi</span></a></div>
                    <div class="nav-item"><a href="${pageContext.request.contextPath}/profile" class="nav-link active" aria-label="Thông tin cá nhân"><i class="fas fa-user"></i><span>Thông Tin Cá Nhân</span></a></div>
                </div>
            </nav>

            <main class="main-content" aria-label="Nội dung chính">
                <%-- Main profile content starts here --%>
                <div class="container mt-5">
                    <h2 class="section-title">Thông tin nhân viên</h2>

                    <div class="profile-container">
                        <div class="profile-card">
                            <div class="profile-header">
                                <div class="profile-avatar ${empty sessionScope.img ? 'no-image' : ''}">
                                    <c:if test="${not empty sessionScope.staff.img}">
                                        <img src="${pageContext.request.contextPath}/${sessionScope.staff.img}" alt="Staff Avatar">
                                    </c:if>
                                    <c:if test="${empty sessionScope.staff.img}">
                                        <i class="fas fa-user"></i>
                                    </c:if>
                                </div>
                                <div class="profile-name">
                                    <c:out value="${sessionScope.staff.lastName} ${sessionScope.staff.firstName}"/>
                                </div>
                                <div class="profile-role">Nhân viên</div>
                            </div>

                            <div class="profile-body">
                                <div class="profile-actions">
                                    <a href="${pageContext.request.contextPath}/views/staff/editStaffProfile.jsp" class="btn btn-primary">
                                        <i class="fas fa-edit"></i> Chỉnh sửa thông tin
                                    </a>
                                </div>

                                <div class="info-grid">
                                    
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-user"></i>
                                            Họ và tên
                                        </div>
                                        <div class="info-value">
                                            <c:out value="${sessionScope.staff.lastName} ${sessionScope.staff.firstName}"/>
                                        </div>
                                    </div>

                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-envelope"></i>
                                            Email
                                        </div>
                                        <div class="info-value"><c:out value="${sessionScope.staff.email}"/></div>
                                    </div>

                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-phone"></i>
                                            Số điện thoại
                                        </div>
                                        <div class="info-value"><c:out value="${sessionScope.staff.phoneNumber}"/></div>
                                    </div>

                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-map-marker-alt"></i>
                                            Chi nhánh
                                        </div>
                                        <div class="info-value">
                                            <c:out value="${sessionScope.branchName}"/>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- Main profile content ends here --%>
            </main>
        </div>

        <%-- Footer (copied directly from provided profileOfStaff.jsp) --%>
        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-6 footer-col">
                        <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Cut&Styles Logo" class="footer-logo">                     
                    </div>

                    <div class="col-lg-4 col-md-6 footer-col">
                        <h4 class="footer-title">Liên kết nhanh</h4>
                        <ul class="footer-links">
                            <li><a href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/common/franchise.jsp">Liên hệ nhượng quyền</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/commit/details.jsp">Chính sách cam kết</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-4 col-md-6 footer-col">
                        <h4 class="footer-title">Thông tin liên hệ</h4>
                        <div class="footer-contact">
                            <p><i class="bi bi-geo-alt-fill"></i> <span>Khu đô thị FPT city, Hòa Hải, Ngũ Hành Sơn, Đà Nẵng</span></p>
                            <p><i class="bi bi-telephone-fill"></i> <span>Liên hệ học nghề tóc: 0774511941</span></p>
                            <p><i class="bi bi-clock-fill"></i> <span>Giờ phục vụ: Thứ 2 đến Chủ Nhật, 8h30 - 20h30</span></p>
                        </div>
                    </div>
                </div>

                <div class="row footer-bottom">
                    <div class="col-12 text-center">
                        <p>&copy; 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
                    </div>
                </div>
            </div>
        </footer>
        
        <script>
            // JavaScript for toggling sidebar on mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                if (sidebar) {
                    sidebar.classList.toggle('active');
                }
            }

            // Highlight active link in sidebar based on current page URL
            document.addEventListener('DOMContentLoaded', function() {
                const currentPath = window.location.pathname;
                const navLinks = document.querySelectorAll('.sidebar .nav-link');
                navLinks.forEach(link => {
                    // Check if the link's href matches the current path exactly
                    // or if the current path includes '/profile' AND the link's href includes '/profile'
                    // This is to handle cases where '/profile' might map to multiple JSPs like 'profile.jsp' or 'profileOfStaff.jsp'
                    if (link.getAttribute('href') && (link.getAttribute('href') === currentPath ||
                        (currentPath.includes('/profile') && link.getAttribute('href').includes('/profile')))) {
                        link.classList.add('active');
                    } else {
                        link.classList.remove('active');
                    }
                });
            });
        </script>
    </body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Lịch - Admin Barbershop</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <style>
            .modal-dialog {
                margin-top: 80px !important; /* tránh che bởi navbar */
            }

            .modal-content {
                max-height: 90vh;
                overflow-y: auto;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                background-color: #fff;
            }

            .modal-body label {
                font-weight: 500;
                color: #333;
                margin-bottom: 5px;
                display: block;
            }

            .modal-body input,
            .modal-body select {
                width: 100%;
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #ccc;
                margin-bottom: 15px;
                font-size: 15px;
            }

            .modal-footer .btn {
                padding: 8px 16px;
                font-weight: 500;
                border-radius: 8px;
            }
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

            .custom-navbar .btn-outline-warning {
                border-color: #DAA520;
                color: #DAA520;
                font-weight: 500;
                padding: 8px 16px;
                border-radius: 25px;
                transition: all 0.3s ease;
            }

            .custom-navbar .btn-outline-warning:hover {
                background-color: #DAA520;
                border-color: #DAA520;
                color: #1d1d1b;
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
                background: linear-gradient(rgba(29, 24, 27, 0.7), rgba(29, 29, 27, 0.7)),
                    url('https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80');
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
                color: #ccc;
                font-size: 0.9rem;
            }

            .schedule-container {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 10px;
                padding: 15px;
                border: 1px solid rgba(218, 165, 32, 0.2);
                margin-bottom: 15px;
            }

            .control-tabs {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }

            .tab-btn {
                background: rgba(218, 165, 32, 0.1);
                border: 1px solid rgba(218, 165, 32, 0.3);
                color: #DAA520;
                padding: 10px 20px;
                border-radius: 6px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 0.9rem;
            }

            .tab-btn.active {
                background: linear-gradient(45deg, #DAA520, #B8860B);
                color: #1d1d1b;
                font-weight: 600;
            }

            .tab-btn:hover:not(.active) {
                background: rgba(218, 165, 32, 0.2);
            }

            .tab-content {
                display: none;
            }

            .tab-content.active {
                display: block;
            }

            .month-selector {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-bottom: 15px;
                gap: 10px;
            }

            .month-nav-btn {
                background: rgba(218, 165, 32, 0.2);
                border: 1px solid rgba(218, 165, 32, 0.3);
                color: #DAA520;
                padding: 8px 12px;
                border-radius: 6px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 0.9rem;
            }

            .month-nav-btn:hover {
                background: rgba(218, 165, 32, 0.3);
                transform: translateY(-2px);
            }

            .current-month {
                font-size: 1.2rem;
                font-weight: 600;
                color: #DAA520;
                min-width: 150px;
                text-align: center;
            }

            .calendar-grid {
                display: grid;
                grid-template-columns: repeat(7, 1fr);
                gap: 5px;
                margin-bottom: 15px;
            }

            .calendar-header {
                text-align: center;
                padding: 8px 5px;
                font-weight: 600;
                color: #DAA520;
                background: rgba(218, 165, 32, 0.1);
                border-radius: 6px;
                font-size: 0.8rem;
            }

            .calendar-day {
                aspect-ratio: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 6px;
                cursor: pointer;
                transition: all 0.3s ease;
                position: relative;
                font-weight: 500;
                border: 2px solid transparent;
                font-size: 0.9rem;
            }

            .calendar-day:not(.disabled):not(.other-month) {
                background: rgba(255, 255, 255, 0.05);
                color: #fff;
            }

            .calendar-day:not(.disabled):not(.other-month):hover {
                background: rgba(218, 165, 32, 0.2);
                transform: scale(1.05);
            }

            .calendar-day.holiday-locked {
                background: rgba(255, 87, 34, 0.6) !important;
                color: #FF5722 !important;
                font-weight: bold;
                border: 2px solid #FF5722;
            }

            .calendar-day.holiday-unlocked {
                background: rgba(76, 175, 80, 0.4) !important;
                color: #4CAF50 !important;
                font-weight: bold;
                border: 2px solid #4CAF50;
            }


            .calendar-day.disabled {
                background: rgba(158, 158, 158, 0.2);
                color: #9E9E9E;
                cursor: not-allowed;
            }

            .calendar-day.other-month {
                color: #666;
                cursor: not-allowed;
            }

            .calendar-day:focus {
                outline: 2px solid #DAA520;
                outline-offset: 2px;
            }

            .day-indicator {
                position: absolute;
                top: -4px;
                right: -4px;
                background: #F44336;
                color: white;
                border-radius: 50%;
                font-size: 0.6rem;
                min-width: 14px;
                height: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 600;
            }

            .info-cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 15px;
                margin-bottom: 15px;
            }

            .info-card {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 10px;
                padding: 15px;
                border: 1px solid rgba(218, 165, 32, 0.2);
                text-align: center;
            }

            .info-card h3 {
                color: #DAA520;
                font-size: 1rem;
                margin-bottom: 8px;
            }

            .info-card .value {
                font-size: 1.5rem;
                font-weight: 600;
                margin-bottom: 5px;
            }

            .info-card .description {
                color: #ccc;
                font-size: 0.8rem;
            }

            .staff-schedule-section {
                margin-top: 20px;
            }

            .staff-card {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 10px;
                padding: 15px;
                border: 1px solid rgba(218, 165, 32, 0.2);
                margin-bottom: 15px;
            }

            .staff-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
            }

            .staff-info {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .staff-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: linear-gradient(45deg, #DAA520, #B8860B);
                display: flex;
                align-items: center;
                justify-content: center;
                color: #1d1d1b;
                font-weight: 600;
            }

            .time-slots {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
                gap: 8px;
            }

            .time-slot {
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(218, 165, 32, 0.2);
                color: #fff;
                padding: 8px 12px;
                border-radius: 6px;
                cursor: pointer;
                transition: all 0.3s ease;
                text-align: center;
                font-size: 0.85rem;
            }

            .time-slot:hover {
                background: rgba(218, 165, 32, 0.2);
            }

            .time-slot.booked {
                background: rgba(244, 67, 54, 0.3);
                color: #F44336;
                cursor: not-allowed;
            }

            .time-slot:focus {
                outline: 2px solid #DAA520;
                outline-offset: 2px;
            }

            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 0.9rem;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }

            .btn-primary {
                background: linear-gradient(45deg, #DAA520, #B8860B);
                color: #1d1d1b;
                font-weight: 600;
            }

            .btn-primary:hover:not(:disabled) {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(218, 165, 32, 0.4);
            }

            .btn-secondary {
                background: rgba(218, 165, 32, 0.1);
                color: #DAA520;
                border: 1px solid rgba(218, 165, 32, 0.3);
            }

            .btn-secondary:hover {
                background: rgba(218, 165, 32, 0.2);
            }

            .btn-danger {
                background: rgba(244, 67, 54, 0.2);
                color: #F44336;
                border: 1px solid rgba(244, 67, 54, 0.3);
            }

            .btn-danger:hover {
                background: rgba(244, 67, 54, 0.3);
            }

            .btn-success {
                background: rgba(76, 175, 80, 0.2);
                color: #4CAF50;
                border: 1px solid rgba(76, 175, 80, 0.3);
            }

            .btn-success:hover {
                background: rgba(76, 175, 80, 0.3);
            }

            .legend {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                justify-content: center;
                margin-bottom: 15px;
            }

            .legend-item {
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 0.8rem;
            }

            .legend-color {
                width: 16px;
                height: 16px;
                border-radius: 3px;
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

            .action-buttons {
                display: flex;
                gap: 10px;
                justify-content: center;
                flex-wrap: wrap;
                margin-top: 15px;
            }

            .modal {
                color: #000;
            }

            .modal-content {
                background: #fff;
            }

            .holiday-input {
                margin-bottom: 15px;
            }

            .holiday-input input, .holiday-input select {
                background: rgba(255, 255, 255, 0.9);
                border: 1px solid #ddd;
                border-radius: 6px;
                padding: 10px;
                width: 100%;
            }

            .holiday-list {
                max-height: 200px;
                overflow-y: auto;
            }

            .holiday-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 8px 12px;
                background: rgba(218, 165, 32, 0.1);
                border-radius: 6px;
                margin-bottom: 8px;
            }

            .staff-select {
                background: rgba(255, 255, 255, 0.9);
                border: 1px solid #DAA520;
                border-radius: 6px;
                padding: 10px;
                width: 100%;
                color: #1d1d1b;
            }

            .loading-spinner {
                display: none;
                border: 4px solid #f3f3f3;
                border-top: 4px solid #DAA520;
                border-radius: 50%;
                width: 24px;
                height: 24px;
                animation: spin 1s linear infinite;
                margin: 0 auto;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }

            .toast {
                position: fixed;
                bottom: 15px;
                right: 15px;
                min-width: 200px;
                z-index: 2000;
                display: none;
                background: rgba(29, 29, 27, 0.9);
                color: #fff;
                padding: 15px;
                border-radius: 6px;
                border: 1px solid rgba(218, 165, 32, 0.3);
            }

            .toast.show {
                display: block;
                animation: fadeIn 0.5s, fadeOut 0.5s 2.5s;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(15px);
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
                    transform: translateY(15px);
                }
            }

            @media (max-width: 768px) {
                .mobile-menu-btn {
                    display: block;
                }

                .sidebar {
                    width: 80%;
                    transform: translateX(-100%);
                }

                .sidebar.active {
                    transform: translateX(0);
                }

                .main-content {
                    margin-left: 0;
                    padding: 60px 15px 15px;
                }

                .header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }

                .control-tabs {
                    flex-direction: column;
                }

                .month-selector {
                    flex-direction: column;
                    gap: 10px;
                }

                .current-month {
                    font-size: 1rem;
                }

                .calendar-grid {
                    gap: 3px;
                }

                .calendar-day {
                    font-size: 0.9rem;
                }

                .info-cards {
                    grid-template-columns: 1fr;
                }

                .time-slots {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg custom-navbar border-bottom shadow-sm">
            <div class="container-fluid px-4">
                <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                    <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Logo Barbershop" width="55" height="55" class="me-2">
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <div class="d-flex gap-2 align-items-center">
                        <div class="text-warning d-none d-lg-block me-3">
                            <i class="fas fa-user-shield me-1"></i>
                            <span class="me-3" style="color: #FF9900"> Admin: <strong>${sessionScope.account.email}</strong></span>
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
            <nav class="sidebar" id="sidebar" aria-label="Menu điều hướng">
                <div class="sidebar-header">
                    <div class="logo">
                        <Avatar class="fas fa-cut"></Avatar>
                    </div>
                    <div class="logo-text">BarberShop Admin</div>
                    <div class="logo-subtitle">Schedule Management</div>
                </div>
                <div class="nav-menu">
                    <div class="nav-item">
                        <a href="${pageContext.request.contextPath}/views/admin/dashboard.jsp" class="nav-link">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/view-customers" class="nav-link">
                            <i class="fas fa-users"></i>
                            <span>Quản lý Khách hàng</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/view-staff" class="nav-link ">
                            <i class="fas fa-user-tie"></i>
                            <span>Quản lý Nhân viên</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="${pageContext.request.contextPath}/AppointmentManagerServlet" class="nav-link">
                            <i class="fas fa-calendar-check"></i>
                            <span>Quản lý Lịch hẹn</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="${pageContext.request.contextPath}/views/admin/feedbackManagement.jsp" class="nav-link">
                            <i class="fas fa-comments"></i>
                            <span>Quản lý Phản hồi</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="${pageContext.request.contextPath}/views/admin/serviceManagement.jsp" class="nav-link">
                            <i class="fas fa-store"></i>
                            <span>Quản lý Dịch Vụ</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="${pageContext.request.contextPath}/views/admin/voucherManagement.jsp" class="nav-link">
                            <i class="fas fa-ticket-alt"></i>
                            <span>Quản lý Voucher</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="${pageContext.request.contextPath}/RevenueManagementServlet class="nav-link">
                            <i class="fas fa-chart-line"></i>
                            <span>Quản lý Doanh thu</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="${pageContext.request.contextPath}/ViewScheduleServlet" class="nav-link">
                            <i class="fas fa-calendar"></i>
                            <span>Lịch làm nhân viên</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="${pageContext.request.contextPath}/views/admin/Holiday.jsp" class="nav-link">
                            <i class="fas fa-calendar"></i>
                            <span>Quản lí ngày nghỉ</span>
                        </a>
                    </div>
                </div>
            </nav>

            <main class="main-content" aria-label="Nội dung chính">
                <div class="header">
                    <div>
                        <h1><i class="fas fa-calendar-edit"></i> Quản Lý Ngày Nghỉ</h1>
                        <p>Quản lý ngày lễ, ngày nghỉ của Barbershop </p>
                    </div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addHolidayModal">
                        <i class="fas fa-plus"></i> Thêm Ngày Lễ
                    </button>
                </div>

                <div class="info-cards">
                    <div class="info-card">
                        <h3>Ngày Lễ Đã Khóa</h3>
                        <div class="value" style="color: #F44336;" id="lockedHolidaysCount">0</div>
                        <div class="description">Ngày trong tháng </div>
                    </div>

                    <div class="info-card">
                        <h3>Tháng Hiện Tại</h3>
                        <div class="value" id="currentMonthDisplay">--</div>
                        <div class="description">Đang quản lý</div>
                    </div>
                </div>

                <div class="schedule-container">
                    <div class="control-tabs">
                        
                        
                    </div>

                    <!-- Tab Quản lý Ngày Lễ -->
                    <div class="tab-content active" id="holidaysContent">
                        <div class="month-selector">
                            <button class="month-nav-btn" onclick="previousMonth()" aria-label="Tháng trước">
                                <i class="fas fa-chevron-left"></i> Tháng Trước
                            </button>
                            <div class="current-month" id="monthYear"></div>
                            <button class="month-nav-btn" onclick="nextMonth()" aria-label="Tháng sau">
                                Tháng Sau <i class="fas fa-chevron-right"></i>
                            </button>
                        </div>

                        <div class="legend" aria-label="Chú thích lịch">
                            <div class="legend-item">
                                <div class="legend-color" style="background: rgba(255, 255, 255, 0.05);"></div>
                                <span>Ngày bình thường</span>
                            </div>
                            <div class="legend-item">
                                <div class="legend-color" style="background: rgba(255, 87, 34, 0.3);"></div>
                                <span>Ngày lễ đã khóa</span>
                            </div>
                            <div class="legend-item">
                                <div class="legend-color" style="background: rgba(76, 175, 80, 0.3);"></div>
                                <span>Ngày lễ đã mở khóa</span>
                            </div>
                        </div>

                        <div class="calendar-grid" id="calendarGrid" role="grid" aria-label="Lịch tháng"></div>

                        <div class="holiday-list" id="holidayList" aria-label="Danh sách ngày lễ"></div>


                        <div class="loading-spinner" id="holidaySpinner"></div>
                    </div>

                    <!-- Tab Quản lý Lịch Staff -->
                    <div class="tab-content" id="staffContent">
                        <div class="staff-schedule-section">
                            <div class="legend" aria-label="Chú thích lịch nhân viên">
                                <div class="legend-item">
                                    <div class="legend-color" style="background: rgba(255, 255, 255, 0.05);"></div>
                                    <span>Khung giờ có sẵn</span>
                                </div>
                                <div class="legend-item">
                                    <div class="legend-color" style="background: rgba(244, 67, 54, 0.3);"></div>
                                    <span>Khung giờ đã đặt</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="schedule-container">
                                        <h5 style="color: #DAA520; margin-bottom: 15px;">
                                            <i class="fas fa-calendar-day"></i> Chọn Ngày
                                        </h5>
                                        <input type="date" class="form-control" id="staffScheduleDate" 
                                               style="background: rgba(255, 255, 255, 0.9); border: 1px solid #DAA520;">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="schedule-container">
                                        <h5 style="color: #DAA520; margin-bottom: 15px;">
                                            <i class="fas fa-user"></i> Chọn Nhân Viên
                                        </h5>
                                        <select class="staff-select" id="staffSelect">
                                            <option value="">Chọn nhân viên</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div id="staffScheduleList"></div>
                            <div class="loading-spinner" id="staffSpinner"></div>
                        </div>
                    </div>
                </div>

                <!-- Add/Edit Holiday Modal -->
                <div class="modal fade" id="addHolidayModal" tabindex="-1" aria-labelledby="addHolidayModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addHolidayModalLabel">Thêm Ngày Lễ</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                            </div>
                            <div class="modal-body">
                                <div class="holiday-input">
                                    <label for="holidayDate">Ngày</label>
                                    <input type="date" id="holidayDate" required>
                                </div>
                                <div class="holiday-input">
                                    <label for="holidayName">Tên ngày lễ</label>
                                    <input type="text" id="holidayName" placeholder="Nhập tên ngày lễ" required>
                                </div>
                                <div class="holiday-input">
                                    <label for="holidayStatus">Trạng thái</label>
                                    <select id="holidayStatus">
                                        <option value="locked">Khóa</option>
                                        <option value="unlocked">Mở khóa</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="button" class="btn btn-primary" onclick="saveHoliday()">Lưu</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Toast Notification -->
                <div class="toast" id="toastNotification">
                    <span id="toastMessage"></span>
                </div>
            </main>
        </div>
        <script>
            window.addEventListener("DOMContentLoaded", () => {
                const originalFetchHolidays = fetchHolidays;
                fetchHolidays = async function () {
                    try {
                        const res = await fetch(`${contextPath}/api/holidays`);
                        holidays = await res.json();
                        console.log("Dữ liệu ngày lễ:", holidays);
                        renderCalendar();
                        renderHolidayList(); // Gọi hiển thị danh sách
                        updateInfoCards();
                    } catch (err) {
                        console.error("Lỗi khi tải danh sách ngày lễ:", err);
                    }
                }

                // Gọi lại sau khi override xong
                fetchHolidays();
            });
        </script>

        <script src="${pageContext.request.contextPath}/js/schedule.js"></script>
    </body>
</html>
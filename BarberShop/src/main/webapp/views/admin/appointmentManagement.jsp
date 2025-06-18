<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Lịch hẹn - Barbershop Admin</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
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

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
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
                padding: 30px;
            }

            .header {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 25px 30px;
                margin-bottom: 30px;
                border: 1px solid rgba(218, 165, 32, 0.2);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .header h1 {
                font-size: 2.2rem;
                color: #DAA520;
                margin-bottom: 8px;
            }

            .header p {
                color: #ccc;
                font-size: 1rem;
            }

            .header-actions {
                display: flex;
                gap: 15px;
            }

            .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-size: 0.9rem;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-primary {
                background: linear-gradient(45deg, #DAA520, #B8860B);
                color: #1d1d1b;
                font-weight: 600;
            }

            .btn-primary:hover {
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

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stats-card {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 25px;
                border: 1px solid rgba(218, 165, 32, 0.2);
                display: flex;
                align-items: center;
                gap: 20px;
                transition: transform 0.3s ease;
            }

            .stats-card:hover {
                transform: translateY(-5px);
            }

            .stats-icon {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
            }

            .stats-info h3 {
                font-size: 2rem;
                font-weight: 700;
                color: #fff;
                margin-bottom: 5px;
            }

            .stats-info p {
                color: #ccc;
                font-size: 0.9rem;
            }

            .search-section {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 25px;
                border: 1px solid rgba(218, 165, 32, 0.2);
            }

            .search-row {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                align-items: end;
            }

            .search-group {
                display: flex;
                flex-direction: column;
            }

            .search-group label {
                color: #DAA520;
                margin-bottom: 8px;
                font-weight: 600;
                font-size: 0.9rem;
            }

            .search-input, .search-select {
                padding: 12px 15px;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(218, 165, 32, 0.3);
                border-radius: 8px;
                color: #fff;
                font-size: 0.9rem;
            }

            .search-input:focus, .search-select:focus {
                outline: none;
                border-color: #DAA520;
                box-shadow: 0 0 0 2px rgba(218, 165, 32, 0.2);
            }

            .search-input::placeholder {
                color: #999;
            }

            .table-container {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 25px;
                border: 1px solid rgba(218, 165, 32, 0.2);
                overflow-x: auto;
            }

            .table-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                flex-wrap: wrap;
                gap: 15px;
            }

            .table-title {
                font-size: 1.3rem;
                color: #DAA520;
                font-weight: 600;
            }

            .table-info {
                color: #ccc;
                font-size: 0.9rem;
            }

            .appointment-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
                min-width: 800px;
            }

            .appointment-table th,
            .appointment-table td {
                padding: 15px 12px;
                text-align: left;
                border-bottom: 1px solid rgba(218, 165, 32, 0.1);
            }

            .appointment-table th {
                background: rgba(218, 165, 32, 0.1);
                color: #DAA520;
                font-weight: 600;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .appointment-table td {
                color: #fff;
                font-size: 0.9rem;
            }

            .appointment-table tbody tr {
                transition: all 0.3s ease;
            }

            .appointment-table tbody tr:hover {
                background: rgba(218, 165, 32, 0.05);
            }

            .appointment-id {
                font-family: 'Courier New', monospace;
                color: #DAA520;
                font-weight: 600;
            }

            .customer-info {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .customer-avatar {
                width: 35px;
                height: 35px;
                border-radius: 50%;
                background: linear-gradient(45deg, #DAA520, #B8860B);
                display: flex;
                align-items: center;
                justify-content: center;
                color: #1d1d1b;
                font-weight: 600;
                font-size: 0.8rem;
            }

            .service-list {
                max-width: 200px;
            }

            .service-item {
                background: rgba(218, 165, 32, 0.1);
                padding: 2px 8px;
                border-radius: 12px;
                font-size: 0.8rem;
                margin: 2px;
                display: inline-block;
                border: 1px solid rgba(218, 165, 32, 0.3);
            }

            .datetime-info {
                text-align: center;
            }

            .date-display {
                font-weight: 600;
                color: #DAA520;
                margin-bottom: 3px;
            }

            .time-display {
                font-size: 0.8rem;
                color: #ccc;
            }

            .badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .badge-pending {
                background: rgba(255, 193, 7, 0.2);
                color: #FFC107;
                border: 1px solid rgba(255, 193, 7, 0.3);
            }

            .badge-confirmed {
                background: rgba(76, 175, 80, 0.2);
                color: #4CAF50;
                border: 1px solid rgba(76, 175, 80, 0.3);
            }

            .badge-completed {
                background: rgba(33, 150, 243, 0.2);
                color: #2196F3;
                border: 1px solid rgba(33, 150, 243, 0.3);
            }

            .badge-cancelled {
                background: rgba(244, 67, 54, 0.2);
                color: #f44336;
                border: 1px solid rgba(244, 67, 54, 0.3);
            }

            .action-buttons {
                display: flex;
                gap: 8px;
                flex-wrap: wrap;
            }

            .btn-action {
                padding: 6px 12px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 0.8rem;
                transition: all 0.3s ease;
            }

            .btn-view {
                background: rgba(33, 150, 243, 0.2);
                color: #2196F3;
                border: 1px solid rgba(33, 150, 243, 0.3);
            }

            .btn-confirm {
                background: rgba(76, 175, 80, 0.2);
                color: #4CAF50;
                border: 1px solid rgba(76, 175, 80, 0.3);
            }

            .btn-cancel {
                background: rgba(244, 67, 54, 0.2);
                color: #f44336;
                border: 1px solid rgba(244, 67, 54, 0.3);
            }

            .btn-edit {
                background: rgba(255, 152, 0, 0.2);
                color: #FF9800;
                border: 1px solid rgba(255, 152, 0, 0.3);
            }

            .btn-action:hover {
                transform: translateY(-1px);
            }

            .mobile-menu-btn {
                display: none;
                position: fixed;
                top: 20px;
                left: 20px;
                z-index: 1001;
                background: rgba(29, 29, 27, 0.9);
                color: #DAA520;
                border: none;
                padding: 10px;
                border-radius: 5px;
                font-size: 1.2rem;
            }

            .modal-content {
                background: rgba(29, 29, 27, 0.95);
                border: 1px solid rgba(218, 165, 32, 0.3);
                border-radius: 15px;
            }

            .modal-header {
                border-bottom: 1px solid rgba(218, 165, 32, 0.2);
                color: #DAA520;
            }

            .modal-body {
                color: #fff;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                color: #DAA520;
                font-weight: 600;
                margin-bottom: 8px;
                display: block;
            }

            .form-control {
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(218, 165, 32, 0.3);
                border-radius: 8px;
                color: #fff;
                padding: 12px 15px;
            }

            .form-control:focus {
                background: rgba(255, 255, 255, 0.1);
                border-color: #DAA520;
                box-shadow: 0 0 0 2px rgba(218, 165, 32, 0.2);
                color: #fff;
            }

            .form-control::placeholder {
                color: #999;
            }

            .detail-section {
                background: rgba(255, 255, 255, 0.05);
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 15px;
            }

            .detail-title {
                color: #DAA520;
                font-weight: 600;
                margin-bottom: 10px;
                font-size: 1rem;
            }

            .service-detail {
                display: flex;
                justify-content: space-between;
                padding: 8px 0;
                border-bottom: 1px solid rgba(218, 165, 32, 0.1);
            }

            .service-detail:last-child {
                border-bottom: none;
            }

            @media (max-width: 768px) {
                .mobile-menu-btn {
                    display: block;
                }

                .sidebar {
                    transform: translateX(-100%);
                }

                .sidebar.active {
                    transform: translateX(0);
                }

                .main-content {
                    margin-left: 0;
                    padding: 80px 20px 20px;
                }

                .header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 15px;
                }

                .header-actions {
                    width: 100%;
                    justify-content: flex-start;
                }

                .stats-grid {
                    grid-template-columns: 1fr;
                }

                .search-row {
                    grid-template-columns: 1fr;
                }

                .table-container {
                    padding: 15px;
                }

                .appointment-table {
                    font-size: 0.8rem;
                }

                .appointment-table th,
                .appointment-table td {
                    padding: 10px 8px;
                }

                .action-buttons {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg custom-navbar border-bottom shadow-sm">
            <div class="container-fluid px-4">
                <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                    <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Logo" width="55" height="55" class="me-2">
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <div class="d-flex gap-2 align-items-center">
                        <div class="text-warning d-none d-lg-block me-3">
                            <i class="fas fa-user-shield me-1"></i>
                            <span>${sessionScope.admin.lastName} ${sessionScope.admin.firstName}</span>
                        </div>
                        <a class="btn btn-warning" href="${pageContext.request.contextPath}/logout" onclick="return confirm('Bạn có chắc chắn muốn đăng xuất?')">
                            <i class="fas fa-sign-out-alt me-1"></i>
                            Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <button class="mobile-menu-btn" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>

        <div class="dashboard-layout">
            <nav class="sidebar" id="sidebar">
                <div class="sidebar-header">
                    <div class="logo">
                        <i class="fas fa-cut"></i>
                    </div>
                    <div class="logo-text">Cut & Style</div>
                    <div class="logo-subtitle">Admin Dashboard</div>
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
                        <a href="${pageContext.request.contextPath}/views/admin/appointmentManagement.jsp" class="nav-link">
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
                        <a href="${pageContext.request.contextPath}/views/admin/franchiseManagement.jsp" class="nav-link">
                            <i class="fas fa-handshake"></i>
                            <span>Quản lý Nhượng quyền</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="${pageContext.request.contextPath}/views/admin/revenueManagement.jsp" class="nav-link">
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

            <main class="main-content">
                <div class="header">
                    <div>
                        <h1><i class="fas fa-calendar-check"></i> Quản lý Lịch hẹn</h1>
                        <p>Theo dõi và quản lý tất cả các lịch hẹn của khách hàng</p>
                    </div>
                    <div class="header-actions">
                        <button class="btn btn-secondary" onclick="exportAppointments()">
                            <i class="fas fa-file-excel"></i>
                            Xuất Excel
                        </button>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addAppointmentModal">
                            <i class="fas fa-plus"></i>
                            Tạo lịch hẹn
                        </button>
                    </div>
                </div>

                <div class="stats-grid">
                    <div class="stats-card">
                        <div class="stats-icon" style="background: rgba(255, 193, 7, 0.2);">
                            <i class="fas fa-clock" style="color: #FFC107;"></i>
                        </div>
                        <div class="stats-info">
                            <h3 id="pendingCount">0</h3>
                            <p>Chờ xác nhận</p>
                        </div>
                    </div>
                    <div class="stats-card">
                        <div class="stats-icon" style="background: rgba(76, 175, 80, 0.2);">
                            <i class="fas fa-check-circle" style="color: #4CAF50;"></i>
                        </div>
                        <div class="stats-info">
                            <h3 id="confirmedCount">0</h3>
                            <p>Đã xác nhận</p>
                        </div>
                    </div>
                    <div class="stats-card">
                        <div class="stats-icon" style="background: rgba(33, 150, 243, 0.2);">
                            <i class="fas fa-calendar-check" style="color: #2196F3;"></i>
                        </div>
                        <div class="stats-info">
                            <h3 id="todayCount">0</h3>
                            <p>Hôm nay</p>
                        </div>
                    </div>
                    <div class="stats-card">
                        <div class="stats-icon" style="background: rgba(218, 165, 32, 0.2);">
                            <i class="fas fa-dollar-sign" style="color: #DAA520;"></i>
                        </div>
                        <div class="stats-info">
                            <h3 id="totalAmount">0</h3>
                            <p>Tổng doanh thu</p>
                        </div>
                    </div>
                </div>

                <div class="search-section">
                    <div class="search-row">
                        <div class="search-group">
                            <label>Tìm kiếm khách hàng</label>
                            <input type="text" id="searchCustomer" class="search-input" placeholder="Nhập tên khách hàng">
                        </div>
                        <div class="search-group">
                            <label>Trạng thái</label>
                            <select id="searchStatus" class="search-select">
                                <option value="">Tất cả</option>
                                <option value="pending">Chờ xác nhận</option>
                                <option value="confirmed">Đã xác nhận</option>
                                <option value="completed">Hoàn thành</option>
                                <option value="cancelled">Đã hủy</option>
                            </select>
                        </div>
                        <div class="search-group">
                            <label>Ngày</label>
                            <input type="date" id="searchDate" class="search-input">
                        </div>
                        <div class="search-group">
                            <button class="btn btn-primary" onclick="searchAppointments()">
                                <i class="fas fa-search"></i>
                                Tìm kiếm
                            </button>
                        </div>
                    </div>
                </div>

                <div class="table-container">
                    <div class="table-header">
                        <div>
                            <div class="table-title">Danh sách Lịch hẹn</div>
                            <div class="table-info" id="tableInfo">Hiển thị ${fn:length(listAppointment)} lịch hẹn</div>
                        </div>
                        <div class="header-actions">
                            <button class="btn btn-secondary" onclick="resetFilters()">
                                <i class="fas fa-sync-alt"></i>
                                Đặt lại
                            </button>
                        </div>
                    </div>
                    <table class="appointment-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Khách hàng</th>
                                <th>Dịch vụ</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody id="appointmentTableBody">
                            <c:forEach var="appointment" items="${listAppointment}">
                                <tr data-date-time="<fmt:formatDate value="${appointment.appointmentTime}" pattern="yyyy-MM-dd'T'HH:mm"/>">
                                    <td class="appointment-id">${appointment.id}</td>
                                    <td class="customer-info">
                                        <div class="customer-avatar">${fn:substring(appointment.customerName, 0, 1)}</div>
                                        <div>
                                            <div>${fn:escapeXml(appointment.customerName)}</div>
                                        </div>
                                    </td>
                                    <td class="service-list">
                                        <c:forTokens var="service" items="${appointment.services}" delims=",">
                                            <span class="service-item">${fn:escapeXml(service)}</span>
                                        </c:forTokens>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${appointment.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </td>
                                    <td>
                                        <span class="badge badge-${appointment.status}">
                                            <c:choose>
                                                <c:when test="${appointment.status == 'pending'}">Chờ xác nhận</c:when>
                                                <c:when test="${appointment.status == 'confirmed'}">Đã xác nhận</c:when>
                                                <c:when test="${appointment.status == 'completed'}">Hoàn thành</c:when>
                                                <c:when test="${appointment.status == 'cancelled'}">Đã hủy</c:when>
                                                <c:otherwise>Không xác định</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>
                                    <td class="action-buttons">
                                        <button class="btn-action btn-view" onclick="viewAppointment(${appointment.id})">Xem</button>
                                        <c:if test="${appointment.status == 'pending'}">
                                            <button class="btn-action btn-confirm" onclick="showStatusModal(${appointment.id})">Xác nhận</button>
                                        </c:if>
                                        <c:if test="${appointment.status != 'cancelled'}">
                                            <button class="btn-action btn-cancel" onclick="updateStatus(${appointment.id}, 'cancelled')">Hủy</button>
                                        </c:if>
                                        <c:if test="${appointment.status != 'completed' && appointment.status != 'cancelled'}">
                                            <button class="btn-action btn-edit" onclick="editAppointment(${appointment.id})">Sửa</button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>

        <!-- Add Appointment Modal -->
        <div class="modal fade" id="addAppointmentModal" tabindex="-1" aria-labelledby="addAppointmentModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addAppointmentModalLabel">Tạo lịch hẹn mới</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Tên khách hàng</label>
                            <input type="text" id="customerName" class="form-control" placeholder="Nhập tên khách hàng">
                        </div>
                        <div class="form-group">
                            <label>Dịch vụ</label>
                            <select id="services" class="form-control" multiple>
                                <option value="Cắt tóc">Cắt tóc</option>
                                <option value="Cạo mặt">Cạo mặt</option>
                                <option value="Nhuộm tóc">Nhuộm tóc</option>
                                <option value="Gội đầu">Gội đầu</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Tổng tiền</label>
                            <input type="number" id="totalAmount" class="form-control" placeholder="Nhập tổng tiền" step="0.01" min="0">
                        </div>
                        <div class="form-group">
                            <label>Ngày</label>
                            <input type="date" id="appointmentDate" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Giờ</label>
                            <input type="time" id="appointmentTime" class="form-control">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary" onclick="addAppointment()">Tạo lịch hẹn</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- View Appointment Modal -->
        <div class="modal fade" id="viewAppointmentModal" tabindex="-1" aria-labelledby="viewAppointmentModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="viewAppointmentModalLabel">Chi tiết lịch hẹn</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="detail-section">
                            <div class="detail-title">Thông tin khách hàng</div>
                            <div class="service-detail">
                                <span>ID:</span>
                                <span id="viewAppointmentId"></span>
                            </div>
                            <div class="service-detail">
                                <span>Tên:</span>
                                <span id="viewCustomerName"></span>
                            </div>
                        </div>
                        <div class="detail-section">
                            <div class="detail-title">Thông tin lịch hẹn</div>
                            <div class="service-detail">
                                <span>Ngày:</span>
                                <span id="viewAppointmentDate"></span>
                            </div>
                            <div class="service-detail">
                                <span>Giờ:</span>
                                <span id="viewAppointmentTime"></span>
                            </div>
                            <div class="service-detail">
                                <span>Trạng thái:</span>
                                <span id="viewStatus"></span>
                            </div>
                            <div class="service-detail">
                                <span>Tổng tiền:</span>
                                <span id="viewTotalAmount"></span>
                            </div>
                        </div>
                        <div class="detail-section">
                            <div class="detail-title">Dịch vụ</div>
                            <div id="viewServices"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Status Selection Modal -->
        <div class="modal fade" id="statusModal" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="statusModalLabel">Chọn trạng thái</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="d-flex flex-column gap-2">
                            <button class="btn btn-action btn-confirm" onclick="updateStatusFromModal('confirmed')">Đã xác nhận</button>
                            <button class="btn btn-action btn-completed" onclick="updateStatusFromModal('completed')">Hoàn thành</button>
                            <button class="btn btn-action btn-cancel" onclick="updateStatusFromModal('cancelled')">Đã hủy</button>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            let currentAppointmentId = null;

            // Initialize page
            document.addEventListener('DOMContentLoaded', function () {
                updateStats();
                renderAppointments();
            });

            // Toggle sidebar for mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                if (sidebar) {
                    sidebar.classList.toggle('active');
                }
            }

            // Update statistics
            function updateStats() {
                const appointments = getAppointments();
                const pendingCount = appointments.filter(a => a.status === 'pending').length;
                const confirmedCount = appointments.filter(a => a.status === 'confirmed').length;
                const now = new Date();
                const offset = 7 * 60; // +07:00 in minutes
                const today = new Date(now.getTime() + (offset - now.getTimezoneOffset()) * 60000)
                        .toISOString()
                        .split('T')[0];
                const todayCount = appointments.filter(a => a.date === today).length;
                const totalAmount = appointments.reduce((sum, a) => sum + (a.totalAmount || 0), 0);

                document.getElementById('pendingCount').textContent = pendingCount;
                document.getElementById('confirmedCount').textContent = confirmedCount;
                document.getElementById('todayCount').textContent = todayCount;
                document.getElementById('totalAmount').textContent = totalAmount.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
            }

            // Get appointments from table (client-side filtering)
            function getAppointments() {
                const rows = document.querySelectorAll('#appointmentTableBody tr');
                const appointments = [];
                rows.forEach(row => {
                    const id = parseInt(row.cells[0].textContent);
                    const customerName = row.cells[1].querySelector('div > div').textContent;
                    const services = Array.from(row.cells[2].querySelectorAll('.service-item')).map(span => span.textContent);
                    const totalAmount = parseFloat(row.cells[3].textContent.replace(/[^0-9,]/g, '').replace(',', '.'));
                    const status = row.cells[4].querySelector('.badge').className.match(/badge-(\w+)/)[1];
                    const dateTime = row.dataset.dateTime;
                    const date = dateTime ? dateTime.split('T')[0] : '';
                    appointments.push({id, customerName, services, totalAmount, status, date});
                });
                return appointments;
            }

            // Render appointments (for filtering)
            function renderAppointments() {
                const tableInfo = document.getElementById('tableInfo');
                if (tableInfo) {
                    const appointments = getAppointments();
                    tableInfo.textContent = 'Hiển thị ' + appointments.length + ' lịch hẹn';
                }
            }

            // Search appointments
            function searchAppointments() {
                const customerQuery = document.getElementById('searchCustomer').value.toLowerCase();
                const status = document.getElementById('searchStatus').value;
                const date = document.getElementById('searchDate').value;

                const rows = document.querySelectorAll('#appointmentTableBody tr');
                let visibleCount = 0;

                rows.forEach(row => {
                    const customerName = row.cells[1].querySelector('div > div').textContent.toLowerCase();
                    const rowStatus = row.cells[4].querySelector('.badge').className.match(/badge-(\w+)/)[1];
                    const dateTime = row.dataset.dateTime;
                    const rowDate = dateTime ? dateTime.split('T')[0] : '';

                    const matchesCustomer = customerName.includes(customerQuery);
                    const matchesStatus = !status || rowStatus === status;
                    const matchesDate = !date || rowDate === date;

                    if (matchesCustomer && matchesStatus && matchesDate) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                });

                document.getElementById('tableInfo').textContent = 'Hiển thị ' + visibleCount + ' lịch hẹn';
            }

            // Reset filters
            function resetFilters() {
                document.getElementById('searchCustomer').value = '';
                document.getElementById('searchStatus').value = '';
                document.getElementById('searchDate').value = '';
                const rows = document.querySelectorAll('#appointmentTableBody tr');
                rows.forEach(row => row.style.display = '');
                document.getElementById('tableInfo').textContent = 'Hiển thị ${fn:length(listAppointment)} lịch hẹn';
            }

            // Add appointment (placeholder, requires server-side implementation)
            function addAppointment() {
                alert('Vui lòng sử dụng form server-side để tạo lịch hẹn!');
                // Implement AJAX to submit to servlet if needed
            }

            // Show status selection modal
            function showStatusModal(id) {
                currentAppointmentId = id;
                const modal = new bootstrap.Modal(document.getElementById('statusModal'));
                modal.show();
            }

            // Update status from modal
            function updateStatusFromModal(newStatus) {
                if (!currentAppointmentId)
                    return;

                updateStatus(currentAppointmentId, newStatus);
                const modal = bootstrap.Modal.getInstance(document.getElementById('statusModal'));
                modal.hide();
                currentAppointmentId = null;
            }

            // View appointment
            function viewAppointment(id) {
                const rows = document.querySelectorAll('#appointmentTableBody tr');
                let appointment = null;
                rows.forEach(row => {
                    if (parseInt(row.cells[0].textContent) === id) {
                        appointment = {
                            id: id,
                            customerName: row.cells[1].querySelector('div > div').textContent,
                            services: Array.from(row.cells[2].querySelectorAll('.service-item')).map(span => span.textContent),
                            totalAmount: parseFloat(row.cells[3].textContent.replace(/[^0-9,]/g, '').replace(',', '.')),
                            status: row.cells[4].querySelector('.badge').className.match(/badge-(\w+)/)[1],
                            dateTime: row.dataset.dateTime
                        };
                    }
                });

                if (!appointment)
                    return;

                document.getElementById('viewAppointmentId').textContent = appointment.id;
                document.getElementById('viewCustomerName').textContent = appointment.customerName || 'N/A';
                document.getElementById('viewAppointmentDate').textContent = appointment.dateTime ? appointment.dateTime.split('T')[0] : 'N/A';
                document.getElementById('viewAppointmentTime').textContent = appointment.dateTime ? appointment.dateTime.split('T')[1].substring(0, 5) : 'N/A';
                document.getElementById('viewStatus').textContent = getStatusText(appointment.status);
                document.getElementById('viewTotalAmount').textContent = appointment.totalAmount.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                document.getElementById('viewServices').innerHTML = appointment.services.length > 0
                        ? appointment.services.map(service => `<div class="service-detail"><span>${service}</span></div>`).join('')
                        : 'Không có dịch vụ';

                const modal = new bootstrap.Modal(document.getElementById('viewAppointmentModal'));
                modal.show();
            }

            // Get status text
            function getStatusText(status) {
                switch (status) {
                    case 'pending':
                        return 'Chờ xác nhận';
                    case 'confirmed':
                        return 'Đã xác nhận';
                    case 'completed':
                        return 'Hoàn thành';
                    case 'cancelled':
                        return 'Đã hủy';
                    default:
                        return 'Không xác định';
                }
            }

            // Update appointment status
            function updateStatus(id, newStatus) {
                if (!confirm('Bạn có chắc chắn muốn cập nhật trạng thái thành ' + getStatusText(newStatus) + '?')) {
                    return;
                }

                fetch('${pageContext.request.contextPath}/updateAppointmentStatus', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'id=' + encodeURIComponent(id) + '&status=' + encodeURIComponent(newStatus)
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                // Update the table row
                                const rows = document.querySelectorAll('#appointmentTableBody tr');
                                rows.forEach(row => {
                                    if (parseInt(row.cells[0].textContent) === id) {
                                        const statusCell = row.cells[4];
                                        const actionCell = row.cells[5];
                                        statusCell.innerHTML = `<span class="badge badge-${newStatus}">${getStatusText(newStatus)}</span>`;

                                        // Update action buttons
                                        let buttonsHTML = `<button class="btn-action btn-view" onclick="viewAppointment(${id})">Xem</button>`;
                                        if (newStatus === 'pending') {
                                            buttonsHTML += `<button class="btn-action btn-confirm" onclick="showStatusModal(${id})">Xác nhận</button>`;
                                        }
                                        if (newStatus !== 'cancelled') {
                                            buttonsHTML += `<button class="btn-action btn-cancel" onclick="updateStatus(${id}, 'cancelled')">Hủy</button>`;
                                        }
                                        if (newStatus !== 'completed' && newStatus !== 'cancelled') {
                                            buttonsHTML += `<button class="btn-action btn-edit" onclick="editAppointment(${id})">Sửa</button>`;
                                        }
                                        actionCell.innerHTML = buttonsHTML;
                                    }
                                });
                                updateStats();
                                renderAppointments();
                                alert('Cập nhật trạng thái thành công!');
                            } else {
                                alert('Cập nhật trạng thái thất bại: ' + (data.message || 'Lỗi không xác định'));
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Lỗi khi cập nhật trạng thái!');
                        });
            }

            // Edit appointment (placeholder)
            function editAppointment(id) {
                alert('Chức năng chỉnh sửa đang được phát triển!');
            }

            // Export appointments to CSV
            function exportAppointments() {
                const headers = ['ID', 'Khách hàng', 'Dịch vụ', 'Tổng tiền', 'Trạng thái'];
                const appointments = getAppointments();
                const csvContent = [
                    headers.join(','),
                    ...appointments.map(a => [
                            a.id,
                            `"${a.customerName || 'N/A'}"`,
                            `"${a.services.join(';')}"`,
                            a.totalAmount.toLocaleString('vi-VN', {maximumFractionDigits: 0}),
                            getStatusText(a.status)
                        ].join(','))
                ].join('\n');

                const bom = '\uFEFF';
                const blob = new Blob([bom + csvContent], {type: 'text/csv;charset=utf-8;'});
                const link = document.createElement('a');
                link.href = URL.createObjectURL(blob);
                link.download = 'appointments.csv';
                link.click();
            }
        </script>
    </body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Voucher - Barbershop Admin</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="CSS/html.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

            .admin-profile {
                position: absolute;
                bottom: 20px;
                left: 20px;
                right: 20px;
                padding: 20px;
                background: rgba(218, 165, 32, 0.1);
                border-radius: 10px;
                border: 1px solid rgba(218, 165, 32, 0.2);
            }

            .admin-avatar {
                width: 50px;
                height: 50px;
                background: linear-gradient(45deg, #DAA520, #B8860B);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 10px;
                font-size: 1.5rem;
                color: #1d1d1b;
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

            .search-section {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 25px;
                border: 1px solid rgba(218, 165, 32, 0.2);
            }

            .search-row {
                display: flex;
                gap: 20px;
                align-items: center;
                flex-wrap: wrap;
            }

            .search-group {
                flex: 1;
                min-width: 200px;
            }

            .search-group label {
                display: block;
                color: #DAA520;
                margin-bottom: 8px;
                font-weight: 600;
                font-size: 0.9rem;
            }

            .search-input, .search-select {
                width: 100%;
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

            .voucher-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }

            .voucher-table th,
            .voucher-table td {
                padding: 15px 12px;
                text-align: left;
                border-bottom: 1px solid rgba(218, 165, 32, 0.1);
            }

            .voucher-table th {
                background: rgba(218, 165, 32, 0.1);
                color: #DAA520;
                font-weight: 600;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .voucher-table td {
                color: #fff;
                font-size: 0.9rem;
            }

            .voucher-table tbody tr {
                transition: all 0.3s ease;
            }

            .voucher-table tbody tr:hover {
                background: rgba(218, 165, 32, 0.05);
            }

            .voucher-id {
                font-family: 'Courier New', monospace;
                color: #DAA520;
                font-weight: 600;
            }

            .voucher-code {
                font-weight: 600;
                color: #fff;
                background: rgba(218, 165, 32, 0.1);
                padding: 4px 8px;
                border-radius: 4px;
                border: 1px solid rgba(218, 165, 32, 0.3);
                font-family: 'Courier New', monospace;
            }

            .voucher-expire {
                color: #ccc;
            }

            .voucher-value {
                font-weight: 600;
                color: #fff;
            }

            .action-buttons {
                display: flex;
                gap: 8px;
            }

            .btn-action {
                padding: 6px 12px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 0.8rem;
                transition: all 0.3s ease;
            }

            .btn-edit {
                background: rgba(255, 152, 0, 0.2);
                color: #FF9800;
                border: 1px solid rgba(255, 152, 0, 0.3);
            }

            .btn-delete {
                background: rgba(244, 67, 54, 0.2);
                color: #f44336;
                border: 1px solid rgba(244, 67, 54, 0.3);
            }

            .btn-activate {
                background: rgba(76, 175, 80, 0.2);
                color: #4CAF50;
                border: 1px solid rgba(76, 175, 80, 0.3);
            }

            .btn-deactivate {
                background: rgba(156, 39, 176, 0.2);
                color: #9C27B0;
                border: 1px solid rgba(156, 39, 176, 0.3);
            }

            .btn-action:hover {
                transform: translateY(-1px);
            }

            .badge {
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .badge-active {
                background: rgba(76, 175, 80, 0.2);
                color: #4CAF50;
                border: 1px solid rgba(76, 175, 80, 0.3);
            }

            .badge-inactive {
                background: rgba(156, 39, 176, 0.2);
                color: #9C27B0;
                border: 1px solid rgba(156, 39, 176, 0.3);
            }

            .badge-expired {
                background: rgba(244, 67, 54, 0.2);
                color: #f44336;
                border: 1px solid rgba(244, 67, 54, 0.3);
            }

            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 25px;
                gap: 10px;
            }

            .pagination-btn {
                padding: 8px 12px;
                background: rgba(218, 165, 32, 0.1);
                color: #DAA520;
                border: 1px solid rgba(218, 165, 32, 0.3);
                border-radius: 6px;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
            }

            .pagination-btn:hover, .pagination-btn.active {
                background: rgba(218, 165, 32, 0.2);
                transform: translateY(-1px);
            }

            .pagination-info {
                color: #ccc;
                font-size: 0.9rem;
                margin: 0 15px;
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

                .search-row {
                    flex-direction: column;
                }

                .table-container {
                    padding: 15px;
                }

                .voucher-table {
                    font-size: 0.8rem;
                }

                .voucher-table th,
                .voucher-table td {
                    padding: 10px 8px;
                }
            }
            .search-section {
                background-color: #1a1a1a;
                padding: 15px;
                border: 1px solid #fff;
                border-radius: 8px;
                margin-bottom: 20px;
            }

            .search-row {
                display: flex;
                gap: 15px;
                flex-wrap: wrap;
            }

            .search-group {
                flex: 1;
                min-width: 200px;
            }

            .search-input, .search-select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                background-color: #333;
                color: #fff;
            }

            .voucher-table {
                width: 100%;
                border-collapse: separate;
                border: 1px solid #fff;
                border-radius: 8px;
                overflow: hidden;
                background-color: #1a1a1a;
                margin-bottom: 20px;
            }

            .voucher-table thead {
                background-color: #2a2a2a;
            }

            .voucher-table th {
                padding: 12px;
                text-align: left;
                color: #fff;
                border-bottom: 1px solid #fff;
            }

            .voucher-table td {
                padding: 12px;
                color: #fff;
                border-bottom: 1px solid #444;
                background-color: #222;
            }

            .voucher-table tr:last-child td {
                border-bottom: none;
            }

            .action-buttons .btn-action {
                margin-right: 5px;
            }

            .badge {
                padding: 5px 10px;
                border-radius: 10px;
            }

            .badge-active {
                background-color: #28a745;
                color: #fff;
            }
            .badge-inactive {
                background-color: #dc3545;
                color: #fff;
            }
            .badge-expired {
                background-color: #6c757d;
                color: #fff;
            }

            .pagination {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 5px;
                margin-top: 10px;
            }

            .pagination-btn {
                padding: 8px 12px;
                border: 1px solid #fff;
                border-radius: 4px;
                color: #fff;
                text-decoration: none;
                background-color: #2a2a2a;
            }

            .pagination-btn.active, .pagination-btn:hover {
                background-color: #fff;
                color: #000;
            }

            .pagination-info {
                margin-left: 10px;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <nav class="navbar navbar-expand-lg custom-navbar border-bottom shadow-sm">
            <div class="container-fluid px-4">
                <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/views/admin/dashboard.jsp">
                    <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Logo" width="55" height="55" class="me-2">
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <div class="d-flex gap-2 align-items-center">
                        <div class="text-warning d-none d-lg-block me-3">
                            <i class="fas fa-user-shield me-1"></i>
                            <span> ${sessionScope.admin.lastName} ${sessionScope.admin.firstName}</span>
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
                    <div class="logo-text">BarberShop Pro</div>
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
                        <a href="${pageContext.request.contextPath}/RevenueManagementServlet" class="nav-link">
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
                        <h1><i class="fas fa-ticket-alt"></i> Quản lý Voucher</h1>
                        <p>Quản lý mã giảm giá và ưu đãi cho khách hàng</p>
                    </div>
                    <div class="header-actions">
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addVoucherModal">
                            <i class="fas fa-plus"></i>
                            Thêm voucher
                        </button>
                    </div>
                </div>

                <div class="search-section">
                    <div class="search-row">
                        <div class="search-group">
                            <label for="searchCode">Tìm kiếm theo mã</label>
                            <input type="text" id="searchCode" class="search-input" 
                                   placeholder="Nhập mã voucher..." onkeyup="filterVouchers()">
                        </div>
                        <div class="search-group">
                            <label for="filterStatus">Lọc theo trạng thái</label>
                            <select id="filterStatus" class="search-select" onchange="filterVouchers()">
                                <option value="">Tất cả</option>
                                <option value="active">Đang hoạt động</option>
                                <option value="inactive">Ngưng hoạt động</option>
                                <option value="expired">Hết hạn</option>
                            </select>
                        </div>
                        <div class="search-group">
                            <label for="sortBy">Sắp xếp theo</label>
                            <select id="sortBy" class="search-select" onchange="sortVouchers()">
                                <option value="id">STT</option>
                                <option value="code">Mã voucher</option>
                                <option value="expire">Ngày hết hạn</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="table-header">
                    <h3 class="table-title">Danh sách voucher</h3>
                    <div class="table-info">
                        Tổng cộng: <strong id="totalVouchers">${totalRecords}</strong> voucher
                    </div>
                </div>

                <table class="voucher-table">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên Voucher</th> <!-- Thêm cột mới -->
                            <th>Mã voucher</th>
                            <th>Ngày hết hạn</th>
                            <th>Phần trăm giảm giá</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="voucherTableBody">
                        <c:forEach var="voucher" items="${vouchers}" varStatus="loop">
                            <tr>
                                <td class="voucher-id">${loop.count}</td>
                                <td class="voucher-name">${voucher.voucherName}</td> <!-- Thêm cột mới -->
                                <td class="voucher-code">${voucher.code}</td>
                                <td class="voucher-expire"><fmt:formatDate value="${voucher.expiryDate}" pattern="dd/MM/yyyy"/></td>
                                <td class="voucher-value">${voucher.value}%</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${voucher.expiryDate < java.time.LocalDate.now()}">
                                            <span class="badge badge-expired">Hết hạn</span>
                                        </c:when>
                                        <c:when test="${voucher.status == 1}">
                                            <span class="badge badge-active">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-inactive">Ngưng hoạt động</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn-action btn-deactivate" onclick="toggleVoucher(${voucher.id}, this)" title="Dừng khuyến mãi">
                                            <i class="fas fa-pause"></i>
                                        </button>
                                        <button class="btn-action btn-edit" onclick="editVoucher(${voucher.id})" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn-action btn-delete" onclick="deleteVoucher(${voucher.id})" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="pagination">
                    <a href="#" class="pagination-btn prev" onclick="loadPage(1)">«</a>
                    <c:forEach var="i" begin="1" end="5">
                        <a href="#" class="pagination-btn ${i == 1 ? 'active' : ''}" onclick="loadPage(${i})">${i}</a>
                    </c:forEach>
                    <span class="pagination-info">Hiển thị 1-${vouchers.size()} của ${totalRecords} voucher</span>
                    <a href="#" class="pagination-btn next" onclick="loadPage(5)">»</a>
                </div>
        </div>

        <!-- Modal Thêm Voucher -->
        <div class="modal fade" id="addVoucherModal" tabindex="-1" aria-labelledby="addVoucherModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addVoucherModalLabel">Thêm Voucher Mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="addVoucherForm">
                            <div class="form-group">
                                <label for="addVoucherName">Tên Voucher</label>
                                <input type="text" class="form-control" id="addVoucherName" name="voucherName" required>
                            </div>
                            <div class="form-group">
                                <label for="addCode">Mã Voucher</label>
                                <input type="text" class="form-control" id="addCode" name="code" required>
                            </div>
                            <div class="form-group">
                                <label for="addExpiryDate">Ngày Hết Hạn</label>
                                <input type="date" class="form-control" id="addExpiryDate" name="expiryDate" required>
                            </div>
                            <div class="form-group">
                                <label for="addValue">Phần Trăm Giảm Giá (%)</label>
                                <input type="number" class="form-control" id="addValue" name="value" min="1" max="100" required>
                            </div>
                            <button type="submit" class="btn btn-primary mt-3">Thêm Voucher</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Sửa Voucher -->
        <div class="modal fade" id="editVoucherModal" tabindex="-1" aria-labelledby="editVoucherModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editVoucherModalLabel">Sửa Voucher</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editVoucherForm">
                            <input type="hidden" id="editId" name="id">
                            <div class="form-group">
                                <label for="editVoucherName">Tên Voucher</label>
                                <input type="text" class="form-control" id="editVoucherName" name="voucherName" required>
                            </div>
                            <div class="form-group">
                                <label for="editCode">Mã Voucher</label>
                                <input type="text" class="form-control" id="editCode" name="code" required>
                            </div>
                            <div class="form-group">
                                <label for="editExpiryDate">Ngày Hết Hạn</label>
                                <input type="date" class="form-control" id="editExpiryDate" name="expiryDate" required>
                            </div>
                            <div class="form-group">
                                <label for="editValue">Phần Trăm Giảm Giá (%)</label>
                                <input type="number" class="form-control" id="editValue" name="value" min="1" max="100" required>
                            </div>
                            <button type="submit" class="btn btn-primary mt-3">Cập Nhật</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<script>
    // Toggle sidebar for mobile
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('active');
    }

    function loadPage(page) {
        $.ajax({
            url: '${pageContext.request.contextPath}/VoucherServlet',
            type: 'GET',
            data: {action: 'list', page: page},
            dataType: 'json',
            success: function (response) {
                if (!response.success) {
                    alert('Lỗi khi tải dữ liệu: ' + (response.message || 'Không xác định'));
                    return;
                }
                const vouchers = Array.isArray(response.data) ? response.data : [];
                const tbody = $('#voucherTableBody');
                tbody.empty();
                let index = (page - 1) * 10;

                if (vouchers.length > 0) {
                    vouchers.forEach(voucher => {
                        index++;
                        const expiryDate = voucher.expiryDate || 'N/A';
                        const isExpired = expiryDate ? new Date(expiryDate) < new Date() : false;
                        const statusClass = isExpired ? 'badge-expired' : voucher.status === 1 ? 'badge-active' : 'badge-inactive';
                        const statusText = isExpired ? 'Hết hạn' : voucher.status === 1 ? 'Hoạt động' : 'Ngưng hoạt động';
                        const toggleButton = voucher.status === 1
                                ? '<button class="btn-action btn-deactivate" onclick="toggleVoucher(' + (voucher.id || 0) + ', this)" title="Dừng khuyến mãi"><i class="fas fa-pause"></i></button>'
                                : '<button class="btn-action btn-activate" onclick="toggleVoucher(' + (voucher.id || 0) + ', this)" title="Kích hoạt"><i class="fas fa-play"></i></button>';

                        let row = $('<tr></tr>');
                        row.append('<td class="voucher-id">' + index + '</td>');
                        row.append('<td class="voucher-name">' + (voucher.voucherName || '') + '</td>'); // Thêm cột voucherName
                        row.append('<td class="voucher-code">' + (voucher.code || '') + '</td>');
                        row.append('<td class="voucher-expire">' + (expiryDate !== 'N/A' ? expiryDate : '') + '</td>');
                        row.append('<td class="voucher-value">' + (voucher.value || 0) + '%</td>');
                        row.append('<td><span class="badge ' + statusClass + '">' + statusText + '</span></td>');
                        let actions = $('<div class="action-buttons"></div>');
                        actions.append(toggleButton);
                        actions.append('<button class="btn-action btn-edit" onclick="editVoucher(' + (voucher.id || 0) + ')" title="Chỉnh sửa"><i class="fas fa-edit"></i></button>');
                        actions.append('<button class="btn-action btn-delete" onclick="deleteVoucher(' + (voucher.id || 0) + ')" title="Xóa"><i class="fas fa-trash"></i></button>');
                        row.append('<td></td>').find('td:last').append(actions);
                        tbody.append(row);
                    });
                } else {
                    tbody.append('<tr><td colspan="7" class="text-center">Không có dữ liệu voucher.</td></tr>'); // Cập nhật colspan
                }
                $('#totalVouchers').text(response.totalRecords || 0);
                $('.pagination-info').text('Hiển thị ' + ((page - 1) * 10 + 1) + '-' + Math.min((page - 1) * 10 + vouchers.length, response.totalRecords) + ' của ' + (response.totalRecords || 0) + ' voucher');
                updatePagination(page, response.totalRecords);
            },
            error: function (xhr, status, error) {
                console.error('Lỗi AJAX:', xhr.responseText);
                alert('Lỗi khi tải danh sách voucher. Chi tiết: ' + xhr.responseText);
            }
        });
    }

    // Hàm filterVouchers (triển khai cơ bản)
    function filterVouchers() {
        const searchCode = $('#searchCode').val().toLowerCase();
        const filterStatus = $('#filterStatus').val();
        $.ajax({
            url: '${pageContext.request.contextPath}/VoucherServlet',
            type: 'GET',
            data: {action: 'list', page: 1},
            dataType: 'json',
            success: function (response) {
                if (response.success) {
                    const vouchers = response.data.filter(voucher => {
                        const matchesCode = voucher.code.toLowerCase().includes(searchCode);
                        const isExpired = new Date(voucher.expiryDate) < new Date();
                        const statusMatch = filterStatus === '' ||
                                (filterStatus === 'active' && voucher.status === 1 && !isExpired) ||
                                (filterStatus === 'inactive' && voucher.status === 0) ||
                                (filterStatus === 'expired' && isExpired);
                        return matchesCode && statusMatch;
                    });
                    const tbody = $('#voucherTableBody');
                    tbody.empty();
                    let index = 0;
                    if (vouchers.length > 0) {
                        vouchers.forEach(voucher => {
                            index++;
                            const expiryDate = voucher.expiryDate || 'N/A';
                            const isExpired = expiryDate ? new Date(expiryDate) < new Date() : false;
                            const statusClass = isExpired ? 'badge-expired' : voucher.status === 1 ? 'badge-active' : 'badge-inactive';
                            const statusText = isExpired ? 'Hết hạn' : voucher.status === 1 ? 'Hoạt động' : 'Ngưng hoạt động';
                            const toggleButton = voucher.status === 1
                                    ? '<button class="btn-action btn-deactivate" onclick="toggleVoucher(' + (voucher.id || 0) + ', this)" title="Dừng khuyến mãi"><i class="fas fa-pause"></i></button>'
                                    : '<button class="btn-action btn-activate" onclick="toggleVoucher(' + (voucher.id || 0) + ', this)" title="Kích hoạt"><i class="fas fa-play"></i></button>';

                            let row = $('<tr></tr>');
                            row.append('<td class="voucher-id">' + index + '</td>');
                            row.append('<td class="voucher-name">' + (voucher.voucherName || '') + '</td>'); // Thêm cột voucherName
                            row.append('<td class="voucher-code">' + (voucher.code || '') + '</td>');
                            row.append('<td class="voucher-expire">' + (expiryDate !== 'N/A' ? expiryDate : '') + '</td>');
                            row.append('<td class="voucher-value">' + (voucher.value || 0) + '%</td>');
                            row.append('<td><span class="badge ' + statusClass + '">' + statusText + '</span></td>');
                            let actions = $('<div class="action-buttons"></div>');
                            actions.append(toggleButton);
                            actions.append('<button class="btn-action btn-edit" onclick="editVoucher(' + (voucher.id || 0) + ')" title="Chỉnh sửa"><i class="fas fa-edit"></i></button>');
                            actions.append('<button class="btn-action btn-delete" onclick="deleteVoucher(' + (voucher.id || 0) + ')" title="Xóa"><i class="fas fa-trash"></i></button>');
                            row.append('<td></td>').find('td:last').append(actions);
                            tbody.append(row);
                        });
                    } else {
                        tbody.append('<tr><td colspan="7" class="text-center">Không có dữ liệu voucher.</td></tr>'); // Cập nhật colspan
                    }
                    $('#totalVouchers').text(vouchers.length);
                    $('.pagination-info').text('Hiển thị 1-' + vouchers.length + ' của ' + vouchers.length + ' voucher');
                }
            },
            error: function (xhr, status, error) {
                console.error('Lỗi AJAX:', xhr.responseText);
                alert('Lỗi khi lọc voucher. Chi tiết: ' + xhr.responseText);
            }
        });
    }

    // Hàm sortVouchers (triển khai cơ bản)
    function sortVouchers() {
        const sortBy = $('#sortBy').val();
        $.ajax({
            url: '${pageContext.request.contextPath}/VoucherServlet',
            type: 'GET',
            data: {action: 'list', page: 1},
            dataType: 'json',
            success: function (response) {
                if (response.success) {
                    const vouchers = response.data.sort((a, b) => {
                        if (sortBy === 'code')
                            return a.code.localeCompare(b.code);
                        if (sortBy === 'expire') {
                            const dateA = new Date(a.expiryDate);
                            const dateB = new Date(b.expiryDate);
                            return dateA - dateB;
                        }
                        return a.id - b.id;
                    });
                    const tbody = $('#voucherTableBody');
                    tbody.empty();
                    let index = 0;
                    if (vouchers.length > 0) {
                        vouchers.forEach(voucher => {
                            index++;
                            const expiryDate = voucher.expiryDate || 'N/A';
                            const isExpired = expiryDate ? new Date(expiryDate) < new Date() : false;
                            const statusClass = isExpired ? 'badge-expired' : voucher.status === 1 ? 'badge-active' : 'badge-inactive';
                            const statusText = isExpired ? 'Hết hạn' : voucher.status === 1 ? 'Hoạt động' : 'Ngưng hoạt động';
                            const toggleButton = voucher.status === 1
                                    ? '<button class="btn-action btn-deactivate" onclick="toggleVoucher(' + (voucher.id || 0) + ', this)" title="Dừng khuyến mãi"><i class="fas fa-pause"></i></button>'
                                    : '<button class="btn-action btn-activate" onclick="toggleVoucher(' + (voucher.id || 0) + ', this)" title="Kích hoạt"><i class="fas fa-play"></i></button>';

                            let row = $('<tr></tr>');
                            row.append('<td class="voucher-id">' + index + '</td>');
                            row.append('<td class="voucher-name">' + (voucher.voucherName || '') + '</td>'); // Thêm cột voucherName
                            row.append('<td class="voucher-code">' + (voucher.code || '') + '</td>');
                            row.append('<td class="voucher-expire">' + (expiryDate !== 'N/A' ? expiryDate : '') + '</td>');
                            row.append('<td class="voucher-value">' + (voucher.value || 0) + '%</td>');
                            row.append('<td><span class="badge ' + statusClass + '">' + statusText + '</span></td>');
                            let actions = $('<div class="action-buttons"></div>');
                            actions.append(toggleButton);
                            actions.append('<button class="btn-action btn-edit" onclick="editVoucher(' + (voucher.id || 0) + ')" title="Chỉnh sửa"><i class="fas fa-edit"></i></button>');
                            actions.append('<button class="btn-action btn-delete" onclick="deleteVoucher(' + (voucher.id || 0) + ')" title="Xóa"><i class="fas fa-trash"></i></button>');
                            row.append('<td></td>').find('td:last').append(actions);
                            tbody.append(row);
                        });
                    } else {
                        tbody.append('<tr><td colspan="7" class="text-center">Không có dữ liệu voucher.</td></tr>'); // Cập nhật colspan
                    }
                    $('#totalVouchers').text(vouchers.length);
                    $('.pagination-info').text('Hiển thị 1-' + vouchers.length + ' của ' + vouchers.length + ' voucher');
                }
            },
            error: function (xhr, status, error) {
                console.error('Lỗi AJAX:', xhr.responseText);
                alert('Lỗi khi sắp xếp voucher. Chi tiết: ' + xhr.responseText);
            }
        });
    }

    // Hàm editVoucher
    function editVoucher(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/VoucherServlet',
            type: 'GET',
            data: {action: 'edit', id: id},
            dataType: 'json',
            success: function (response) {
                if (response.success) {
                    const voucher = response.data;
                    if (voucher) {
                        $('#editId').val(voucher.id || '');
                        $('#editVoucherName').val(voucher.voucherName || '');
                        $('#editCode').val(voucher.code || '');
                        $('#editExpiryDate').val(voucher.expiryDate ? voucher.expiryDate : '');
                        $('#editValue').val(voucher.value || '');
                        $('#editVoucherModal').modal('show');
                    } else {
                        alert('Không tìm thấy voucher để chỉnh sửa.');
                    }
                } else {
                    alert('Lỗi khi tải thông tin voucher: ' + response.message);
                }
            },
            error: function (xhr, status, error) {
                console.error('Lỗi AJAX:', xhr.responseText);
                alert('Lỗi khi tải thông tin voucher. Chi tiết: ' + xhr.responseText);
            }
        });
    }

    // Hàm updateVoucher
    $('#editVoucherForm').on('submit', function (e) {
        e.preventDefault();
        const id = $('#editId').val();
        const data = {
            action: 'update',
            id: id,
            voucherName: $('#editVoucherName').val(), // Thêm voucherName
            code: $('#editCode').val(),
            expiryDate: $('#editExpiryDate').val(),
            value: $('#editValue').val()
        };
        $.ajax({
            url: '${pageContext.request.contextPath}/VoucherServlet',
            type: 'POST',
            data: data,
            dataType: 'json',
            success: function (response) {
                alert(response.message);
                if (response.success) {
                    $('#editVoucherModal').modal('hide');
                    loadPage(1); // Tải lại trang
                }
            },
            error: function (xhr, status, error) {
                console.error('Lỗi AJAX:', xhr.responseText);
                alert('Lỗi khi cập nhật voucher. Chi tiết: ' + xhr.responseText);
            }
        });
    });

    // Hàm toggleVoucher
    function toggleVoucher(id, button) {
        const status = button.classList.contains('btn-deactivate') ? 0 : 1;
        $.ajax({
            url: '${pageContext.request.contextPath}/VoucherServlet',
            type: 'POST',
            data: {action: 'toggle', id: id, status: status},
            dataType: 'json',
            success: function (response) {
                alert(response.message);
                if (response.success) {
                    loadPage(1); // Tải lại trang
                }
            },
            error: function (xhr, status, error) {
                console.error('Lỗi AJAX:', xhr.responseText);
                alert('Lỗi khi thay đổi trạng thái voucher. Chi tiết: ' + xhr.responseText);
            }
        });
    }

    // Hàm deleteVoucher
    function deleteVoucher(id) {
        if (confirm('Bạn có chắc chắn muốn xóa voucher này?')) {
            $.ajax({
                url: '${pageContext.request.contextPath}/VoucherServlet',
                type: 'POST',
                data: {action: 'delete', id: id},
                dataType: 'json',
                success: function (response) {
                    alert(response.message);
                    if (response.success) {
                        loadPage(1); // Tải lại trang
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Lỗi AJAX:', xhr.responseText);
                    alert('Lỗi khi xóa voucher. Chi tiết: ' + xhr.responseText);
                }
            });
        }
    }

    // Hàm updatePagination
    function updatePagination(page, totalRecords) {
        const totalPages = Math.ceil(totalRecords / 10);
        const pagination = $('.pagination');
        pagination.find('.pagination-btn').not('.prev, .next').remove();

        let startPage = Math.max(1, page - 2);
        let endPage = Math.min(totalPages, page + 2);

        if (startPage > 1) {
            pagination.append('<a href="#" class="pagination-btn" onclick="loadPage(1)">1</a>');
            if (startPage > 2)
                pagination.append('<span>...</span>');
        }

        for (let i = startPage; i <= endPage; i++) {
            pagination.append('<a href="#" class="pagination-btn ' + (i === page ? 'active' : '') + '" onclick="loadPage(' + i + ')">' + i + '</a>');
        }

        if (endPage < totalPages) {
            if (endPage < totalPages - 1)
                pagination.append('<span>...</span>');
            pagination.append('<a href="#" class="pagination-btn" onclick="loadPage(' + totalPages + ')">' + totalPages + '</a>');
        }

        pagination.find('.prev').attr('onclick', 'loadPage(' + (page > 1 ? page - 1 : 1) + ')');
        pagination.find('.next').attr('onclick', 'loadPage(' + (page < totalPages ? page + 1 : totalPages) + ')');
    }

    $(document).ready(function () {
        loadPage(1);

        $(document).on('click', function (event) {
            const sidebar = $('#sidebar');
            const mobileBtn = $('.mobile-menu-btn');
            if (window.innerWidth <= 768 &&
                    !sidebar.is(event.target) &&
                    sidebar.has(event.target).length === 0 &&
                    !mobileBtn.is(event.target) &&
                    sidebar.hasClass('active')) {
                sidebar.removeClass('active');
            }
        });

        $('#searchCode').on('keyup', filterVouchers);
        $('#filterStatus').on('change', filterVouchers);
        $('#sortBy').on('change', sortVouchers);

        // Xử lý form thêm voucher
        $('#addVoucherForm').on('submit', function (e) {
            e.preventDefault();
            const data = {
                action: 'add',
                voucherName: $('#addVoucherName').val(), // Thêm voucherName
                code: $('#addCode').val(),
                expiryDate: $('#addExpiryDate').val(),
                value: $('#addValue').val()
            };
            $.ajax({
                url: '${pageContext.request.contextPath}/VoucherServlet',
                type: 'POST',
                data: data,
                dataType: 'json',
                success: function (response) {
                    alert(response.message);
                    if (response.success) {
                        $('#addVoucherModal').modal('hide');
                        loadPage(1); // Tải lại trang
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Lỗi AJAX:', xhr.responseText);
                    alert('Lỗi khi thêm voucher. Chi tiết: ' + xhr.responseText);
                }
            });
        });
    });
</script>
</body>
</html>
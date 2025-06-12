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
        </style>
    </head>
    <body>
        <%@ page contentType="text/html; charset=UTF-8" %>
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
                        <a href="${pageContext.request.contextPath}/views/admin/customerManagement.jsp" class="nav-link">
                            <i class="fas fa-users"></i>
                            <span>Quản lý Khách hàng</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="${pageContext.request.contextPath}/views/admin/staffManagement.jsp" class="nav-link active">
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

                <div class="table-container">
                    <div class="table-header">
                        <h3 class="table-title">Danh sách voucher</h3>
                        <div class="table-info">
                            Tổng cộng: <strong id="totalVouchers">5</strong> voucher
                        </div>
                    </div>

                    <table class="voucher-table">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Mã voucher</th>
                                <th>Ngày hết hạn</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody id="voucherTableBody">
                            <tr>
                                <td class="voucher-id">001</td>
                                <td class="voucher-code">SUMMER2024</td>
                                <td class="voucher-expire">31/08/2025</td>
                                <td><span class="badge badge-active">Hoạt động</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn-action btn-edit" onclick="editVoucher(1)" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn-action btn-deactivate" onclick="toggleVoucher(1, this)" title="Ngưng hoạt động">
                                            <i class="fas fa-pause"></i>
                                        </button>
                                        <button class="btn-action btn-delete" onclick="deleteVoucher(1)" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="voucher-id">002</td>
                                <td class="voucher-code">WELCOME50</td>
                                <td class="voucher-expire">15/12/2025</td>
                                <td><span class="badge badge-active">Hoạt động</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn-action btn-edit" onclick="editVoucher(2)" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn-action btn-deactivate" onclick="toggleVoucher(2, this)" title="Ngưng hoạt động">
                                            <i class="fas fa-pause"></i>
                                        </button>
                                        <button class="btn-action btn-delete" onclick="deleteVoucher(2)" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="voucher-id">003</td>
                                <td class="voucher-code">FALL2024</td>
                                <td class="voucher-expire">30/11/2024</td>
                                <td><span class="badge badge-expired">Hết hạn</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn-action btn-edit" onclick="editVoucher(3)" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn-action btn-delete" onclick="deleteVoucher(3)" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="voucher-id">004</td>
                                <td class="voucher-code">NEWUSER25</td>
                                <td class="voucher-expire">31/03/2025</td>
                                <td><span class="badge badge-inactive">Ngưng hoạt động</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn-action btn-edit" onclick="editVoucher(4)" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn-action btn-activate" onclick="toggleVoucher(4, this)" title="Kích hoạt">
                                            <i class="fas fa-play"></i>
                                        </button>
                                        <button class="btn-action btn-delete" onclick="deleteVoucher(4)" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="voucher-id">005</td>
                                <td class="voucher-code">VIP2024</td>
                                <td class="voucher-expire">31/12/2025</td>
                                <td><span class="badge badge-active">Hoạt động</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn-action btn-edit" onclick="editVoucher(5)" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn-action btn-deactivate" onclick="toggleVoucher(5, this)" title="Ngưng hoạt động">
                                            <i class="fas fa-pause"></i>
                                        </button>
                                        <button class="btn-action btn-delete" onclick="deleteVoucher(5)" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="pagination">
                        <a href="#" class="pagination-btn">«</a>
                        <a href="#" class="pagination-btn active">1</a>
                        <a href="#" class="pagination-btn">2</a>
                        <a href="#" class="pagination-btn">3</a>
                        <span class="pagination-info">Hiển thị 1-5 của 5 voucher</span>
                        <a href="#" class="pagination-btn">4</a>
                        <a href="#" class="pagination-btn">5</a>
                        <a href="#" class="pagination-btn">»</a>
                    </div>
                </div>

                <!-- Add Voucher Modal -->
                <div class="modal fade" id="addVoucherModal" tabindex="-1" aria-labelledby="addVoucherModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addVoucherModalLabel">Thêm Voucher Mới</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="addVoucherForm">
                                    <div class="form-group">
                                        <label for="voucherCode">Mã Voucher</label>
                                        <input type="text" class="form-control" id="voucherCode" placeholder="Nhập mã voucher">
                                    </div>
                                    <div class="form-group">
                                        <label for="voucherExpire">Ngày Hết Hạn</label>
                                        <input type="date" class="form-control" id="voucherExpire">
                                    </div>
                                    <button type="submit" class="btn btn-primary w-100">Thêm Voucher</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <script>
            // Sample voucher data for demonstration
            let vouchers = [
                {id: 1, code: 'SUMMER2024', expire: '2025-08-31', status: 'active'},
                {id: 2, code: 'WELCOME50', expire: '2025-12-15', status: 'active'},
                {id: 3, code: 'FALL2024', expire: '2024-11-30', status: 'expired'},
                {id: 4, code: 'NEWUSER25', expire: '2025-03-31', status: 'inactive'},
                {id: 5, code: 'VIP2024', expire: '2025-12-31', status: 'active'}
            ];

            // Toggle sidebar for mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                sidebar.classList.toggle('active');
            }

            // Toggle voucher status (active/inactive)
            function toggleVoucher(voucherId, buttonElement) {
                const row = buttonElement.closest('tr');
                const statusBadge = row.querySelector('.badge');
                const voucher = vouchers.find(v => v.id === voucherId);

                if (voucher) {
                    const today = new Date();
                    const expireDate = new Date(voucher.expire);

                    if (expireDate < today) {
                        alert('Không thể thay đổi trạng thái voucher đã hết hạn.');
                        return;
                    }

                    voucher.status = voucher.status === 'active' ? 'inactive' : 'active';

                    if (voucher.status === 'active') {
                        statusBadge.className = 'badge badge-active';
                        statusBadge.textContent = 'Hoạt động';
                        buttonElement.className = 'btn-action btn-deactivate';
                        buttonElement.title = 'Ngưng hoạt động';
                        buttonElement.innerHTML = '<i class="fas fa-pause"></i>';
                    } else {
                        statusBadge.className = 'badge badge-inactive';
                        statusBadge.textContent = 'Ngưng hoạt động';
                        buttonElement.className = 'btn-action btn-activate';
                        buttonElement.title = 'Kích hoạt';
                        buttonElement.innerHTML = '<i class="fas fa-play"></i>';
                    }

                    // Here you would typically send an AJAX request to update the database
                }
            }

            // Edit voucher function
            function editVoucher(voucherId) {
                console.log('Edit voucher:', voucherId);
                alert(`Chỉnh sửa voucher #${voucherId}`);
                // Implement edit functionality, possibly with a modal
            }

            // Delete voucher function
            function deleteVoucher(voucherId) {
                if (confirm(`Bạn có chắc chắn muốn xóa voucher #${voucherId}?`)) {
                    vouchers = vouchers.filter(v => v.id !== voucherId);
                    renderVouchers();
                    updateTotalVouchers();
                }
            }

            // Filter vouchers function
            function filterVouchers() {
                const codeFilter = document.getElementById('searchCode').value.toLowerCase();
                const statusFilter = document.getElementById('filterStatus').value;
                const rows = document.querySelectorAll('#voucherTableBody tr');
                let visibleCount = 0;

                rows.forEach(row => {
                    const code = row.querySelector('.voucher-code').textContent.toLowerCase();
                    const status = row.querySelector('.badge').classList.contains('badge-active') ? 'active' :
                                  row.querySelector('.badge').classList.contains('badge-inactive') ? 'inactive' : 'expired';

                    const codeMatch = code.includes(codeFilter);
                    const statusMatch = statusFilter === '' || status === statusFilter;

                    if (codeMatch && statusMatch) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                });

                document.getElementById('totalVouchers').textContent = visibleCount;
            }

            // Sort vouchers function
            function sortVouchers() {
                const sortBy = document.getElementById('sortBy').value;
                const tbody = document.getElementById('voucherTableBody');
                const rows = Array.from(tbody.querySelectorAll('tr'));

                rows.sort((a, b) => {
                    let aValue, bValue;

                    switch (sortBy) {
                        case 'id':
                            aValue = parseInt(a.querySelector('.voucher-id').textContent);
                            bValue = parseInt(b.querySelector('.voucher-id').textContent);
                            break;
                        case 'code':
                            aValue = a.querySelector('.voucher-code').textContent.toLowerCase();
                            bValue = b.querySelector('.voucher-code').textContent.toLowerCase();
                            break;
                        case 'expire':
                            aValue = new Date(a.querySelector('.voucher-expire').textContent.split('/').reverse().join('-'));
                            bValue = new Date(b.querySelector('.voucher-expire').textContent.split('/').reverse().join('-'));
                            break;
                        default:
                            return 0;
                    }

                    if (typeof aValue === 'string') {
                        return aValue.localeCompare(bValue);
                    } else {
                        return aValue - bValue;
                    }
                });

                tbody.innerHTML = '';
                rows.forEach(row => tbody.appendChild(row));
            }

            // Render vouchers function (lưu ý có thể lỗi phần n)
            

            // Update total vouchers count
            function updateTotalVouchers() {
                document.getElementById('totalVouchers').textContent = vouchers.length;
                document.querySelector('.pagination-info').textContent = `Hiển thị 1-${vouchers.length} của ${vouchers.length} voucher`;
            }

            // Export vouchers function
            function exportVouchers() {
                console.log('Exporting vouchers to Excel...');
                alert('Chức năng xuất Excel sẽ được triển khai sau!');
            }

            // Handle form submission for adding new voucher
            document.getElementById('addVoucherForm')?.addEventListener('submit', function(e) {
                e.preventDefault();
                const code = document.getElementById('voucherCode').value;
                const expire = document.getElementById('voucherExpire').value;

                if (code && expire) {
                    const newId = vouchers.length > 0 ? Math.max(...vouchers.map(v => v.id)) + 1 : 1;
                    vouchers.push({id: newId, code: code, expire: expire, status: 'active'});
                    renderVouchers();
                    updateTotalVouchers();
                    document.getElementById('addVoucherForm').reset();
                    bootstrap.Modal.getInstance(document.getElementById('addVoucherModal')).hide();
                } else {
                    alert('Vui lòng điền đầy đủ thông tin.');
                }
            });

            // Initialize page
            document.addEventListener('DOMContentLoaded', function () {
                updateTotalVouchers();

                document.addEventListener('click', function (event) {
                    const sidebar = document.getElementById('sidebar');
                    const mobileBtn = document.querySelector('.mobile-menu-btn');

                    if (window.innerWidth <= 768 &&
                            !sidebar.contains(event.target) &&
                            !mobileBtn.contains(event.target) &&
                            sidebar.classList.contains('active')) {
                        sidebar.classList.remove('active');
                    }
                });
            });
        </script>
    </body>
</html>
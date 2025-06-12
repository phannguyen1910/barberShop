<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Khách hàng - Barbershop Admin</title>
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

            .dashboard-layout {
                display: flex;
                min-height: 100vh;
            }

            /* Sidebar - Same as dashboard */
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

            /* Main Content */
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

            /* Search and Filter Section */
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

            /* Customer Table */
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

            .customer-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }

            .customer-table th,
            .customer-table td {
                padding: 15px 12px;
                text-align: left;
                border-bottom: 1px solid rgba(218, 165, 32, 0.1);
            }

            .customer-table th {
                background: rgba(218, 165, 32, 0.1);
                color: #DAA520;
                font-weight: 600;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .customer-table td {
                color: #fff;
                font-size: 0.9rem;
            }

            .customer-table tbody tr {
                transition: all 0.3s ease;
            }

            .customer-table tbody tr:hover {
                background: rgba(218, 165, 32, 0.05);
            }

            .customer-id {
                font-family: 'Courier New', monospace;
                color: #DAA520;
                font-weight: 600;
            }

            .customer-name {
                font-weight: 600;
            }

            .customer-email {
                color: #ccc;
            }

            .customer-phone {
                color: #DAA520;
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

            .btn-ban {
                background: rgba(244, 67, 54, 0.2);
                color: #f44336;
                border: 1px solid rgba(244, 67, 54, 0.3);
            }

            .btn-unban {
                background: rgba(76, 175, 80, 0.2);
                color: #4CAF50;
                border: 1px solid rgba(76, 175, 80, 0.3);
            }

            .btn-action:hover {
                transform: translateY(-1px);
            }

            /* Status badges */
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

            .badge-banned {
                background: rgba(244, 67, 54, 0.2);
                color: #f44336;
                border: 1px solid rgba(244, 67, 54, 0.3);
            }

            /* Pagination */
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

            /* Mobile Menu */
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

            /* Responsive */
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

                .customer-table {
                    font-size: 0.8rem;
                }

                .customer-table th,
                .customer-table td {
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
            <!-- Sidebar -->
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

            <!-- Main Content -->
            <main class="main-content">
                <!-- Header -->
                <div class="header">
                    <div>
                        <h1><i class="fas fa-users"></i> Quản lý Khách hàng</h1>
                        <p>Quản lý thông tin và lịch sử dịch vụ của khách hàng</p>
                    </div>
                    <div class="header-actions">
                        <a href="#" class="btn btn-primary">
                            <i class="fas fa-plus"></i>
                            Thêm khách hàng
                        </a>
                    </div>
                </div>

                <!-- Search and Filter Section -->
                <div class="search-section">
                    <div class="search-row">
                        <div class="search-group">
                            <label for="searchName">Tìm kiếm theo tên</label>
                            <input type="text" id="searchName" class="search-input" 
                                   placeholder="Nhập tên khách hàng..." onkeyup="filterCustomers()">
                        </div>
                        <div class="search-group">
                            <label for="searchEmail">Tìm kiếm theo email</label>
                            <input type="text" id="searchEmail" class="search-input" 
                                   placeholder="Nhập email..." onkeyup="filterCustomers()">
                        </div>
                        <div class="search-group">
                            <label for="searchPhone">Tìm kiếm theo SĐT</label>
                            <input type="text" id="searchPhone" class="search-input" 
                                   placeholder="Nhập số điện thoại..." onkeyup="filterCustomers()">
                        </div>
                        <div class="search-group">
                            <label for="sortBy">Sắp xếp theo</label>
                            <select id="sortBy" class="search-select" onchange="sortCustomers()">
                                <option value="id">ID</option>
                                <option value="name">Tên</option>
                                <option value="email">Email</option>
                                <option value="phone">Số điện thoại</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Customer Table -->
                <div class="table-container">
                    <div class="table-header">
                        <h3 class="table-title">Danh sách khách hàng</h3>
                        <div class="table-info">
                            Tổng cộng: <strong id="totalCustomers">5</strong> khách hàng
                        </div>
                    </div>

                    <table class="customer-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Họ và tên</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody id="customerTableBody">
                            <tr>
                                <td class="customer-id">#001</td>
                                <td class="customer-name">Nguyễn Văn An</td>
                                <td class="customer-email">nguyenvanan@email.com</td>
                                <td class="customer-phone">0901234567</td>
                                <td><span class="badge badge-active">Hoạt động</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn-action btn-edit" onclick="editCustomer(1)" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn-action btn-ban" onclick="toggleBanCustomer(1, this)" title="Ban tài khoản">
                                            <i class="fas fa-user-slash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="customer-id">#002</td>
                                <td class="customer-name">Trần Thị Bình</td>
                                <td class="customer-email">tranthibinh@email.com</td>
                                <td class="customer-phone">0912345678</td>
                                <td><span class="badge badge-active">Hoạt động</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn-action btn-edit" onclick="editCustomer(2)" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn-action btn-ban" onclick="toggleBanCustomer(2, this)" title="Ban tài khoản">
                                            <i class="fas fa-user-slash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="customer-id">#003</td>
                                <td class="customer-name">Lê Hoàng Cường</td>
                                <td class="customer-email">lehoangcuong@email.com</td>
                                <td class="customer-phone">0923456789</td>
                                <td><span class="badge badge-banned">Bị ban</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn-action btn-edit" onclick="editCustomer(3)" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn-action btn-unban" onclick="toggleBanCustomer(3, this)" title="Bỏ ban">
                                            <i class="fas fa-user-check"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="customer-id">#004</td>
                                <td class="customer-name">Phạm Minh Đức</td>
                                <td class="customer-email">phamminhduc@email.com</td>
                                <td class="customer-phone">0934567890</td>
                                <td><span class="badge badge-active">Hoạt động</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn-action btn-edit" onclick="editCustomer(4)" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn-action btn-ban" onclick="toggleBanCustomer(4, this)" title="Ban tài khoản">
                                            <i class="fas fa-user-slash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="customer-id">#005</td>
                                <td class="customer-name">Vũ Thị Em</td>
                                <td class="customer-email">vuthiem@email.com</td>
                                <td class="customer-phone">0945678901</td>
                                <td><span class="badge badge-active">Hoạt động</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn-action btn-edit" onclick="editCustomer(5)" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn-action btn-ban" onclick="toggleBanCustomer(5, this)" title="Ban tài khoản">
                                            <i class="fas fa-user-slash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <div class="pagination">
                        <a href="#" class="pagination-btn">&laquo;</a>
                        <a href="#" class="pagination-btn active">1</a>
                        <a href="#" class="pagination-btn">2</a>
                        <a href="#" class="pagination-btn">3</a>
                        <span class="pagination-info">Hiển thị 1-5 của 5 khách hàng</span>
                        <a href="#" class="pagination-btn">4</a>
                        <a href="#" class="pagination-btn">5</a>
                        <a href="#" class="pagination-btn">&raquo;</a>
                    </div>
                </div>
            </main>
        </div>

        <script>
            // Sample customer data for demonstration
            let customers = [
                {id: 1, name: 'Nguyễn Văn An', email: 'nguyenvanan@email.com', phone: '0901234567', status: 0},
                {id: 2, name: 'Trần Thị Bình', email: 'tranthibinh@email.com', phone: '0912345678', status: 0},
                {id: 3, name: 'Lê Hoàng Cường', email: 'lehoangcuong@email.com', phone: '0923456789', status: 1},
                {id: 4, name: 'Phạm Minh Đức', email: 'phamminhduc@email.com', phone: '0934567890', status: 0},
                {id: 5, name: 'Vũ Thị Em', email: 'vuthiem@email.com', phone: '0945678901', status: 0}
            ];

            // Toggle sidebar for mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                sidebar.classList.toggle('active');
            }

            // Toggle ban/unban customer
            function toggleBanCustomer(customerId, buttonElement) {
                const row = buttonElement.closest('tr');
                const statusBadge = row.querySelector('.badge');

                // Find customer in data array
                const customer = customers.find(c => c.id === customerId);

                if (customer) {
                    // Toggle status (0 = active, 1 = banned)
                    customer.status = customer.status === 0 ? 1 : 0;

                    if (customer.status === 1) {
                        // Customer is now banned
                        statusBadge.className = 'badge badge-banned';
                        statusBadge.textContent = 'Bị ban';

                        buttonElement.className = 'btn-action btn-unban';
                        buttonElement.title = 'Bỏ ban';
                        buttonElement.innerHTML = '<i class="fas fa-user-check"></i>';
                    } else {
                        // Customer is now unbanned
                        statusBadge.className = 'badge badge-active';
                        statusBadge.textContent = 'Hoạt động';

                        buttonElement.className = 'btn-action btn-ban';
                        buttonElement.title = 'Ban tài khoản';
                        buttonElement.innerHTML = '<i class="fas fa-user-slash"></i>';
                    }

                    // Here you would typically send an AJAX request to update the database

                }
            }

            // Edit customer function
            function editCustomer(customerId) {
                console.log('Edit customer:', customerId);
                // Implement edit functionality
                alert(`Chỉnh sửa khách hàng #${customerId}`);
            }

            // Filter customers function
            function filterCustomers() {
                const nameFilter = document.getElementById('searchName').value.toLowerCase();
                const emailFilter = document.getElementById('searchEmail').value.toLowerCase();
                const phoneFilter = document.getElementById('searchPhone').value.toLowerCase();

                const rows = document.querySelectorAll('#customerTableBody tr');
                let visibleCount = 0;

                rows.forEach(row => {
                    const name = row.querySelector('.customer-name').textContent.toLowerCase();
                    const email = row.querySelector('.customer-email').textContent.toLowerCase();
                    const phone = row.querySelector('.customer-phone').textContent.toLowerCase();

                    const nameMatch = name.includes(nameFilter);
                    const emailMatch = email.includes(emailFilter);
                    const phoneMatch = phone.includes(phoneFilter);

                    if (nameMatch && emailMatch && phoneMatch) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                });

                document.getElementById('totalCustomers').textContent = visibleCount;
            }

            // Sort customers function
            function sortCustomers() {
                const sortBy = document.getElementById('sortBy').value;
                const tbody = document.getElementById('customerTableBody');
                const rows = Array.from(tbody.querySelectorAll('tr'));

                rows.sort((a, b) => {
                    let aValue, bValue;

                    switch (sortBy) {
                        case 'id':
                            aValue = parseInt(a.querySelector('.customer-id').textContent.replace('#', ''));
                            bValue = parseInt(b.querySelector('.customer-id').textContent.replace('#', ''));
                            break;
                        case 'name':
                            aValue = a.querySelector('.customer-name').textContent.toLowerCase();
                            bValue = b.querySelector('.customer-name').textContent.toLowerCase();
                            break;
                        case 'email':
                            aValue = a.querySelector('.customer-email').textContent.toLowerCase();
                            bValue = b.querySelector('.customer-email').textContent.toLowerCase();
                            break;
                        case 'phone':
                            aValue = a.querySelector('.customer-phone').textContent;
                            bValue = b.querySelector('.customer-phone').textContent;
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

                // Clear tbody and append sorted rows
                tbody.innerHTML = '';
                rows.forEach(row => tbody.appendChild(row));
            }

            // Export customers function
            function exportCustomers() {
                console.log('Exporting customers to Excel...');
                alert('Chức năng xuất Excel sẽ được triển khai sau!');
            }

            // Initialize page
            document.addEventListener('DOMContentLoaded', function () {
                // Update total customers count
                const totalRows = document.querySelectorAll('#customerTableBody tr').length;
                document.getElementById('totalCustomers').textContent = totalRows;

                // Close sidebar when clicking outside on mobile
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
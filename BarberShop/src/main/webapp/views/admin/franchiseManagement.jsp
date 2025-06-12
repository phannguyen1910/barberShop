<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Nhượng quyền - Barbershop Admin</title>
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
                max-height: 60vh;
                overflow-y: auto;
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

            .franchise-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
                min-width: 1000px;
            }

            .franchise-table th,
            .franchise-table td {
                padding: 15px 12px;
                text-align: left;
                border-bottom: 1px solid rgba(218, 165, 32, 0.1);
            }

            .franchise-table th {
                background: rgba(218, 165, 32, 0.1);
                color: #DAA520;
                font-weight: 600;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .franchise-table td {
                color: #fff;
                font-size: 0.9rem;
            }

            .franchise-table tbody tr {
                transition: all 0.3s ease;
            }

            .franchise-table tbody tr:hover {
                background: rgba(218, 165, 32, 0.05);
            }

            .text-content {
                max-width: 200px;
                word-wrap: break-word;
                white-space: pre-wrap;
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

            .badge-approved {
                background: rgba(76, 175, 80, 0.2);
                color: #4CAF50;
                border: 1px solid rgba(76, 175, 80, 0.3);
            }

            .badge-rejected {
                background: rgba(244, 67, 54, 0.2);
                color: #F44336;
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

            .btn-approve {
                background: rgba(76, 175, 80, 0.2);
                color: #4CAF50;
                border: 1px solid rgba(76, 175, 80, 0.3);
            }

            .btn-reject {
                background: rgba(244, 67, 54, 0.2);
                color: #F44336;
                border: 1px solid rgba(244, 67, 54, 0.3);
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
                    grid-template-columns: 1fr;
                }

                .table-container {
                    padding: 15px;
                }

                .franchise-table {
                    font-size: 0.8rem;
                }

                .franchise-table th,
                .franchise-table td {
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
                    <img <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Logo" width="55" height="55" class="me-2">
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
                        <h1><i class="fas fa-handshake"></i> Quản lý Nhượng quyền</h1>
                        <p>Quản lý thông tin nhượng quyền từ khách hàng</p>
                    </div>
                    <div class="header-actions">
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addFranchiseModal">
                            <i class="fas fa-plus"></i>
                            Thêm yêu cầu
                        </button>
                    </div>
                </div>

                <div class="search-section">
                    <div class="search-row">
                        <div class="search-group">
                            <label>Tìm kiếm khách hàng</label>
                            <input type="text" id="searchCustomer" class="search-input" placeholder="Nhập tên, số điện thoại hoặc email">
                        </div>
                        <div class="search-group">
                            <label>Trạng thái</label>
                            <select id="searchStatus" class="search-select">
                                <option value="">Tất cả</option>
                                <option value="pending">Chờ xử lý</option>
                                <option value="approved">Đã duyệt</option>
                                <option value="rejected">Từ chối</option>
                            </select>
                        </div>
                        <div class="search-group">
                            <button class="btn btn-primary" onclick="searchFranchises()">
                                <i class="fas fa-search"></i>
                                Tìm kiếm
                            </button>
                        </div>
                    </div>
                </div>

                <div class="table-container">
                    <div class="table-header">
                        <div>
                            <div class="table-title">Danh sách Yêu cầu Nhượng quyền</div>
                            <div class="table-info" id="tableInfo">Hiển thị 0 yêu cầu</div>
                        </div>
                        <div class="header-actions">
                            <button class="btn btn-secondary" onclick="resetFilters()">
                                <i class="fas fa-sync-alt"></i>
                                Đặt lại
                            </button>
                        </div>
                    </div>
                    <table class="franchise-table">
                        <thead>
                            <tr>
                                <th>Họ và Tên</th>
                                <th>Số Điện Thoại</th>
                                <th>Email</th>
                                <th>Giới thiệu Năng lực</th>
                                <th>Đề xuất Hợp tác</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody id="franchiseTableBody"></tbody>
                    </table>
                </div>
            </main>
        </div>

        <!-- Add Franchise Modal -->
        <div class="modal fade" id="addFranchiseModal" tabindex="-1" aria-labelledby="addFranchiseModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addFranchiseModalLabel">Thêm Yêu cầu Nhượng quyền</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Họ và Tên</label>
                            <input type="text" id="customerName" class="form-control" placeholder="Nhập họ và tên khách hàng">
                        </div>
                        <div class="form-group">
                            <label>Số Điện Thoại</label>
                            <input type="text" id="phoneNumber" class="form-control" placeholder="Nhập số điện thoại">
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" id="email" class="form-control" placeholder="Nhập email">
                        </div>
                        <div class="form-group">
                            <label>Giới thiệu Năng lực</label>
                            <textarea id="capability" class="form-control" rows="4" placeholder="Nhập giới thiệu năng lực"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Đề xuất Hợp tác</label>
                            <textarea id="proposal" class="form-control" rows="4" placeholder="Nhập đề xuất hợp tác"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary" onclick="addFranchise()">Thêm Yêu cầu</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Sample franchise data
            let franchises = [
                {
                    id: "FRAN001",
                    customerName: "Nguyễn Văn A",
                    phoneNumber: "0901234567",
                    email: "nguyenvana@example.com",
                    capability: "Có kinh nghiệm 5 năm trong ngành dịch vụ, đã quản lý 2 salon tóc.",
                    proposal: "Đề xuất mở chi nhánh tại khu vực quận 1, sẵn sàng đầu tư 500 triệu đồng.",
                    status: "pending"
                },
                {
                    id: "FRAN002",
                    customerName: "Trần Thị B",
                    phoneNumber: "0912345678",
                    email: "tranthib@example.com",
                    capability: "Tốt nghiệp quản trị kinh doanh, có mạng lưới khách hàng tại khu vực quận 7.",
                    proposal: "Muốn hợp tác mở chi nhánh tại quận 7, đề xuất chia sẻ lợi nhuận 60/40.",
                    status: "approved"
                },
                {
                    id: "FRAN003",
                    customerName: "Lê Văn C",
                    phoneNumber: "0923456789",
                    email: "levanc@example.com",
                    capability: "Chưa có kinh nghiệm trong ngành, nhưng có khả năng tài chính mạnh.",
                    proposal: "Đề xuất mở chi nhánh tại quận 3, cần hỗ trợ đào tạo nhân viên.",
                    status: "rejected"
                }
            ];

            // Filtered franchises
            let filteredFranchises = [...franchises];

            // Initialize page
            document.addEventListener('DOMContentLoaded', function () {
                renderFranchises();
            });

            // Toggle sidebar for mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                if (sidebar) {
                    sidebar.classList.toggle('active');
                }
            }

            // Render franchises
            function renderFranchises() {
                const tableBody = document.getElementById('franchiseTableBody');
                if (!tableBody)
                    return;

                tableBody.innerHTML = '';

                filteredFranchises.forEach(franchise => {
                    const row = document.createElement('tr');

                    // Customer Name
                    const nameCell = document.createElement('td');
                    nameCell.textContent = franchise.customerName || 'N/A';
                    row.appendChild(nameCell);

                    // Phone Number
                    const phoneCell = document.createElement('td');
                    phoneCell.textContent = franchise.phoneNumber || 'N/A';
                    row.appendChild(phoneCell);

                    // Email
                    const emailCell = document.createElement('td');
                    emailCell.textContent = franchise.email || 'N/A';
                    row.appendChild(emailCell);

                    // Capability
                    const capabilityCell = document.createElement('td');
                    capabilityCell.className = 'text-content';
                    capabilityCell.textContent = franchise.capability || 'Chưa có thông tin';
                    row.appendChild(capabilityCell);

                    // Proposal
                    const proposalCell = document.createElement('td');
                    proposalCell.className = 'text-content';
                    proposalCell.textContent = franchise.proposal || 'Chưa có thông tin';
                    row.appendChild(proposalCell);

                    // Status
                    const statusCell = document.createElement('td');
                    const statusSpan = document.createElement('span');
                    const statusValue = franchise.status || 'pending';
                    statusSpan.className = 'badge badge-' + statusValue;
                    statusSpan.textContent = getStatusText(statusValue);
                    statusCell.appendChild(statusSpan);
                    row.appendChild(statusCell);

                    // Actions
                    const actionsCell = document.createElement('td');
                    actionsCell.className = 'action-buttons';
                    if (statusValue === 'pending') {
                        const approveBtn = document.createElement('button');
                        approveBtn.className = 'btn-action btn-approve';
                        approveBtn.textContent = 'Duyệt';
                        approveBtn.onclick = function () {
                            updateStatus(franchise.id, 'approved');
                        };
                        actionsCell.appendChild(approveBtn);

                        const rejectBtn = document.createElement('button');
                        rejectBtn.className = 'btn-action btn-reject';
                        rejectBtn.textContent = 'Từ chối';
                        rejectBtn.onclick = function () {
                            updateStatus(franchise.id, 'rejected');
                        };
                        actionsCell.appendChild(rejectBtn);
                    }
                    row.appendChild(actionsCell);

                    tableBody.appendChild(row);
                });

                const tableInfo = document.getElementById('tableInfo');
                if (tableInfo) {
                    tableInfo.textContent = 'Hiển thị ' + filteredFranchises.length + ' yêu cầu';
                }
            }

            // Get status text
            function getStatusText(status) {
                switch (status) {
                    case 'pending':
                        return 'Chờ xử lý';
                    case 'approved':
                        return 'Đã duyệt';
                    case 'rejected':
                        return 'Từ chối';
                    default:
                        return 'Không xác định';
                }
            }

            // Search franchises
            function searchFranchises() {
                const query = document.getElementById('searchCustomer').value.toLowerCase();
                const status = document.getElementById('searchStatus').value;

                filteredFranchises = franchises.filter(function (franchise) {
                    const matchesQuery = (franchise.customerName || '').toLowerCase().includes(query) ||
                            (franchise.phoneNumber || '').includes(query) ||
                            (franchise.email || '').toLowerCase().includes(query);
                    const matchesStatus = !status || franchise.status === status;

                    return matchesQuery && matchesStatus;
                });

                renderFranchises();
            }

            // Reset filters
            function resetFilters() {
                document.getElementById('searchCustomer').value = '';
                document.getElementById('searchStatus').value = '';
                filteredFranchises = [...franchises];
                renderFranchises();
            }

            // Add franchise
            function addFranchise() {
                const customerName = document.getElementById('customerName').value;
                const phoneNumber = document.getElementById('phoneNumber').value;
                const email = document.getElementById('email').value;
                const capability = document.getElementById('capability').value;
                const proposal = document.getElementById('proposal').value;

                if (!customerName || !phoneNumber || !email || !capability || !proposal) {
                    alert('Vui lòng điền đầy đủ thông tin!');
                    return;
                }

                const newFranchise = {
                    id: 'FRAN' + (franchises.length + 1).toString().padStart(3, '0'),
                    customerName: customerName,
                    phoneNumber: phoneNumber,
                    email: email,
                    capability: capability,
                    proposal: proposal,
                    status: 'pending'
                };

                franchises.push(newFranchise);
                filteredFranchises = [...franchises];
                renderFranchises();
                resetAddModal();

                if (typeof bootstrap !== 'undefined') {
                    const modal = bootstrap.Modal.getInstance(document.getElementById('addFranchiseModal'));
                    modal.hide();
                } else {
                    document.getElementById('addFranchiseModal').classList.remove('show');
                    document.body.classList.remove('modal-open');
                    document.querySelector('.modal-backdrop').remove();
                }
            }

            // Reset add modal
            function resetAddModal() {
                document.getElementById('customerName').value = '';
                document.getElementById('phoneNumber').value = '';
                document.getElementById('email').value = '';
                document.getElementById('capability').value = '';
                document.getElementById('proposal').value = '';
            }

            // Update franchise status
            function updateStatus(id, newStatus) {
                const franchise = franchises.find(function (f) {
                    return f.id === id;
                });
                if (!franchise)
                    return;

                if (confirm('Bạn có chắc chắn muốn ' + (newStatus === 'approved' ? 'duyệt' : 'từ chối') + ' yêu cầu này?')) {
                    franchise.status = newStatus;
                    renderFranchises();
                }
            }
        </script>
    </body>
</html>
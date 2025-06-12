<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Phản hồi - Barbershop Admin</title>
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

            .feedback-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
                min-width: 800px;
            }

            .feedback-table th,
            .feedback-table td {
                padding: 15px 12px;
                text-align: left;
                border-bottom: 1px solid rgba(218, 165, 32, 0.1);
            }

            .feedback-table th {
                background: rgba(218, 165, 32, 0.1);
                color: #DAA520;
                font-weight: 600;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .feedback-table td {
                color: #fff;
                font-size: 0.9rem;
            }

            .feedback-table tbody tr {
                transition: all 0.3s ease;
            }

            .feedback-table tbody tr:hover {
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

            .star-rating {
                color: #FFC107;
                font-size: 1rem;
            }

            .feedback-text {
                max-width: 300px;
                word-wrap: break-word;
                white-space: pre-wrap;
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

                .stats-grid {
                    grid-template-columns: 1fr;
                }

                .search-row {
                    grid-template-columns: 1fr;
                }

                .table-container {
                    padding: 15px;
                }

                .feedback-table {
                    font-size: 0.8rem;
                }

                .feedback-table th,
                .feedback-table td {
                    padding: 10px 8px;
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
                        <h1><i class="fas fa-comments"></i> Quản lý Phản hồi</h1>
                        <p>Xem và quản lý phản hồi từ khách hàng</p>
                    </div>
                    <div class="header-actions">
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addFeedbackModal">
                            <i class="fas fa-plus"></i>
                            Thêm phản hồi
                        </button>
                    </div>
                </div>

                <div class="search-section">
                    <div class="search-row">
                        <div class="search-group">
                            <label>Tìm kiếm phản hồi</label>
                            <input type="text" id="searchFeedback" class="search-input" placeholder="Nhập tên khách hàng hoặc mã lịch hẹn">
                        </div>
                        <div class="search-group">
                            <label>Đánh giá sao</label>
                            <select id="searchRating" class="search-select">
                                <option value="">Tất cả</option>
                                <option value="1">1 Sao</option>
                                <option value="2">2 Sao</option>
                                <option value="3">3 Sao</option>
                                <option value="4">4 Sao</option>
                                <option value="5">5 Sao</option>
                            </select>
                        </div>
                        <div class="search-group">
                            <button class="btn btn-primary" onclick="searchFeedbacks()">
                                <i class="fas fa-search"></i>
                                Tìm kiếm
                            </button>
                        </div>
                    </div>
                </div>

                <div class="table-container">
                    <div class="table-header">
                        <div>
                            <div class="table-title">Danh sách Phản hồi</div>
                            <div class="table-info" id="tableInfo">Hiển thị 0 phản hồi</div>
                        </div>
                        <div class="header-actions">
                            <button class="btn btn-secondary" onclick="resetFilters()">
                                <i class="fas fa-sync-alt"></i>
                                Đặt lại
                            </button>
                        </div>
                    </div>
                    <table class="feedback-table">
                        <thead>
                            <tr>
                                <th>Mã lịch hẹn</th>
                                <th>Tên nhân viên</th>
                                <th>Tên khách hàng</th>
                                <th>Đánh giá sao</th>
                                <th>Phản hồi</th>
                            </tr>
                        </thead>
                        <tbody id="feedbackTableBody"></tbody>
                    </table>
                </div>
            </main>
        </div>

        <!-- Add Feedback Modal -->
        <div class="modal fade" id="addFeedbackModal" tabindex="-1" aria-labelledby="addFeedbackModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addFeedbackModalLabel">Thêm phản hồi mới</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Tên nhân viên</label>
                            <input type="text" id="staffName" class="form-control" placeholder="Nhập tên nhân viên">
                        </div>
                        <div class="form-group">
                            <label>Tên khách hàng</label>
                            <input type="text" id="customerName" class="form-control" placeholder="Nhập tên khách hàng">
                        </div>
                        <div class="form-group">
                            <label>Mã lịch hẹn</label>
                            <input type="text" id="appointmentId" class="form-control" placeholder="Nhập mã lịch hẹn">
                        </div>
                        <div class="form-group">
                            <label>Đánh giá sao</label>
                            <select id="rating" class="form-control">
                                <option value="1">1 Sao</option>
                                <option value="2">2 Sao</option>
                                <option value="3">3 Sao</option>
                                <option value="4">4 Sao</option>
                                <option value="5">5 Sao</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Phản hồi</label>
                            <textarea id="feedbackText" class="form-control" rows="4" placeholder="Nhập phản hồi"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary" onclick="addFeedback()">Thêm phản hồi</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Sample feedback data
            let feedbacks = [
                {
                    appointmentId: "APPT001",
                    staffName: "Nguyễn Văn A",
                    customerName: "Trần Minh Cường",
                    rating: 4,
                    feedback: "Dịch vụ rất tốt, nhân viên thân thiện. "
                },
                {
                    appointmentId: "APPT002",
                    staffName: "Trần Thị C",
                    customerName: "Lê Văn D",
                    rating: 5,
                    feedback: "Tuyệt vời, sẽ quay lại lần sau!"
                },
                {
                    appointmentId: "APPT003",
                    staffName: "Lê Văn E",
                    customerName: "Phạm Thị F",
                    rating: 3,
                    feedback: "Dịch vụ ổn, nhưng chờ hơi lâu."
                }
            ];

            // Filtered feedbacks
            let filteredFeedbacks = [...feedbacks];

            // Initialize page
            document.addEventListener('DOMContentLoaded', function () {
                renderFeedbacks();
            });

            // Toggle sidebar for mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                if (sidebar) {
                    sidebar.classList.toggle('active');
                }
            }

            // Render feedbacks
            function renderFeedbacks() {
                const tableBody = document.getElementById('feedbackTableBody');
                if (!tableBody)
                    return;

                tableBody.innerHTML = '';

                filteredFeedbacks.forEach(feedback => {
                    const row = document.createElement('tr');

                    // Appointment ID
                    const idCell = document.createElement('td');
                    idCell.className = 'appointment-id';
                    idCell.textContent = feedback.appointmentId || 'N/A';
                    row.appendChild(idCell);

                    // Staff Name
                    const staffCell = document.createElement('td');
                    staffCell.textContent = feedback.staffName || 'N/A';
                    row.appendChild(staffCell);

                    // Customer Name
                    const customerCell = document.createElement('td');
                    customerCell.className = 'customer-info';
                    const avatarDiv = document.createElement('div');
                    avatarDiv.className = 'customer-avatar';
                    avatarDiv.textContent = feedback.customerName?.charAt(0) || '?';
                    const nameDiv = document.createElement('div');
                    nameDiv.textContent = feedback.customerName || 'N/A';
                    customerCell.appendChild(avatarDiv);
                    customerCell.appendChild(nameDiv);
                    row.appendChild(customerCell);

                    // Star Rating
                    const ratingCell = document.createElement('td');
                    ratingCell.className = 'star-rating';
                    for (let i = 0; i < 5; i++) {
                        const star = document.createElement('i');
                        star.className = 'fas fa-star';
                        star.style.color = i < feedback.rating ? '#FFC107' : '#ccc';
                        ratingCell.appendChild(star);
                    }
                    row.appendChild(ratingCell);

                    // Feedback
                    const feedbackCell = document.createElement('td');
                    feedbackCell.className = 'feedback-text';
                    feedbackCell.textContent = feedback.feedback || 'Chưa có phản hồi';
                    row.appendChild(feedbackCell);

                    tableBody.appendChild(row);
                });

                const tableInfo = document.getElementById('tableInfo');
                if (tableInfo) {
                    tableInfo.textContent = 'Hiển thị ' + filteredFeedbacks.length + ' phản hồi';
                }
            }

            // Search feedbacks
            function searchFeedbacks() {
                const query = document.getElementById('searchFeedback').value.toLowerCase();
                const rating = document.getElementById('searchRating').value;

                filteredFeedbacks = feedbacks.filter(function (feedback) {
                    const matchesQuery = (feedback.customerName || '').toLowerCase().includes(query) ||
                            (feedback.appointmentId || '').toLowerCase().includes(query);
                    const matchesRating = !rating || feedback.rating === parseInt(rating);

                    return matchesQuery && matchesRating;
                });

                renderFeedbacks();
            }

            // Reset filters
            function resetFilters() {
                document.getElementById('searchFeedback').value = '';
                document.getElementById('searchRating').value = '';
                filteredFeedbacks = [...feedbacks];
                renderFeedbacks();
            }

            // Add feedback
            function addFeedback() {
                const staffName = document.getElementById('staffName').value;
                const customerName = document.getElementById('customerName').value;
                const appointmentId = document.getElementById('appointmentId').value;
                const rating = parseInt(document.getElementById('rating').value);
                const feedbackText = document.getElementById('feedbackText').value;

                if (!staffName || !customerName || !appointmentId || !rating || !feedbackText) {
                    alert('Vui lòng điền đầy đủ thông tin!');
                    return;
                }

                const newFeedback = {
                    appointmentId: appointmentId,
                    staffName: staffName,
                    customerName: customerName,
                    rating: rating,
                    feedback: feedbackText
                };

                feedbacks.push(newFeedback);
                filteredFeedbacks = [...feedbacks];
                renderFeedbacks();
                resetAddModal();

                if (typeof bootstrap !== 'undefined') {
                    const modal = bootstrap.Modal.getInstance(document.getElementById('addFeedbackModal'));
                    modal.hide();
                } else {
                    document.getElementById('addFeedbackModal').classList.remove('show');
                    document.body.classList.remove('modal-open');
                    document.querySelector('.modal-backdrop').remove();
                }
            }

            // Reset add modal
            function resetAddModal() {
                document.getElementById('staffName').value = '';
                document.getElementById('customerName').value = '';
                document.getElementById('appointmentId').value = '';
                document.getElementById('rating').value = '1';
                document.getElementById('feedbackText').value = '';
            }
        </script>
    </body>
</html>
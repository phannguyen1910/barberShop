<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Barbershop Admin Dashboard</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
        <link rel="stylesheet" href="CSS/html.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <style>
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

            /* Top Navigation Bar */
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

            /* Sidebar */
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

            .date-time {
                float: right;
                text-align: right;
                color: #DAA520;
                font-size: 0.9rem;
            }

            /* Stats Cards */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 25px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 25px;
                border: 1px solid rgba(218, 165, 32, 0.2);
                position: relative;
                overflow: hidden;
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 3px;
                background: linear-gradient(90deg, #DAA520, #B8860B);
            }

            .stat-icon {
                width: 60px;
                height: 60px;
                background: rgba(218, 165, 32, 0.1);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #DAA520;
                font-size: 1.5rem;
                margin-bottom: 15px;
            }

            .stat-number {
                font-size: 2.5rem;
                font-weight: 700;
                color: #fff;
                margin-bottom: 5px;
            }

            .stat-label {
                color: #ccc;
                font-size: 1rem;
                margin-bottom: 10px;
            }

            .stat-change {
                font-size: 0.85rem;
                color: #4CAF50;
            }

            .stat-change.negative {
                color: #f44336;
            }

            /* Chart Section */
            .chart-section {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 25px;
                margin-bottom: 30px;
            }

            .chart-card {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 25px;
                border: 1px solid rgba(218, 165, 32, 0.2);
            }

            .chart-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .chart-title {
                font-size: 1.3rem;
                color: #DAA520;
                font-weight: 600;
            }

            .chart-period {
                background: rgba(218, 165, 32, 0.1);
                color: #DAA520;
                padding: 5px 15px;
                border-radius: 20px;
                font-size: 0.85rem;
                border: 1px solid rgba(218, 165, 32, 0.2);
            }

            .chart-container {
                position: relative;
                height: 300px;
            }

            /* Recent Activities */
            .activity-item {
                display: flex;
                align-items: center;
                padding: 15px 0;
                border-bottom: 1px solid rgba(218, 165, 32, 0.1);
            }

            .activity-item:last-child {
                border-bottom: none;
            }

            .activity-icon {
                width: 40px;
                height: 40px;
                background: rgba(218, 165, 32, 0.1);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #DAA520;
                margin-right: 15px;
                font-size: 0.9rem;
            }

            .activity-content {
                flex: 1;
            }

            .activity-text {
                color: #fff;
                font-size: 0.9rem;
                margin-bottom: 3px;
            }

            .activity-time {
                color: #999;
                font-size: 0.8rem;
            }

            /* Mobile Responsive */
            .mobile-menu-btn {
                display: none;
                position: fixed;
                top: 85px;
                left: 20px;
                z-index: 1001;
                background: rgba(29, 29, 27, 0.9);
                color: #DAA520;
                border: none;
                padding: 10px;
                border-radius: 5px;
                font-size: 1.2rem;
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
                    padding: 20px;
                }

                .chart-section {
                    grid-template-columns: 1fr;
                }

                .stats-grid {
                    grid-template-columns: 1fr;
                }

                .date-time {
                    float: none;
                    text-align: left;
                    margin-top: 10px;
                }

                .dashboard-layout {
                    padding-top: 70px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Top Navigation Bar -->
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
            <!-- Main Content -->
            <main class="main-content">
                <!-- Header -->
                <div class="header">
                    <div class="row" style="align-items:  center">
                        <div>
                            <h1><i class="fas fa-tachometer-alt"></i> Dashboard</h1>
                            <p>Tổng quan hoạt động kinh doanh</p>
                        </div>
                        <div class="date-time">
                            <div id="current-date"></div>
                            <div id="current-time"></div>
                        </div>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-number">1,234</div>
                        <div class="stat-label">Tổng số khách hàng</div>
                        <div class="stat-change">
                            <i class="fas fa-arrow-up"></i> +12% so với tháng trước
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-cut"></i>
                        </div>
                        <div class="stat-number">28</div>
                        <div class="stat-label">Tổng số dịch vụ</div>
                        <div class="stat-change">
                            <i class="fas fa-arrow-up"></i> +3 dịch vụ mới
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="stat-number">156</div>
                        <div class="stat-label">Lịch hẹn hôm nay</div>
                        <div class="stat-change">
                            <i class="fas fa-arrow-up"></i> +8% so với hôm qua
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="stat-number">₫2.5M</div>
                        <div class="stat-label">Doanh thu hôm nay</div>
                        <div class="stat-change">
                            <i class="fas fa-arrow-up"></i> +15% so với hôm qua
                        </div>
                    </div>
                </div>

                <!-- Chart Section -->
                <div class="chart-section">
                    <div class="chart-card">
                        <div class="chart-header">
                            <h3 class="chart-title">Doanh thu theo tháng</h3>
                            <span class="chart-period">12 tháng gần nhất</span>
                        </div>
                        <div class="chart-container">
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>

                    <div class="chart-card">
                        <div class="chart-header">
                            <h3 class="chart-title">Hoạt động gần đây</h3>
                        </div>
                        <div class="activities">
                            <div class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-user-plus"></i>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-text">Khách hàng mới đăng ký</div>
                                    <div class="activity-time">5 phút trước</div>
                                </div>
                            </div>
                            <div class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-calendar-check"></i>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-text">Lịch hẹn được xác nhận</div>
                                    <div class="activity-time">10 phút trước</div>
                                </div>
                            </div>
                            <div class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-star"></i>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-text">Đánh giá 5 sao mới</div>
                                    <div class="activity-time">15 phút trước</div>
                                </div>
                            </div>
                            <div class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-dollar-sign"></i>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-text">Thanh toán hoàn tất</div>
                                    <div class="activity-time">20 phút trước</div>
                                </div>
                            </div>
                            <div class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-user-tie"></i>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-text">Nhân viên check-in</div>
                                    <div class="activity-time">25 phút trước</div>
                                </div>
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

            // Update date and time
            function updateDateTime() {
                const now = new Date();
                const dateOptions = {
                    weekday: 'long',
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric'
                };
                const timeOptions = {
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit'
                };

                document.getElementById('current-date').textContent =
                        now.toLocaleDateString('vi-VN', dateOptions);
                document.getElementById('current-time').textContent =
                        now.toLocaleTimeString('vi-VN', timeOptions);
            }

            // Initialize chart
            function initRevenueChart() {
                const ctx = document.getElementById('revenueChart').getContext('2d');
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                        datasets: [{
                                label: 'Doanh thu (triệu VNĐ)',
                                data: [65, 75, 80, 85, 90, 95, 88, 92, 97, 85, 90, 105],
                                borderColor: '#DAA520',
                                backgroundColor: 'rgba(218, 165, 32, 0.1)',
                                borderWidth: 3,
                                fill: true,
                                tension: 0.4,
                                pointBackgroundColor: '#DAA520',
                                pointBorderColor: '#1d1d1b',
                                pointBorderWidth: 2,
                                pointRadius: 6
                            }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                labels: {
                                    color: '#ccc'
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(218, 165, 32, 0.1)'
                                },
                                ticks: {
                                    color: '#ccc'
                                }
                            },
                            x: {
                                grid: {
                                    color: 'rgba(218, 165, 32, 0.1)'
                                },
                                ticks: {
                                    color: '#ccc'
                                }
                            }
                        }
                    }
                });
            }

            // Initialize when page loads
            document.addEventListener('DOMContentLoaded', function () {
                updateDateTime();
                setInterval(updateDateTime, 1000);
                initRevenueChart();
            });

            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function (event) {
                const sidebar = document.getElementById('sidebar');
                const menuBtn = document.querySelector('.mobile-menu-btn');

                if (window.innerWidth <= 768 && !sidebar.contains(event.target) && !menuBtn.contains(event.target)) {
                    sidebar.classList.remove('active');
                }
            });
        </script>
    </body>
</html>
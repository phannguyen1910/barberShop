<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Doanh thu - Barbershop Admin</title>
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
                margin-bottom: 30px;
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
                background: rgba(218, 165, 32, 0.2);
                color: #DAA520;
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

            .revenue-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
                min-width: 800px;
            }

            .revenue-table th,
            .revenue-table td {
                padding: 15px 12px;
                text-align: left;
                border-bottom: 1px solid rgba(218, 165, 32, 0.1);
            }

            .revenue-table th {
                background: rgba(218, 165, 32, 0.1);
                color: #DAA520;
                font-weight: 600;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .revenue-table td {
                color: #fff;
                font-size: 0.9rem;
            }

            .revenue-table tbody tr {
                transition: all 0.3s ease;
            }

            .revenue-table tbody tr:hover {
                background: rgba(218, 165, 32, 0.05);
            }

            .money {
                color: #DAA520;
                font-weight: 600;
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

                .revenue-table {
                    font-size: 0.8rem;
                }

                .revenue-table th,
                .revenue-table td {
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
                        <h1><i class="fas fa-chart-line"></i> Quản lý Doanh thu</h1>
                        <p>Xem và quản lý doanh thu của cửa hàng</p>
                    </div>
                </div>

                <div class="search-section">
                    <div class="search-row">
                        <div class="search-group">
                            <label>Xem theo</label>
                            <select id="viewType" class="search-select" onchange="toggleViewOptions()">
                                <option value="day">Ngày</option>
                                <option value="month">Tháng</option>
                                <option value="year">Năm</option>
                                <option value="quarter">Quý</option>
                            </select>
                        </div>
                        <div class="search-group" id="dayFilter">
                            <label>Chọn Ngày</label>
                            <input type="date" id="searchDay" class="search-input">
                        </div>
                        <div class="search-group" id="monthFilter" style="display: none;">
                            <label>Chọn Tháng</label>
                            <select id="searchMonth" class="search-select">
                                <option value="1">Tháng 1</option>
                                <option value="2">Tháng 2</option>
                                <option value="3">Tháng 3</option>
                                <option value="4">Tháng 4</option>
                                <option value="5">Tháng 5</option>
                                <option value="6">Tháng 6</option>
                                <option value="7">Tháng 7</option>
                                <option value="8">Tháng 8</option>
                                <option value="9">Tháng 9</option>
                                <option value="10">Tháng 10</option>
                                <option value="11">Tháng 11</option>
                                <option value="12">Tháng 12</option>
                            </select>
                        </div>
                        <div class="search-group" id="monthYearFilter" style="display: none;">
                            <label>Chọn Năm</label>
                            <input type="number" id="searchMonthYear" class="search-input" placeholder="Nhập năm" value="2025">
                        </div>
                        <div class="search-group" id="yearFilter" style="display: none;">
                            <label>Chọn Năm</label>
                            <input type="number" id="searchYear" class="search-input" placeholder="Nhập năm" value="2025">
                        </div>
                        <div class="search-group" id="quarterFilter" style="display: none;">
                            <label>Chọn Quý</label>
                            <select id="searchQuarter" class="search-select">
                                <option value="Q1">Quý 1 (Tháng 1-3)</option>
                                <option value="Q2">Quý 2 (Tháng 4-6)</option>
                                <option value="Q3">Quý 3 (Tháng 7-9)</option>
                                <option value="Q4">Quý 4 (Tháng 10-12)</option>
                            </select>
                        </div>
                        <div class="search-group" id="quarterYearFilter" style="display: none;">
                            <label>Chọn Năm</label>
                            <input type="number" id="searchQuarterYear" class="search-input" placeholder="Nhập năm" value="2025">
                        </div>
                        <div class="search-group">
                            <button class="btn btn-primary" onclick="filterRevenue()">
                                <i class="fas fa-search"></i>
                                Xem Doanh thu
                            </button>
                        </div>
                    </div>
                </div>

                <div class="stats-card">
                    <div class="stats-icon">
                        <i class="fas fa-money-bill-wave"></i>
                    </div>
                    <div class="stats-info">
                        <h3 id="totalRevenue">0 VNĐ</h3>
                        <p>Tổng Doanh thu</p>
                    </div>
                </div>

                <div class="table-container">
                    <div class="table-header">
                        <div>
                            <div class="table-title">Báo cáo Doanh thu</div>
                            <div class="table-info" id="tableInfo">Hiển thị 0 mục</div>
                        </div>
                        <div class="header-actions">
                            <button class="btn btn-secondary" onclick="resetFilters()">
                                <i class="fas fa-sync-alt"></i>
                                Đặt lại
                            </button>
                        </div>
                    </div>
                    <table class="revenue-table">
                        <thead>
                            <tr>
                                <th id="periodColumn">Ngày</th>
                                <th>Tổng Doanh thu</th>
                                <th>Số Lịch hẹn</th>
                                <th>Doanh thu Trung bình/Lịch hẹn</th>
                            </tr>
                        </thead>
                        <tbody id="revenueTableBody"></tbody>
                    </table>
                </div>
            </main>
        </div>

        <script>
            // Sample revenue data
            let revenueData = [
                { date: "2025-01-15", revenue: 1500000, appointments: 5 },
                { date: "2025-01-20", revenue: 2000000, appointments: 6 },
                { date: "2025-02-10", revenue: 1800000, appointments: 4 },
                { date: "2025-03-05", revenue: 2200000, appointments: 7 },
                { date: "2025-04-12", revenue: 2500000, appointments: 8 },
                { date: "2025-04-25", revenue: 1900000, appointments: 5 },
                { date: "2025-05-24", revenue: 3000000, appointments: 10 },
                { date: "2025-07-01", revenue: 2800000, appointments: 9 },
                { date: "2025-08-15", revenue: 2600000, appointments: 7 },
                { date: "2025-10-10", revenue: 3200000, appointments: 11 },
                { date: "2025-11-20", revenue: 2700000, appointments: 8 }
            ];

            // Filtered revenue data
            let filteredRevenueData = [];

            // Initialize page
            document.addEventListener('DOMContentLoaded', function() {
                renderRevenue();
            });

            // Toggle sidebar for mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                if (sidebar) {
                    sidebar.classList.toggle('active');
                }
            }

            // Toggle view options (day, month, year, quarter)
            function toggleViewOptions() {
                const viewType = document.getElementById('viewType').value;
                document.getElementById('dayFilter').style.display = viewType === 'day' ? 'block' : 'none';
                document.getElementById('monthFilter').style.display = viewType === 'month' ? 'block' : 'none';
                document.getElementById('monthYearFilter').style.display = viewType === 'month' ? 'block' : 'none';
                document.getElementById('yearFilter').style.display = viewType === 'year' ? 'block' : 'none';
                document.getElementById('quarterFilter').style.display = viewType === 'quarter' ? 'block' : 'none';
                document.getElementById('quarterYearFilter').style.display = viewType === 'quarter' ? 'block' : 'none';
                document.getElementById('periodColumn').textContent = viewType === 'day' ? 'Ngày' : viewType === 'month' ? 'Tháng' : viewType === 'year' ? 'Năm' : 'Quý';
            }

            // Filter revenue based on selection
            function filterRevenue() {
                const viewType = document.getElementById('viewType').value;
                filteredRevenueData = [];

                if (viewType === 'day') {
                    const selectedDay = document.getElementById('searchDay').value;
                    if (selectedDay) {
                        filteredRevenueData = revenueData.filter(function(entry) {
                            return entry.date === selectedDay;
                        });
                    } else {
                        filteredRevenueData = [...revenueData];
                    }
                } else if (viewType === 'month') {
                    const selectedMonth = parseInt(document.getElementById('searchMonth').value);
                    const selectedYear = parseInt(document.getElementById('searchMonthYear').value);
                    if (!selectedYear) {
                        alert('Vui lòng nhập năm!');
                        return;
                    }

                    const groupedData = {};
                    revenueData.forEach(function(entry) {
                        const date = new Date(entry.date);
                        const month = date.getMonth() + 1;
                        const year = date.getFullYear();

                        if (month === selectedMonth && year === selectedYear) {
                            const key = `${month}/${year}`;
                            if (!groupedData[key]) {
                                groupedData[key] = { revenue: 0, appointments: 0 };
                            }
                            groupedData[key].revenue += entry.revenue;
                            groupedData[key].appointments += entry.appointments;
                        }
                    });

                    for (const period in groupedData) {
                        filteredRevenueData.push({
                            period: period,
                            revenue: groupedData[period].revenue,
                            appointments: groupedData[period].appointments
                        });
                    }
                } else if (viewType === 'year') {
                    const selectedYear = parseInt(document.getElementById('searchYear').value);
                    if (!selectedYear) {
                        alert('Vui lòng nhập năm!');
                        return;
                    }

                    const groupedData = {};
                    revenueData.forEach(function(entry) {
                        const date = new Date(entry.date);
                        const year = date.getFullYear();

                        if (year === selectedYear) {
                            const key = `${year}`;
                            if (!groupedData[key]) {
                                groupedData[key] = { revenue: 0, appointments: 0 };
                            }
                            groupedData[key].revenue += entry.revenue;
                            groupedData[key].appointments += entry.appointments;
                        }
                    });

                    for (const period in groupedData) {
                        filteredRevenueData.push({
                            period: period,
                            revenue: groupedData[period].revenue,
                            appointments: groupedData[period].appointments
                        });
                    }
                } else if (viewType === 'quarter') {
                    const selectedQuarter = document.getElementById('searchQuarter').value;
                    const selectedYear = parseInt(document.getElementById('searchQuarterYear').value);
                    if (!selectedYear) {
                        alert('Vui lòng nhập năm!');
                        return;
                    }

                    const quarterMonths = {
                        'Q1': [1, 2, 3],
                        'Q2': [4, 5, 6],
                        'Q3': [7, 8, 9],
                        'Q4': [10, 11, 12]
                    };

                    const months = quarterMonths[selectedQuarter];
                    const groupedData = {};

                    revenueData.forEach(function(entry) {
                        const date = new Date(entry.date);
                        const month = date.getMonth() + 1;
                        const year = date.getFullYear();

                        if (months.includes(month) && year === selectedYear) {
                            const key = `${selectedQuarter} ${year}`;
                            if (!groupedData[key]) {
                                groupedData[key] = { revenue: 0, appointments: 0 };
                            }
                            groupedData[key].revenue += entry.revenue;
                            groupedData[key].appointments += entry.appointments;
                        }
                    });

                    for (const period in groupedData) {
                        filteredRevenueData.push({
                            period: period,
                            revenue: groupedData[period].revenue,
                            appointments: groupedData[period].appointments
                        });
                    }
                }

                renderRevenue();
            }

            // Render revenue data
            function renderRevenue() {
                const tableBody = document.getElementById('revenueTableBody');
                if (!tableBody) return;

                tableBody.innerHTML = '';

                const viewType = document.getElementById('viewType').value;
                let totalRevenue = 0;

                filteredRevenueData.forEach(function(entry) {
                    const row = document.createElement('tr');

                    // Period (Day, Month, Year, or Quarter)
                    const periodCell = document.createElement('td');
                    periodCell.textContent = viewType === 'day' ? (entry.date || 'N/A') : (entry.period || 'N/A');
                    row.appendChild(periodCell);

                    // Total Revenue
                    const revenueCell = document.createElement('td');
                    revenueCell.className = 'money';
                    const revenue = entry.revenue || 0;
                    revenueCell.textContent = revenue.toLocaleString('vi-VN') + ' VNĐ';
                    totalRevenue += revenue;
                    row.appendChild(revenueCell);

                    // Number of Appointments
                    const appointmentsCell = document.createElement('td');
                    const appointments = entry.appointments || 0;
                    appointmentsCell.textContent = appointments;
                    row.appendChild(appointmentsCell);

                    // Average Revenue per Appointment
                    const avgRevenueCell = document.createElement('td');
                    const avgRevenue = appointments > 0 ? Math.round(revenue / appointments) : 0;
                    avgRevenueCell.className = 'money';
                    avgRevenueCell.textContent = avgRevenue.toLocaleString('vi-VN') + ' VNĐ';
                    row.appendChild(avgRevenueCell);

                    tableBody.appendChild(row);
                });

                // Update total revenue
                const totalRevenueElement = document.getElementById('totalRevenue');
                if (totalRevenueElement) {
                    totalRevenueElement.textContent = totalRevenue.toLocaleString('vi-VN') + ' VNĐ';
                }

                // Update table info
                const tableInfo = document.getElementById('tableInfo');
                if (tableInfo) {
                    tableInfo.textContent = 'Hiển thị ' + filteredRevenueData.length + ' mục';
                }
            }

            // Reset filters
            function resetFilters() {
                document.getElementById('viewType').value = 'day';
                document.getElementById('searchDay').value = '';
                document.getElementById('searchMonth').value = '1';
                document.getElementById('searchMonthYear').value = '2025';
                document.getElementById('searchYear').value = '2025';
                document.getElementById('searchQuarter').value = 'Q1';
                document.getElementById('searchQuarterYear').value = '2025';
                toggleViewOptions();
                filteredRevenueData = [...revenueData];
                renderRevenue();
            }
        </script>
    </body>
</html>
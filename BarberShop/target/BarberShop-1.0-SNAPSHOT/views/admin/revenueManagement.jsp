<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        /* [Existing CSS remains unchanged] */
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
            display: flex;
            justify-content: space-between;
            align-items: end;
            gap: 20px;
        }

        .search-group {
            display: flex;
            flex-direction: column;
            flex: 1;
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
                flex-direction: column;
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

        /* Làm sáng màu chữ trong dropdown */
        .search-select,
        .search-select option {
            color: #FFFFFF; /* Màu trắng sáng cho văn bản */
            background-color: #333333; /* Nền tối cho dropdown */
        }

        .search-select option:checked {
            background-color: #FFD700; /* Màu vàng nhạt cho mục được chọn */
            color: #000000; /* Màu đen để tương phản */
        }
    </style>
</head>
<body>
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
                    <a href="${pageContext.request.contextPath}/RevenueManagementServlet" class="nav-link active">
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
                    <h1><i class="fas fa-chart-line"></i> Quản lý Doanh thu</h1>
                    <p>Xem và quản lý doanh thu của cửa hàng</p>
                </div>
            </div>

            <form id="filterForm" method="GET" action="${pageContext.request.contextPath}/RevenueManagementServlet">
                <div class="search-section">
                    <div class="search-row">
                        <div class="search-group">
                            <label>Tìm kiếm theo ngày:</label>
                            <input type="date" id="searchDay" name="periodValue" value="${param.periodValue}" class="search-input" onchange="submitForm('day')">
                        </div>
                        <div class="search-group">
                            <label>Tìm kiếm theo tháng:</label>
                            <input type="month" id="searchMonthYear" name="periodValue" value="${param.periodValue}" class="search-input" onchange="submitForm('month')">
                        </div>
                        <div class="search-group">
                            <label>Tìm kiếm theo năm:</label>
                            <input type="number" id="searchYear" name="year" value="${param.year}" class="search-input" placeholder="Nhập năm" min="2000" max="2025" onchange="submitForm('year')">
                        </div>
                        <div class="search-group">
                            <label>Tìm kiếm theo chi nhánh:</label>
                            <select id="searchBranch" name="branchId" class="search-select" onchange="submitForm()">
                                <option value="">-- Chọn chi nhánh --</option>
                                <c:forEach var="branch" items="${branches}">
                                    <option value="${branch.id}" ${param.branchId == branch.id ? 'selected' : ''}>${branch.name} (${branch.city})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="search-group">
                            <button type="button" class="btn btn-secondary" onclick="resetFilters()">
                                <i class="fas fa-trash"></i>
                                Xóa
                            </button>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="periodType" name="periodType" value="${param.periodType}" />
            </form>
            <div class="stats-card">
                <div class="stats-icon">
                    <i class="fas fa-money-bill-wave"></i>
                </div>
                <div class="stats-info">
                    <h3 id="totalRevenue">
                        <c:set var="totalRevenue" value="0" />
                        <c:forEach var="entry" items="${groupedInvoices}">
                            <c:set var="totalRevenue" value="${totalRevenue + (entry.value.revenue != null ? entry.value.revenue : 0)}" />
                        </c:forEach>
                        <fmt:formatNumber value="${totalRevenue}" type="number" maxFractionDigits="0" /> VNĐ
                    </h3>
                    <p>Tổng Doanh thu</p>
                </div>
            </div>

            <div class="table-container">
                <div class="table-header">
                    <div>
                        <div class="table-title">Báo cáo Doanh thu</div>
                        <div class="table-info">
                            Hiển thị 
                            <c:choose>
                                <c:when test="${empty groupedInvoices}">
                                    0
                                </c:when>
                                <c:otherwise>
                                    ${fn:length(groupedInvoices)}
                                </c:otherwise>
                            </c:choose>
                            mục
                        </div>
                    </div>
                    <div class="header-actions">
                        <button type="button" class="btn btn-secondary" onclick="resetFilters()">
                            <i class="fas fa-sync-alt"></i>
                            Đặt lại
                        </button>
                    </div>
                </div>
                <table class="revenue-table">
                    <thead>
                        <tr>
                            <th id="periodColumn">${periodColumn != null ? periodColumn : 'Thời gian'}</th>
                            <th>Tổng Doanh thu</th>
                            <th>Số Lịch hẹn</th>
                            <th>Doanh thu Trung bình/Lịch hẹn</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty groupedInvoices or fn:length(groupedInvoices) == 0}">
                                <tr><td colspan="4" style="text-align: center; color: #ccc;">Không có dữ liệu doanh thu.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="entry" items="${groupedInvoices}">
                                    <tr>
                                        <td>${entry.key}</td>
                                        <td class="money">
                                            <fmt:formatNumber value="${entry.value.revenue != null ? entry.value.revenue : 0}" type="number" maxFractionDigits="0" /> VNĐ
                                        </td>
                                        <td>${entry.value.count != null ? entry.value.count : 0}</td>
                                        <td class="money">
                                            <c:choose>
                                                <c:when test="${entry.value.count != null and entry.value.count > 0}">
                                                    <fmt:formatNumber value="${entry.value.revenue != null ? entry.value.revenue / entry.value.count : 0}" type="number" maxFractionDigits="0" /> VNĐ
                                                </c:when>
                                                <c:otherwise>0 VNĐ</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            <script>
                function submitForm(changed) {
                    if (changed === 'day') {
                        document.getElementById('searchMonthYear').value = '';
                        document.getElementById('searchYear').value = '';
                        document.getElementById('periodType').value = 'day';
                    } else if (changed === 'month') {
                        document.getElementById('searchDay').value = '';
                        document.getElementById('searchYear').value = '';
                        document.getElementById('periodType').value = 'month';
                        // Tách năm và tháng từ input type="month"
                        var monthValue = document.getElementById('searchMonthYear').value; // yyyy-MM
                        if (monthValue) {
                            var parts = monthValue.split('-');
                            if (parts.length === 2) {
                                setOrUpdateHidden('year', parts[0]);
                                setOrUpdateHidden('month', parts[1]);
                            }
                        }
                    } else if (changed === 'year') {
                        document.getElementById('searchDay').value = '';
                        document.getElementById('searchMonthYear').value = '';
                        document.getElementById('periodType').value = 'year';
                    }
                    document.getElementById('filterForm').submit();
                }

                // Hàm phụ để tạo hoặc cập nhật input hidden
                function setOrUpdateHidden(name, value) {
                    var input = document.getElementById('hidden_' + name);
                    if (!input) {
                        input = document.createElement('input');
                        input.type = 'hidden';
                        input.id = 'hidden_' + name;
                        input.name = name;
                        document.getElementById('filterForm').appendChild(input);
                    }
                    input.value = value;
                }
                function resetFilters() {
                    document.getElementById('searchDay').value = '';
                    document.getElementById('searchMonthYear').value = '';
                    document.getElementById('searchYear').value = '';
                    document.getElementById('searchBranch').value = '';
                    document.getElementById('filterForm').submit();
                }
                window.onload = function () {
                    const today = new Date().toISOString().split('T')[0];
                    document.getElementById('searchDay').max = today;
                };
                function toggleSidebar() {
                    const sidebar = document.getElementById('sidebar');
                    sidebar.classList.toggle('active');
                }
            </script>
        </main>
    </div>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xem Lịch Nghỉ - Admin</title>
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

            .schedule-container {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 10px;
                padding: 15px;
                border: 1px solid rgba(218, 165, 32, 0.2);
                margin-bottom: 15px;
            }

            .table {
                background: rgba(255, 255, 255, 0.05);
                color: #fff;
            }

            .table th {
                background: rgba(218, 165, 32, 0.2);
                color: #DAA520;
            }

            .table td {
                color: #ccc;
                background-color: rgba(255, 255, 255, 0.05);
            }

            .search-container {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 10px;
                padding: 15px;
                border: 1px solid rgba(218, 165, 32, 0.2);
                margin-bottom: 15px;
                display: flex;
                justify-content: flex-start;
                align-items: center;
                gap: 20px;
            }

            .search-container .search-group {
                display: flex;
                align-items: center;
            }

            .search-container .search-group label {
                color: #DAA520;
                font-weight: 500;
                margin-right: 5px;
                min-width: 120px;
            }

            .search-container select {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                background: rgba(255, 255, 255, 0.1);
                color: #DAA520; /* Thay đổi màu chữ thành vàng đồng để nổi bật */
                width: 200px;
                appearance: none;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' fill='%23DAA520'%3e%3cpath d='M2 4l4 4 4-4H2z'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: right 10px center;
                background-size: 10px 10px;
            }

            .search-container select option {
                color: #DAA520; /* Đảm bảo màu chữ của các option cũng nổi bật */
                background: rgba(29, 29, 27, 0.9); /* Giữ nền tối để tương phản */
            }

            .search-container input[type="text"],
            .search-container input[type="date"],
            .search-container input[type="month"] {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                background: rgba(255, 255, 255, 0.1);
                color: #DAA520; /* Thay đổi màu chữ cho các ô input khác cũng thành vàng đồng */
                width: 200px;
            }

            .search-container .reset-btn {
                padding: 8px 16px;
                background-color: #DAA520;
                border: 1px solid #DAA520;
                border-radius: 20px;
                color: #1d1d1b;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-left: 10px;
                font-weight: 500;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            .search-container .reset-btn:hover {
                background-color: #B8860B;
                border-color: #B8860B;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
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
                    padding: 60px 15px 15px;
                }

                .header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }

                .search-container {
                    flex-direction: column;
                    gap: 15px;
                }

                .search-container input[type="text"],
                .search-container input[type="date"],
                .search-container input[type="month"],
                .search-container select {
                    width: 100%;
                }

                .search-container .reset-btn {
                    width: 100%;
                    margin-left: 0;
                    margin-top: 5px;
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
                            <i class="fas fa-sign-out-alt me-1"></i> Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <button class="mobile-menu-btn" onclick="toggleSidebar()" aria-label="Mở/đóng menu">
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

            <main class="main-content" aria-label="Nội dung chính">
                <div class="header">
                    <div>
                        <h1><i class="fas fa-calendar"></i> Lịch Nghỉ Nhân Viên</h1>
                    </div>
                </div>

                <div class="search-container">
                    <div class="search-group">
                        <label>Tìm kiếm theo tên:</label>
                        <input type="text" id="searchName" placeholder="Tên">
                    </div>
                    <div class="search-group">
                        <label>Tìm kiếm theo ngày tháng:</label>
                        <input type="date" id="searchDate" placeholder="Ngày nghỉ">
                    </div>
                    <div class="search-group">
                        <label>Tìm kiếm theo tháng:</label>
                        <input type="month" id="searchMonth" placeholder="Tháng">
                    </div>
                    <div class="search-group">
                        <label>Tìm kiếm theo chi nhánh:</label>
                        <select id="searchBranch">
                            <option value="">Tất cả chi nhánh</option>
                            <c:choose>
                                <c:when test="${not empty branches}">
                                    <c:forEach var="branch" items="${branches}">
                                        <option value="${branch.name}">${branch.name}</option>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <option value="N/A">Không có chi nhánh</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </div>
                    <button class="reset-btn" onclick="resetSearch()">Xóa</button>
                </div>

                <div class="schedule-container">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Staff ID</th>
                                <th>Tên Nhân Viên</th>
                                <th>Chi Nhánh</th>
                                <th>Ngày Nghỉ</th>
                                <th>Trạng Thái</th>
                            </tr>
                        </thead>
                        <tbody id="scheduleTableBody">
                            <c:choose>
                                <c:when test="${not empty schedules}">
                                    <c:forEach var="schedule" items="${schedules}">
                                        <tr data-id="${schedule.id}" data-staff-id="${schedule.staffId}" data-fullname="${schedule.firstName} ${schedule.lastName}" data-workdate="${schedule.workDate}" data-status="${schedule.status}" data-branch="${schedule.branch}">
                                            <td><c:out value="${schedule.id != null ? schedule.id : 0}" /></td>
                                            <td><c:out value="${schedule.staffId != null ? schedule.staffId : 0}" /></td>
                                            <td><c:out value="${schedule.firstName != null ? schedule.firstName : 'N/A'} ${schedule.lastName != null ? schedule.lastName : 'N/A'}" /></td>
                                            <td><c:out value="${schedule.branch != null ? schedule.branch : 'N/A'}" /></td>
                                            <td><c:out value="${schedule.workDate != null ? schedule.workDate : 'N/A'}" /></td>
                                            <td><c:out value="${schedule.status != null ? schedule.status : 'N/A'}" /></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" style="text-align: center; color: #ccc;">Không có dữ liệu lịch nghỉ.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>

        <script>
            // Biến global
            let allSchedules = [];
            let originalRows = [];
            let isInitialized = false;

            // Hàm toggle sidebar
            function toggleSidebar() {
                document.getElementById('sidebar').classList.toggle('active');
            }

            // Hàm khởi tạo dữ liệu từ DOM
            function initializeData() {
                const tbody = document.getElementById('scheduleTableBody');
                if (!tbody) {
                    console.error('Table body not found!');
                    return false;
                }

                // Lưu tất cả các row gốc
                originalRows = Array.from(tbody.querySelectorAll('tr'));
                allSchedules = [];

                originalRows.forEach((row) => {
                    // Kiểm tra nếu là row dữ liệu thực (có data attributes)
                    const id = row.getAttribute('data-id');
                    const staffId = row.getAttribute('data-staff-id');
                    const fullName = row.getAttribute('data-fullname');
                    const workDate = row.getAttribute('data-workdate');
                    const status = row.getAttribute('data-status');
                    const branch = row.getAttribute('data-branch');

                    if (id && staffId && fullName && fullName !== 'N/A N/A') {
                        allSchedules.push({
                            element: row,
                            id: id,
                            staffId: staffId,
                            fullName: fullName.trim(),
                            workDate: workDate || '',
                            status: status || '',
                            branch: branch || ''
                        });
                    }
                });

                console.log('Initialized', allSchedules.length, 'schedules from DOM');
                return allSchedules.length > 0;
            }

            // Hàm hiển thị kết quả
            function displayResults(schedules) {
                const tbody = document.getElementById('scheduleTableBody');
                if (!tbody) return;

                // Xóa tất cả row hiện tại
                tbody.innerHTML = '';

                if (!schedules || schedules.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="6" style="text-align: center; color: #ccc;">Không có dữ liệu phù hợp.</td></tr>';
                    return;
                }

                // Thêm các row phù hợp
                schedules.forEach(schedule => {
                    tbody.appendChild(schedule.element.cloneNode(true));
                });

                console.log('Displayed', schedules.length, 'results');
            }

            // Hàm lọc dữ liệu
            function filterSchedules() {
                if (!isInitialized) {
                    console.log('Data not initialized yet, initializing now...');
                    if (!initializeData()) {
                        console.error('Failed to initialize data');
                        return;
                    }
                }

                const nameInput = document.getElementById('searchName');
                const dateInput = document.getElementById('searchDate');
                const monthInput = document.getElementById('searchMonth');
                const branchSelect = document.getElementById('searchBranch');

                if (!nameInput || !dateInput || !monthInput || !branchSelect) {
                    console.error('Search inputs not found!');
                    return;
                }

                const searchName = nameInput.value.trim().toLowerCase();
                const searchDate = dateInput.value.trim();
                const searchMonth = monthInput.value.trim();
                const searchBranch = branchSelect.value.trim().toLowerCase();

                console.log('Filtering with:', { name: searchName, date: searchDate, month: searchMonth, branch: searchBranch });

                // Nếu không có điều kiện tìm kiếm, hiển thị tất cả
                if (!searchName && !searchDate && !searchMonth && !searchBranch) {
                    displayResults(allSchedules);
                    return;
                }

                // Lọc dữ liệu
                const filteredSchedules = allSchedules.filter(schedule => {
                    let matchName = true;
                    let matchDate = true;
                    let matchMonth = true;
                    let matchBranch = true;

                    // Kiểm tra tên
                    if (searchName) {
                        const fullNameLower = schedule.fullName.toLowerCase();
                        matchName = fullNameLower.includes(searchName);
                    }

                    // Kiểm tra ngày
                    if (searchDate) {
                        matchDate = schedule.workDate === searchDate;
                    }

                    // Kiểm tra tháng (định dạng YYYY-MM)
                    if (searchMonth) {
                        const workDate = new Date(schedule.workDate);
                        const monthYear = workDate.getFullYear() + '-' + String(workDate.getMonth() + 1).padStart(2, '0');
                        matchMonth = monthYear === searchMonth;
                    }

                    // Kiểm tra chi nhánh
                    if (searchBranch) {
                        matchBranch = schedule.branch.toLowerCase().includes(searchBranch);
                    }

                    return matchName && matchDate && matchMonth && matchBranch;
                });

                console.log('Found', filteredSchedules.length, 'matches');
                displayResults(filteredSchedules);
            }

            // Hàm reset tìm kiếm
            function resetSearch() {
                const nameInput = document.getElementById('searchName');
                const dateInput = document.getElementById('searchDate');
                const monthInput = document.getElementById('searchMonth');
                const branchSelect = document.getElementById('searchBranch');

                if (nameInput) nameInput.value = '';
                if (dateInput) dateInput.value = '';
                if (monthInput) monthInput.value = '';
                if (branchSelect) branchSelect.value = '';

                displayResults(allSchedules);
                console.log('Search reset');
            }

            // Hàm debounce
            function debounce(func, wait) {
                let timeout;
                return function executedFunction(...args) {
                    const later = () => {
                        clearTimeout(timeout);
                        func.apply(this, args);
                    };
                    clearTimeout(timeout);
                    timeout = setTimeout(later, wait);
                };
            }

            // Hàm thiết lập event listeners
            function setupEventListeners() {
                const nameInput = document.getElementById('searchName');
                const dateInput = document.getElementById('searchDate');
                const monthInput = document.getElementById('searchMonth');
                const branchSelect = document.getElementById('searchBranch');

                if (nameInput) {
                    const debouncedFilter = debounce(filterSchedules, 300);
                    nameInput.addEventListener('input', debouncedFilter);
                    nameInput.addEventListener('paste', debouncedFilter);
                    console.log('Name search listener added');
                }

                if (dateInput) {
                    dateInput.addEventListener('change', filterSchedules);
                    console.log('Date search listener added');
                }

                if (monthInput) {
                    monthInput.addEventListener('change', filterSchedules);
                    console.log('Month search listener added');
                }

                if (branchSelect) {
                    branchSelect.addEventListener('change', filterSchedules);
                    console.log('Branch select listener added');
                }
            }

            // Hàm khởi tạo chính
            function initialize() {
                console.log('=== INITIALIZING SCHEDULE SEARCH ===');

                // Kiểm tra các element cần thiết
                const tbody = document.getElementById('scheduleTableBody');
                const nameInput = document.getElementById('searchName');
                const dateInput = document.getElementById('searchDate');
                const monthInput = document.getElementById('searchMonth');
                const branchSelect = document.getElementById('searchBranch');

                if (!tbody || !nameInput || !dateInput || !monthInput || !branchSelect) {
                    console.log('Required elements not found, retrying...');
                    setTimeout(initialize, 200);
                    return;
                }

                try {
                    // Đảm bảo dữ liệu đã được tải từ server
                    if (tbody.querySelectorAll('tr').length === 1 && tbody.querySelector('td[colspan="6"]')) {
                        console.log('Table contains only default message, waiting for data...');
                        setTimeout(initialize, 200);
                        return;
                    }

                    // Khởi tạo dữ liệu
                    const hasData = initializeData();

                    if (hasData) {
                        console.log('✓ Data initialized successfully:', allSchedules.length, 'records');
                    } else {
                        console.log('⚠ No data found in DOM, relying on server-rendered table');
                    }

                    // Thiết lập event listeners
                    setupEventListeners();

                    // Đánh dấu đã khởi tạo
                    isInitialized = true;

                    console.log('✓ Schedule search fully initialized');

                } catch (error) {
                    console.error('✗ Error during initialization:', error);
                }
            }

            // Khởi tạo khi DOM sẵn sàng
            document.addEventListener('DOMContentLoaded', function () {
                console.log('DOM Content Loaded - Starting initialization...');
                setTimeout(initialize, 100); // Delay to ensure table is rendered
            });

            // Backup initialization
            window.addEventListener('load', function () {
                if (!isInitialized) {
                    console.log('Window loaded - Backup initialization...');
                    initialize();
                }
            });

            // Export functions for debugging
            window.resetSearch = resetSearch;
            window.filterSchedules = filterSchedules;
        </script>
    </body>
</html>
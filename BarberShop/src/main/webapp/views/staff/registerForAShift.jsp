<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng ký Lịch Làm Việc - Barbershop Staff</title>
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

            .header p {
                font-size: 1rem;
                color: #ccc;
                margin: 0;
            }

            .info-cards {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
            }

            .info-card {
                flex: 1;
                background: rgba(29, 29, 27, 0.9);
                border: 1px solid rgba(218, 165, 32, 0.2);
                border-radius: 10px;
                padding: 15px;
                text-align: center;
            }

            .info-card h3 {
                font-size: 1rem;
                color: #DAA520;
                margin-bottom: 10px;
            }

            .info-card .value {
                font-size: 1.5rem;
                font-weight: 600;
                color: #fff;
            }

            .info-card .description {
                font-size: 0.9rem;
                color: #ccc;
            }

            .schedule-container {
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 10px;
                padding: 15px;
                border: 1px solid rgba(218, 165, 32, 0.2);
                margin-bottom: 15px;
            }

            .month-selector {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .month-nav-btn {
                background: transparent;
                border: none;
                color: #DAA520;
                font-size: 1rem;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 5px;
                padding: 5px 10px;
                border-radius: 5px;
                transition: background 0.3s ease;
            }

            .month-nav-btn:hover {
                background: rgba(218, 165, 32, 0.1);
            }

            .current-month {
                font-size: 1.2rem;
                font-weight: 600;
                color: #fff;
            }

            .legend {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }

            .legend-item {
                display: flex;
                align-items: center;
                gap: 5px;
                font-size: 0.9rem;
                color: #ccc;
            }

            .legend-color {
                width: 20px;
                height: 20px;
                border-radius: 3px;
            }

            .calendar-grid {
                display: grid;
                grid-template-columns: repeat(7, 1fr);
                gap: 5px;
            }

            .calendar-header {
                text-align: center;
                font-weight: 600;
                color: #DAA520;
                padding: 10px 0;
                background: rgba(218, 165, 32, 0.1);
                border-radius: 5px;
            }

            .calendar-day {
                position: relative;
                padding: 15px;
                text-align: center;
                border: 1px solid rgba(218, 165, 32, 0.2);
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.3s ease;
                background: rgba(255, 255, 255, 0.05);
            }

            .calendar-day:hover:not(.disabled):not(.other-month):not(.full) {
                background: rgba(218, 165, 32, 0.1);
            }

            .calendar-day.disabled {
                background: rgba(244, 67, 54, 0.2);
                color: #F44336;
                cursor: not-allowed;
            }

            .calendar-day.other-month {
                color: #555;
                background: rgba(255, 255, 255, 0.02);
                cursor: default;
            }

            .calendar-day.full {
                background: rgba(255, 152, 0, 0.2);
                color: #FF9800;
                cursor: not-allowed;
            }

            .calendar-day.selected {
                background: linear-gradient(45deg, #DAA520, #B8860B);
                color: #1d1d1b;
                font-weight: 600;
                border-color: #DAA520;
            }

            .day-count {
                position: absolute;
                top: 5px;
                right: 5px;
                background: #F44336;
                color: #fff;
                font-size: 0.7rem;
                padding: 2px 6px;
                border-radius: 10px;
            }

            .action-buttons {
                display: flex;
                gap: 10px;
                justify-content: flex-end;
                margin-top: 20px;
            }

            .btn-primary {
                background-color: #DAA520;
                border-color: #DAA520;
                color: #1d1d1b;
                padding: 8px 16px;
                border-radius: 25px;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                background-color: #B8860B;
                border-color: #B8860B;
            }

            .btn-primary:disabled {
                background-color: #666;
                border-color: #666;
                cursor: not-allowed;
            }

            .btn-secondary {
                background-color: #666;
                border-color: #666;
                color: #fff;
                padding: 8px 16px;
                border-radius: 25px;
                transition: all 0.3s ease;
            }

            .btn-secondary:hover {
                background-color: #555;
                border-color: #555;
            }

            .toast {
                position: fixed;
                bottom: 20px;
                right: 20px;
                min-width: 200px;
                z-index: 1200;
                display: none;
            }

            .toast.show {
                display: block;
                animation: fadeIn 0.3s ease, fadeOut 0.3s ease 2.7s;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @keyframes fadeOut {
                from {
                    opacity: 1;
                    transform: translateY(0);
                }
                to {
                    opacity: 0;
                    transform: translateY(20px);
                }
            }

            .toast-body {
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 0.9rem;
            }

            .bg-success {
                background-color: #4CAF50;
            }
            .bg-danger {
                background-color: #F44336;
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

                .info-cards {
                    flex-direction: column;
                }

                .month-selector {
                    flex-direction: column;
                    gap: 10px;
                }

                .action-buttons {
                    flex-direction: column;
                }

                .action-buttons button {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg custom-navbar border-bottom shadow-sm">
            <div class="container-fluid px-4">
                <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/views/staff/dashboard.jsp">
                    <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Logo Barbershop" width="55" height="55" class="me-2">
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <div class="d-flex gap-2 align-items-center">
                        <div class="text-warning d-none d-lg-block me-3">
                            <i class="fas fa-user-tie me-1"></i>
                            <span class="me-3" style="color: #FF9900"> Nhân viên: <strong>${sessionScope.staff.lastName} ${sessionScope.staff.firstName}</strong></span>
                        </div>
                        <a class="btn btn-warning" href="${pageContext.request.contextPath}/logout" onclick="return confirm('Bạn có chắc chắn muốn đăng xuất?')" aria-label="Đăng xuất">
                            <i class="fas fa-sign-out-alt me-1"></i>
                            Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <button class="mobile-menu-btn" onclick="toggleSidebar()" aria-label="Mở/đóng menu">
            <i class="fas fa-bars"></i>
        </button>

        <div class="dashboard-layout">
            <nav class="sidebar" id="sidebar" aria-label="Menu điều hướng">
                <div class="sidebar-header">
                    <div class="logo"><i class="fas fa-cut"></i></div>
                    <div class="logo-text">BarberShop Pro</div>
                    <div class="logo-subtitle">Staff Dashboard</div>
                </div>
                <div class="nav-menu">
                    <div class="nav-item"><a href="${pageContext.request.contextPath}/views/staff/dashboard.jsp" class="nav-link" aria-label="Trang tổng quan"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></div>
                    <div class="nav-item"><a href="${pageContext.request.contextPath}/views/staff/registerForAShift.jsp" class="nav-link active" aria-label="Đăng ký lịch làm việc"><i class="fas fa-calendar-alt"></i><span>Đăng ký Lịch Làm</span></a></div>
                    <div class="nav-item"><a href="${pageContext.request.contextPath}/views/staff/appointments.jsp" class="nav-link" aria-label="Lịch hẹn của tôi"><i class="fas fa-clock"></i><span>Lịch Hẹn của Tôi</span></a></div>
                    <div class="nav-item"><a href="${pageContext.request.contextPath}/views/staff/profile.jsp" class="nav-link" aria-label="Thông tin cá nhân"><i class="fas fa-user"></i><span>Thông Tin Cá Nhân</span></a></div>
                </div>
            </nav>

            <main class="main-content" aria-label="Nội dung chính">
                <div class="header">
                    <div>
                        <h1><i class="fas fa-calendar-alt"></i> Đăng ký Lịch Làm Việc</h1>
                        <p>Chọn tối đa 4 ngày nghỉ trong tháng</p>
                    </div>
                </div>

                <div class="info-cards">
                    <div class="info-card">
                        <h3>Ngày Nghỉ Đã Chọn</h3>
                        <div class="value" id="selectedCount">0</div>
                        <div class="description">/ 4 ngày cho phép</div>
                    </div>
                    <div class="info-card">
                        <h3>Tháng Hiện Tại</h3>
                        <div class="value" id="currentMonthDisplay">--</div>
                        <div class="description">Đang đăng ký</div>
                    </div>
                    <div class="info-card">
                        <h3>Trạng Thái</h3>
                        <div class="value" id="statusDisplay">Chưa Hoàn Thành</div>
                        <div class="description">Lịch làm việc</div>
                    </div>
                </div>

                <div class="schedule-container">
                    <div class="month-selector">
                        <button class="month-nav-btn" onclick="previousMonth()" aria-label="Tháng trước"><i class="fas fa-chevron-left"></i> Tháng Trước</button>
                        <div class="current-month" id="monthYear"></div>
                        <button class="month-nav-btn" onclick="nextMonth()" aria-label="Tháng sau">Tháng Sau <i class="fas fa-chevron-right"></i></button>
                    </div>

                    <div class="legend" aria-label="Chú thích lịch">
                        <div class="legend-item"><div class="legend-color" style="background: rgba(255, 255, 255, 0.05);"></div><span>Ngày có thể chọn</span></div>
                        <div class="legend-item"><div class="legend-color" style="background: linear-gradient(45deg, #DAA520, #B8860B);"></div><span>Ngày nghỉ đã chọn</span></div>
                        <div class="legend-item"><div class="legend-color" style="background: rgba(255, 152, 0, 0.2);"></div><span>Đã đủ 2 người đăng ký</span></div>
                        <div class="legend-item"><div class="legend-color" style="background: rgba(244, 67, 54, 0.2);"></div><span>Không thể chọn</span></div>
                    </div>

                    <div class="calendar-grid" id="calendarGrid" role="grid" aria-label="Lịch tháng"></div>

                    <div class="action-buttons">
                        <button class="btn btn-secondary" onclick="clearSelection()" aria-label="Xóa tất cả lựa chọn"><i class="fas fa-undo"></i> Xóa Tất Cả</button>
                        <button class="btn btn-primary" id="saveBtn" onclick="saveSchedule()" disabled aria-label="Lưu lịch nghỉ"><i class="fas fa-save"></i> Lưu Lịch Nghỉ</button>
                    </div>
                </div>

                <div class="toast" id="toastNotification" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-body bg-dark text-white"><span id="toastMessage"></span></div>
                </div>
            </main>
        </div>

        <script>
            class ScheduleManager {
                constructor() {
                    this.currentDate = new Date();
                    this.selectedDays = [];
                    this.maxSelections = 4;
                    this.dayRegistrations = {};
                    this.disallowedDays = [];
                    this.registeredDays = {};
                    this.monthNames = ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'];
                    console.log("Staff ID from session: " + ${sessionScope.staff.accountId});
                    this.init();
                    this.loadRegistrations();
                    this.loadDisallowedDays();
                    this.loadRegisteredDays();
                }

                init() {
                    this.toggleSidebar();
                    this.updateCalendar();
                    this.updateStatus();
                }

                toggleSidebar() {
                    const sidebar = document.getElementById('sidebar');
                    if (sidebar)
                        sidebar.classList.toggle('active');
                }

                formatDateString(date) {
                    return date.toISOString().split('T')[0];
                }

                showToast(message, type = 'success') {
                    const toast = document.getElementById('toastNotification');
                    const toastBody = toast.querySelector('.toast-body');
                    toastBody.querySelector('#toastMessage').textContent = message;
                    toast.classList.add('show', type === 'success' ? 'bg-success' : 'bg-danger');
                    setTimeout(() => {
                        toast.classList.remove('show', 'bg-success', 'bg-danger');
                    }, 3000);
                }

                loadRegistrations() {
                    fetch('${pageContext.request.contextPath}/ViewScheduleServlet?action=getRegistrations')
                            .then(response => response.json())
                            .then(data => {
                                this.dayRegistrations = data.data || {};
                                this.updateCalendar();
                            })
                            .catch(error => console.error('Error loading registrations:', error));
                }

                loadDisallowedDays() {
                    fetch('${pageContext.request.contextPath}/ViewScheduleServlet?action=getDisallowedDays')
                            .then(response => response.json())
                            .then(data => {
                                this.disallowedDays = data.data || [];
                                this.updateCalendar();
                            })
                            .catch(error => console.error('Error loading disallowed days:', error));
                }

                loadRegisteredDays() {
                    const staffId = ${sessionScope.staff.accountId};
                    const year = this.currentDate.getFullYear();
                    const month = this.currentDate.getMonth() + 1;
                    fetch('${pageContext.request.contextPath}/ViewScheduleServlet?action=getRegisteredDays&staffId=' + staffId + '&year=' + year + '&month=' + month, {
                        method: 'GET',
                        headers: {'Content-Type': 'application/json'}
                    })
                            .then(response => response.json())
                            .then(data => {
                                this.registeredDays = data.data || {};
                                this.updateCalendar();
                            })
                            .catch(error => console.error('Error loading registered days:', error));
                }

                updateCalendar() {
                    const now = new Date();
                    const minDate = new Date(now);
                    minDate.setDate(minDate.getDate() + 3); // Giới hạn cách 3 ngày từ hiện tại
                    const maxDate = new Date(now);
                    maxDate.setMonth(maxDate.getMonth() + 2); // Giới hạn 2 tháng tới

                    if (this.currentDate < minDate || this.currentDate > maxDate) {
                        this.currentDate = new Date(now);
                        this.currentDate.setDate(minDate.getDate()); // Đặt ngày hiện tại + 3 ngày
                        this.showToast("Chỉ có thể chọn ngày từ " + minDate.toLocaleDateString('vi-VN') + " đến " + maxDate.toLocaleDateString('vi-VN') + ".", "danger");
                    }

                    const year = this.currentDate.getFullYear();
                    const month = this.currentDate.getMonth();
                    const calendarGrid = document.getElementById('calendarGrid');
                    calendarGrid.innerHTML = '';

                    document.getElementById('monthYear').textContent = this.monthNames[month] + ' ' + year;
                    document.getElementById('currentMonthDisplay').textContent = (month + 1) + '/' + year;

                    const dayHeaders = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];
                    dayHeaders.forEach(day => {
                        const header = document.createElement('div');
                        header.className = 'calendar-header';
                        header.textContent = day;
                        calendarGrid.appendChild(header);
                    });

                    const firstDay = new Date(year, month, 1);
                    const lastDay = new Date(year, month + 1, 0);
                    const startDate = new Date(firstDay);
                    startDate.setDate(startDate.getDate() - firstDay.getDay());

                    for (let i = 0; i < 42; i++) {
                        const day = new Date(startDate);
                        day.setDate(startDate.getDate() + i);

                        const dayElement = document.createElement('div');
                        dayElement.className = 'calendar-day';
                        dayElement.textContent = day.getDate();
                        dayElement.setAttribute('role', 'gridcell');
                        dayElement.setAttribute('aria-label', 'Ngày ' + day.getDate() + ' ' + this.monthNames[month] + ' ' + year);

                        const dateString = this.formatDateString(day);
                        const isCurrentMonth = day.getMonth() === month;
                        const isPastDay = day < minDate; // Kiểm tra cách 3 ngày
                        const isSunday = day.getDay() === 0;
                        const isDisallowed = this.disallowedDays.includes(dateString);
                        const registrationCount = this.dayRegistrations[dateString] || 0;
                        const isFull = registrationCount >= 2;
                        const isSelected = this.selectedDays.includes(dateString);
                        const isRegistered = this.registeredDays[dateString] || 0;

                        if (!isCurrentMonth) {
                            dayElement.classList.add('other-month');
                            dayElement.setAttribute('aria-disabled', 'true');
                        } else if (isPastDay) {
                            dayElement.classList.add('disabled');
                            dayElement.setAttribute('aria-disabled', 'true');
                            dayElement.title = "Ngày phải cách ít nhất 3 ngày từ hôm nay";
                        } else if (isSunday) {
                            dayElement.classList.add('disabled');
                            dayElement.setAttribute('aria-disabled', 'true');
                            dayElement.title = "Chủ nhật không thể chọn";
                        } else if (isDisallowed) {
                            dayElement.classList.add('disabled');
                            dayElement.setAttribute('aria-disabled', 'true');
                            dayElement.title = "Ngày lễ hoặc bị hạn chế";
                        } else if (isFull && !isSelected) {
                            dayElement.classList.add('full');
                            dayElement.setAttribute('aria-disabled', 'true');
                            dayElement.title = "Đã có tối đa 2 nhân viên đăng ký";
                            const countIndicator = document.createElement('div');
                            countIndicator.className = 'day-count';
                            countIndicator.textContent = registrationCount;
                            dayElement.appendChild(countIndicator);
                        } else if (this.selectedDays.length + Object.keys(this.registeredDays).length >= this.maxSelections && !isSelected) {
                            dayElement.classList.add('disabled');
                            dayElement.setAttribute('aria-disabled', 'true');
                            dayElement.title = "Đã đạt giới hạn 4 ngày nghỉ/tháng";
                        } else {
                            dayElement.tabIndex = 0;
                            dayElement.onclick = () => this.toggleDaySelection(dateString, dayElement);
                            dayElement.onkeydown = (e) => {
                                if (e.key === 'Enter' || e.key === ' ') {
                                    e.preventDefault();
                                    this.toggleDaySelection(dateString, dayElement);
                                }
                            };
                            if (registrationCount > 0) {
                                const countIndicator = document.createElement('div');
                                countIndicator.className = 'day-count';
                                countIndicator.textContent = registrationCount;
                                countIndicator.style.background = '#FF9800';
                                dayElement.appendChild(countIndicator);
                            }
                        }

                        if (isSelected) {
                            dayElement.classList.add('selected');
                            dayElement.setAttribute('aria-selected', 'true');
                        }

                        calendarGrid.appendChild(dayElement);
                    }
                }

                toggleDaySelection(dateString, element) {
                    const totalSelected = this.selectedDays.length + Object.keys(this.registeredDays).length;
                    if (this.selectedDays.includes(dateString)) {
                        this.selectedDays.splice(this.selectedDays.indexOf(dateString), 1);
                        element.classList.remove('selected');
                        element.setAttribute('aria-selected', 'false');
                        this.showToast('Đã bỏ chọn ngày ' + dateString);
                    } else if (totalSelected < this.maxSelections) {
                        this.selectedDays.push(dateString);
                        element.classList.add('selected');
                        element.setAttribute('aria-selected', 'true');
                        this.showToast('Đã chọn ngày ' + dateString);
                    } else {
                        this.showToast('Đã đạt giới hạn ' + this.maxSelections + ' ngày nghỉ/tháng!', 'danger');
                    }
                    this.updateStatus();
                }

                updateStatus() {
                    const selectedCount = document.getElementById('selectedCount');
                    const statusDisplay = document.getElementById('statusDisplay');
                    const saveBtn = document.getElementById('saveBtn');
                    selectedCount.textContent = this.selectedDays.length;
                    const totalRegistered = Object.keys(this.registeredDays).length;
                    if (this.selectedDays.length > 0) {
                        saveBtn.disabled = false;
                        statusDisplay.textContent = "Đang Hoàn Thành";
                    } else {
                        saveBtn.disabled = true;
                        statusDisplay.textContent = "Chưa Hoàn Thành";
                    }
                }

                previousMonth() {
                    this.currentDate.setMonth(this.currentDate.getMonth() - 1);
                    this.updateCalendar();
                }

                nextMonth() {
                    this.currentDate.setMonth(this.currentDate.getMonth() + 1);
                    this.updateCalendar();
                }

                clearSelection() {
                    this.selectedDays = [];
                    this.updateCalendar();
                    this.updateStatus();
                    this.showToast('Đã xóa tất cả lựa chọn');
                }

                saveSchedule() {
                    if (this.selectedDays.length === 0) {
                        this.showToast('Vui lòng chọn ít nhất 1 ngày nghỉ!', 'danger');
                        return;
                    }
                    const staffId = ${sessionScope.staff.id};
                    fetch('${pageContext.request.contextPath}/ScheduleServlet', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify({staffId: staffId, daysOff: this.selectedDays})
                    })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    const savedCount = this.selectedDays.length; // Số ngày đã chọn
                                    this.showToast(`Lịch nghỉ ${savedCount} ngày đã được lưu thành công!`, 'success');
                                    this.selectedDays = [];
                                    this.loadRegisteredDays();
                                    this.loadRegistrations();
                                    this.updateCalendar();
                                    this.updateStatus();
                                } else {
                                    this.showToast('Lỗi khi lưu lịch nghỉ: ' + data.message, 'danger');
                                }
                            })
                            .catch(error => this.showToast('Lỗi kết nối: ' + error, 'danger'));
                }
            }

            const scheduleManager = new ScheduleManager();
            window.toggleSidebar = () => scheduleManager.toggleSidebar();
            window.previousMonth = () => scheduleManager.previousMonth();
            window.nextMonth = () => scheduleManager.nextMonth();
            window.clearSelection = () => scheduleManager.clearSelection();
            window.saveSchedule = () => scheduleManager.saveSchedule();
        </script>

    </body>
</html>
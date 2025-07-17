<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Hẹn Của Nhân Viên - Barbershop Staff</title>
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
            margin: 0;
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

        .appointments-container {
            background: rgba(29, 29, 27, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            padding: 20px;
            border: 1px solid rgba(218, 165, 32, 0.2);
            margin-bottom: 15px;
        }

        .table {
            background: transparent;
            color: #fff;
            border-radius: 8px;
            overflow: hidden;
            border-collapse: separate;
            border-spacing: 0;
        }

        .table th {
            background: linear-gradient(45deg, #DAA520, #B8860B);
            color: #1d1d1b;
            font-weight: 600;
            border: none;
            padding: 15px 12px;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        .table th:first-child {
            border-top-left-radius: 8px;
        }

        .table th:last-child {
            border-top-right-radius: 8px;
        }

        .table td {
            border: 1px solid rgba(218, 165, 32, 0.2);
            padding: 12px;
            vertical-align: middle;
            background: rgba(255, 255, 255, 0.02);
        }

        .table tbody tr:hover {
            background: rgba(218, 165, 32, 0.1);
        }

        .table tbody tr:nth-child(even) td {
            background: rgba(255, 255, 255, 0.05);
        }

        .table tbody tr:hover td {
            background: rgba(218, 165, 32, 0.1);
        }

        .no-appointments {
            text-align: center;
            font-style: italic;
            color: #ccc;
            margin-top: 30px;
            padding: 40px 20px;
            border: 2px dashed rgba(218, 165, 32, 0.3);
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.02);
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
            display: inline-block;
            text-align: center;
            border: 1px solid transparent;
        }
        
        .status-confirmed { 
            background-color: rgba(76, 175, 80, 0.2); 
            color: #4CAF50; 
            border-color: #4CAF50; 
        }

        .status-ongoing { 
            background-color: rgba(255, 152, 0, 0.2); 
            color: #FF9800; 
            border-color: #FF9800; 
        }

        .avatar {
            min-width: 35px;
            min-height: 35px;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 14px;
        }

        .services-list {
            max-width: 200px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .btn-outline-primary {
            color: #DAA520;
            border-color: #DAA520;
            background: transparent;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            transition: all 0.3s ease;
        }

        .btn-outline-primary:hover {
            background-color: #DAA520;
            border-color: #DAA520;
            color: #1d1d1b;
        }

        .badge.bg-light {
            background-color: rgba(255, 255, 255, 0.1) !important;
            color: #DAA520 !important;
            border: 1px solid rgba(218, 165, 32, 0.3);
        }

        .text-success {
            color: #4CAF50 !important;
        }

        .text-primary {
            color: #DAA520 !important;
        }

        .text-secondary {
            color: #ccc !important;
        }

        .text-muted {
            color: #999 !important;
        }

        .modal-content {
            background: rgba(29, 29, 27, 0.95);
            border: 1px solid rgba(218, 165, 32, 0.3);
            color: #fff;
        }

        .modal-header {
            border-bottom: 1px solid rgba(218, 165, 32, 0.3);
        }

        .modal-footer {
            border-top: 1px solid rgba(218, 165, 32, 0.3);
        }

        .modal-title {
            color: #DAA520;
        }

        .btn-close {
            filter: invert(1);
        }

        .form-select {
            background-color: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(218, 165, 32, 0.3);
            color: #fff;
        }

        .form-select option {
            background-color: #1d1d1b;
            color: #fff;
        }

        .btn-primary {
            background-color: #DAA520;
            border-color: #DAA520;
            color: #1d1d1b;
            border-radius: 20px;
            padding: 8px 16px;
            font-weight: 500;
        }

        .btn-primary:hover {
            background-color: #B8860B;
            border-color: #B8860B;
        }

        .btn-secondary {
            background-color: #666;
            border-color: #666;
            color: #fff;
            border-radius: 20px;
            padding: 8px 16px;
        }

        .btn-secondary:hover {
            background-color: #555;
            border-color: #fff;
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

            .table-responsive {
                border-radius: 8px;
                overflow: hidden;
            }

            .header {
                flex-direction: column;
                text-align: center;
            }

            .appointments-container {
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
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

    <!-- Mobile Menu Button -->
    <button class="mobile-menu-btn" onclick="toggleSidebar()" aria-label="Mở/đóng menu">
        <i class="fas fa-bars"></i>
    </button>

    <div class="dashboard-layout">
        <!-- Sidebar -->
        <nav class="sidebar" id="sidebar" aria-label="Menu điều hướng">
            <div class="sidebar-header">
                <div class="logo"><i class="fas fa-cut"></i></div>
                <div class="logo-text">BarberShop Pro</div>
                <div class="logo-subtitle">Staff Dashboard</div>
            </div>
            <div class="nav-menu">
                <div class="nav-item"><a href="${pageContext.request.contextPath}/views/staff/registerForAShift.jsp" class="nav-link" aria-label="Đăng ký lịch làm việc"><i class="fas fa-calendar-alt"></i><span>Đăng ký Lịch Làm</span></a></div>
                <div class="nav-item"><a href="${pageContext.request.contextPath}/StaffAppointment" class="nav-link active" aria-label="Lịch hẹn của tôi"><i class="fas fa-clock"></i><span>Lịch Hẹn của Tôi</span></a></div>
                    <div class="nav-item"><a href="${pageContext.request.contextPath}/profile" class="nav-link" aria-label="Thông tin cá nhân"><i class="fas fa-user"></i><span>Thông Tin Cá Nhân</span></a></div>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="main-content" aria-label="Nội dung chính">
            <div class="header">
                <div>
                    <h1><i class="fas fa-clock"></i> Lịch Hẹn Của Nhân Viên</h1>
                    <p>Quản lý và cập nhật trạng thái lịch hẹn của bạn</p>
                </div>
            </div>

            <div class="appointments-container">
                <%-- Lấy danh sách cuộc hẹn từ request scope, đổi tên biến để khớp với Servlet --%>
                <c:set var="appointments" value="${requestScope.appointments}" />

                <c:if test="${empty appointments}">
                    <div class="no-appointments">
                        <i class="fas fa-calendar-times fa-3x mb-3" style="color: #DAA520;"></i>
                        <h4>Không có lịch hẹn nào</h4>
                        <p>Hiện tại không có cuộc hẹn nào được tìm thấy.</p>
                    </div>
                </c:if>

                <c:if test="${not empty appointments}">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Khách Hàng</th>
                                    <th>Thời Gian</th>
                                    <th>Dịch Vụ</th>
                                    <th>Tổng Tiền</th>
                                    <th>Trạng Thái</th>
                                    <th>Hành Động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%-- Cập nhật c:forEach để sử dụng biến 'appointments' --%>
                                <c:forEach var="appointment" items="${appointments}">
                                    <tr data-branch-id="${appointment.branchId}">
                                        <td ><span class="badge bg-light">#${appointment.id}</span></td>
                                        <td>
                                            <div style="color: white" class="d-flex align-items-center">
                                                <c:if test="${not empty appointment.customerName}">
                                                    <div class="avatar bg-primary text-white me-2">
                                                        ${appointment.customerName.substring(0,1).toUpperCase()}
                                                    </div>
                                                </c:if>
                                                <c:if test="${empty appointment.customerName}">
                                                    <div class="avatar bg-secondary text-white me-2">
                                                        ?
                                                    </div>
                                                </c:if>
                                                <strong>${appointment.customerName}</strong>
                                            </div>
                                        </td>
                                        <td>
                                            <c:if test="${appointment.appointmentTime != null}">
                                                <div style="color: white">
                                                    <i class="fas fa-calendar-day text-primary me-1"></i>
                                                    ${appointment.appointmentTime.dayOfMonth}/${appointment.appointmentTime.monthValue}/${appointment.appointmentTime.year}
                                                </div>
                                                <div style="color: white" class="text-muted small">
                                                    <i class="fas fa-clock text-secondary me-1"></i>
                                                    <c:set var="hour" value="${appointment.appointmentTime.hour < 10 ? '0' : ''}${appointment.appointmentTime.hour}"/>
                                                    <c:set var="minute" value="${appointment.appointmentTime.minute < 10 ? '0' : ''}${appointment.appointmentTime.minute}"/>
                                                    ${hour}:${minute}
                                                </div>
                                            </c:if>
                                            <c:if test="${appointment.appointmentTime == null}">
                                                <span class="text-muted">Không xác định</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <div  class="services-list" title="${appointment.services}">
                                                ${appointment.services}
                                            </div>
                                        </td>
                                        <td>
                                            <span class="text-success fw-bold">
                                                <c:choose>
                                                    <c:when test="${appointment.totalAmount != null}">
                                                        <c:choose>
                                                            <c:when test="${appointment.totalAmount >= 1000000}">
                                                                <fmt:formatNumber value="${appointment.totalAmount / 1000000}" pattern="#,##0"/>M ₫
                                                            </c:when>
                                                            <c:when test="${appointment.totalAmount >= 1000}">
                                                                <fmt:formatNumber value="${appointment.totalAmount / 1000}" pattern="#,##0"/>K ₫
                                                            </c:when>
                                                            <c:otherwise>
                                                                <fmt:formatNumber value="${appointment.totalAmount}" pattern="#,##0"/> ₫
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">N/A</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge status-badge
                                                <c:choose>
                                                    <c:when test="${appointment.status == 'Confirmed'}">status-confirmed</c:when>
                                                    <c:otherwise>status-ongoing</c:otherwise>
                                                </c:choose>">
                                                <c:choose>
                                                    <c:when test="${appointment.status == 'Confirmed'}">Đã xác nhận</c:when>
                                                    <c:otherwise>${appointment.status}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <%-- Thêm data attributes để truyền thông tin vào JavaScript --%>
                                            <button class="btn btn-sm btn-outline-primary edit-btn"
                                                    data-bs-toggle="modal" data-bs-target="#editAppointmentModal"
                                                    data-appointment-id="${appointment.id}"
                                                    data-current-status="${appointment.status}"
                                                    data-customer-name="${appointment.customerName}"
                                                    <%-- SỬ DỤNG PHƯƠNG THỨC MỚI ĐỂ ĐỊNH DẠNG java.util.Date --%>
                                                    <c:if test="${appointment.appointmentDateAsUtilDate != null}">
                                                        data-appointment-time="<fmt:formatDate value='${appointment.appointmentDateAsUtilDate}' pattern='HH:mm dd/MM/yyyy'/>"
                                                    </c:if>
                                                    <c:if test="${appointment.appointmentDateAsUtilDate == null}">
                                                        data-appointment-time="Không xác định"
                                                    </c:if>
                                                    data-services="${appointment.services}">
                                                <i class="fas fa-edit me-1"></i>Sửa
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </main>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="editAppointmentModal" tabindex="-1" aria-labelledby="editAppointmentModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editAppointmentModalLabel">Chỉnh Sửa Trạng Thái Lịch Hẹn</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="editAppointmentForm" action="StaffAppointment" method="post">
                    <div class="modal-body">
                        <input type="hidden" id="modalAppointmentId" name="appointmentId">
                        <p>Khách hàng: <strong id="modalCustomerName"></strong></p>
                        <p>Thời gian: <strong id="modalAppointmentTime"></strong></p>
                        <p>Dịch vụ: <strong id="modalServices"></strong></p>
                        <div class="mb-3">
                            <label for="statusSelect" class="form-label">Trạng thái mới:</label>
                            <select class="form-select" id="statusSelect" name="newStatus" required>
                                <option value="Confirmed">Đã xác nhận</option>
                                <option value="Completed">Hoàn thành</option>
                                <option value="Cancelled">Đã hủy</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // JavaScript để điền dữ liệu vào modal khi nút "Sửa" được click
        document.addEventListener('DOMContentLoaded', function () {
            var editAppointmentModal = document.getElementById('editAppointmentModal');
            editAppointmentModal.addEventListener('show.bs.modal', function (event) {
                // Button that triggered the modal
                var button = event.relatedTarget;
                // Extract info from data-bs-* attributes
                var appointmentId = button.getAttribute('data-appointment-id');
                var currentStatus = button.getAttribute('data-current-status');
                var customerName = button.getAttribute('data-customer-name');
                var appointmentTime = button.getAttribute('data-appointment-time');
                var services = button.getAttribute('data-services');

                // Update the modal's content.
                var modalAppointmentIdInput = editAppointmentModal.querySelector('#modalAppointmentId');
                var modalCustomerName = editAppointmentModal.querySelector('#modalCustomerName');
                var modalAppointmentTime = editAppointmentModal.querySelector('#modalAppointmentTime');
                var modalServices = editAppointmentModal.querySelector('#modalServices');
                var statusSelect = editAppointmentModal.querySelector('#statusSelect');

                modalAppointmentIdInput.value = appointmentId;
                modalCustomerName.textContent = customerName;
                modalAppointmentTime.textContent = appointmentTime;
                modalServices.textContent = services;

                // Set the current status as selected in the dropdown
                statusSelect.value = currentStatus;
            });
        });

        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }
    </script>
</body>
</html>
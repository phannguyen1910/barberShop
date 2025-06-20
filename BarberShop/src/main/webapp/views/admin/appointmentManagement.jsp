<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Lịch hẹn - Barbershop</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/material_blue.css"> 

    <style>
        /* Custom CSS provided by user */
        .appointment-card {
            transition: all 0.3s ease;
            border-left: 4px solid #007bff;
        }
        .appointment-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .status-badge {
            font-size: 0.85em;
            padding: 0.4em 0.8em;
            border-radius: 0.25rem; /* Ensure proper rounding */
            color: #fff; /* Default text color for badges */
        }
        .status-pending { background-color: #ffc107; color: #343a40; } /* Yellow - often needs dark text */
        .status-confirmed { background-color: #28a745; } /* Green */
        .status-completed { background-color: #17a2b8; } /* Cyan */
        .status-cancelled { background-color: #dc3545; } /* Red */
        .edit-btn {
            transition: all 0.3s ease;
        }
        .edit-btn:hover {
            transform: scale(1.1);
        }
        .modal-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .service-checkbox {
            margin: 0.5rem 0;
            padding: 0.5rem;
            border: 1px solid #dee2e6;
            border-radius: 0.375rem;
            transition: all 0.3s ease;
            display: flex; /* Use flex for alignment */
            align-items: center; /* Vertically align items */
        }
        .service-checkbox:hover {
            background-color: #f8f9fa;
        }
        .service-checkbox input:checked + label {
            color: #0d6efd;
            font-weight: 600;
        }
        /* Ensure checkbox and label are aligned */
        .service-checkbox .form-check-input {
            margin-right: 0.5rem; /* Space between checkbox and label */
        }
        .service-checkbox label {
            flex-grow: 1; /* Allow label to take available space */
            margin-bottom: 0; /* Remove default margin from label inside flex */
        }
        .table-responsive {
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .table th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: 600;
            border: none;
        }
        .search-box {
            border-radius: 2rem;
            border: 2px solid #e9ecef;
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
        }
        .search-box:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        /* Style for customer name display in add modal */
        #customerNameDisplay {
            margin-top: 5px;
            padding: 5px 8px;
            border-radius: 4px;
            min-height: 25px; /* Ensures space even when empty */
        }
        #customerNameDisplay.text-success {
            background-color: #d4edda; /* Light green background */
            color: #155724; /* Dark green text */
        }
        #customerNameDisplay.text-danger {
            background-color: #f8d7da; /* Light red background */
            color: #721c24; /* Dark red text */
        }

        /* New styles for time slots */
        #timeSlotsContainer {
            border: 1px solid #dee2e6;
            border-radius: 0.375rem;
            padding: 0.5rem;
            background-color: #f8f9fa;
            max-height: 250px; /* Limit height for scrollability */
            overflow-y: auto; /* Enable vertical scrolling */
            display: flex;
            flex-wrap: wrap;
            gap: 8px; /* Space between time slots */
        }
        .time-slot-btn {
            background-color: #e9ecef;
            color: #495057;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            padding: 8px 12px;
            font-size: 0.9em;
            cursor: pointer;
            transition: all 0.2s ease-in-out;
            flex-basis: calc(25% - 8px); /* 4 buttons per row, adjusting for gap */
            max-width: calc(25% - 8px);
            text-align: center;
        }
        .time-slot-btn:hover:not(.selected):not(.disabled) {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
        }
        .time-slot-btn.selected {
            background-color: #28a745; /* Green for selected */
            color: #fff;
            border-color: #28a745;
            font-weight: bold;
        }
        .time-slot-btn.disabled {
            background-color: #f1f1f1;
            color: #adb5bd;
            border-color: #e9ecef;
            cursor: not-allowed;
            opacity: 0.6;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container-fluid py-4">
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <h2 class="text-primary mb-0">
                        <i class="fas fa-calendar-alt me-2"></i>
                        Quản lý Lịch hẹn
                    </h2>
                    <div class="d-flex gap-2">
                        <button class="btn btn-success" onclick="openAddModal()">
                            <i class="fas fa-plus me-1"></i>Thêm lịch hẹn
                        </button>
                        <input type="text" id="searchInput" class="form-control search-box"
                               placeholder="Tìm kiếm theo tên khách hàng..." style="width: 300px;">
                        <button class="btn btn-outline-primary" onclick="refreshData()">
                            <i class="fas fa-sync-alt"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card bg-warning text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="card-title">Chờ xác nhận</h6>
                                <h3 id="pendingCount">0</h3>
                            </div>
                            <i class="fas fa-clock fa-2x opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-success text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="card-title">Đã xác nhận</h6>
                                <h3 id="confirmedCount">0</h3>
                            </div>
                            <i class="fas fa-check-circle fa-2x opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-info text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="card-title">Hoàn thành</h6>
                                <h3 id="completedCount">0</h3>
                            </div>
                            <i class="fas fa-check-double fa-2x opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-danger text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="card-title">Đã hủy</h6>
                                <h3 id="cancelledCount">0</h3>
                            </div>
                            <i class="fas fa-times-circle fa-2x opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card border-0">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0">Danh sách Lịch hẹn</h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0" id="appointmentsTable">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Khách hàng</th>
                                        <th>Thời gian</th>
                                        <th>Dịch vụ</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="appointment" items="${listAppointment}">
                                        <tr>
                                            <td><span class="badge bg-light text-dark">#${appointment.id}</span></td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2"
                                                         style="width: 35px; height: 35px; font-size: 14px;">
                                                         ${appointment.customerName.substring(0,1).toUpperCase()}
                                                    </div>
                                                    <strong>${appointment.customerName}</strong>
                                                </div>
                                            </td>
                                            <td>
                                                <div>
                                                    <i class="fas fa-calendar-day text-primary me-1"></i>
                                                    ${appointment.appointmentTime.dayOfMonth}/${appointment.appointmentTime.monthValue}/${appointment.appointmentTime.year}
                                                </div>
                                                <div class="text-muted small">
                                                    <i class="fas fa-clock text-secondary me-1"></i>
                                                    <c:set var="hour" value="${appointment.appointmentTime.hour < 10 ? '0' : ''}${appointment.appointmentTime.hour}"/>
                                                    <c:set var="minute" value="${appointment.appointmentTime.minute < 10 ? '0' : ''}${appointment.appointmentTime.minute}"/>
                                                    ${hour}:${minute}
                                                </div>
                                            </td>
                                            <td>
                                                <div class="services-list">
                                                    ${appointment.services}
                                                </div>
                                            </td>
                                            <td>
                                                <span class="text-success fw-bold">
                                                    <c:choose>
                                                        <c:when test="${appointment.totalAmount >= 1000000}">
                                                            ${String.format("%,.0f", appointment.totalAmount / 1000000)}M ₫
                                                        </c:when>
                                                        <c:when test="${appointment.totalAmount >= 1000}">
                                                            ${String.format("%,.0f", appointment.totalAmount / 1000)}K ₫
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${String.format("%,.0f", appointment.totalAmount)} ₫
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge status-badge
                                                    <c:choose>
                                                        <c:when test="${appointment.status == 'Pending'}">status-pending</c:when>
                                                        <c:when test="${appointment.status == 'Confirmed'}">status-confirmed</c:when>
                                                        <c:when test="${appointment.status == 'Completed'}">status-completed</c:when>
                                                        <c:when test="${appointment.status == 'Cancelled'}">status-cancelled</c:when>
                                                        <c:otherwise>bg-secondary</c:otherwise>
                                                    </c:choose>">
                                                    <c:choose>
                                                        <c:when test="${appointment.status == 'Pending'}">Chờ xác nhận</c:when>
                                                        <c:when test="${appointment.status == 'Confirmed'}">Đã xác nhận</c:when>
                                                        <c:when test="${appointment.status == 'Completed'}">Hoàn thành</c:when>
                                                        <c:when test="${appointment.status == 'Cancelled'}">Đã hủy</c:when>
                                                        <c:otherwise>${appointment.status}</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary edit-btn"
                                                        onclick="openEditModal(${appointment.id}, '${appointment.status}', '${appointment.services}', '${appointment.customerName}')">
                                                    <i class="fas fa-edit me-1"></i>Sửa
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header text-white">
                    <h5 class="modal-title" id="addModalLabel">
                        <i class="fas fa-plus me-2"></i>Thêm Lịch hẹn mới
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addForm">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="addCustomerPhone" class="form-label fw-bold">
                                    <i class="fas fa-phone me-1 text-primary"></i>Số điện thoại khách hàng *
                                </label>
                                <input type="text" class="form-control" id="addCustomerPhone" placeholder="Nhập số điện thoại khách hàng" required>
                                <input type="hidden" id="addCustomerId" name="customerId">
                                <small id="customerNameDisplay" class="form-text"></small>
                            </div>
                            <div class="col-md-6">
                                <label for="addStaffId" class="form-label fw-bold">
                                    <i class="fas fa-user-tie me-1 text-primary"></i>Nhân viên *
                                </label>
                                <select class="form-select" id="addStaffId" name="staffId" required>
                                    <option value="">Chọn nhân viên...</option>
                                    <c:forEach var="staff" items="${listStaff}">
                                        <option value="${staff.id}">${staff.lastName} ${staff.firstName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-8">
                                <label for="addAppointmentDate" class="form-label fw-bold">
                                    <i class="fas fa-calendar-alt me-1 text-primary"></i>Ngày hẹn *
                                </label>
                                <input type="text" class="form-control" id="addAppointmentDate" name="appointmentDate" placeholder="Chọn ngày" required readonly>
                            </div>
                            <div class="col-md-4">
                                <label for="addNumberOfPeople" class="form-label fw-bold">
                                    <i class="fas fa-users me-1 text-primary"></i>Số người
                                </label>
                                <input type="number" class="form-control" id="addNumberOfPeople" name="numberOfPeople"
                                       value="1" min="1" max="10" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-12">
                                <label class="form-label fw-bold">
                                    <i class="fas fa-clock me-1 text-primary"></i>Chọn giờ *
                                </label>
                                <div id="timeSlotsContainer">
                                    <span class="text-muted">Vui lòng chọn ngày để xem giờ khả dụng.</span>
                                </div>
                                <input type="hidden" id="addAppointmentTime" name="appointmentTime"> 
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">
                                <i class="fas fa-cut me-1 text-primary"></i>Dịch vụ *
                            </label>
                            <div id="addServicesList" class="border rounded p-3 bg-light">
                                <c:forEach var="service" items="${listService}">
                                    <div class="service-checkbox form-check">
                                        <input type="checkbox" class="form-check-input" id="addService${service.id}" name="addServiceIds" value="${service.id}">
                                        <label class="form-check-label" for="addService${service.id}">
                                            <c:choose>
                                                <c:when test="${service.name.contains('Cắt') || service.name.contains('cắt')}">
                                                    <i class="fas fa-cut me-1"></i>
                                                </c:when>
                                                <c:when test="${service.name.contains('Cạo') || service.name.contains('cạo')}">
                                                    <i class="fas fa-razor me-1"></i>
                                                </c:when>
                                                <c:when test="${service.name.contains('Nhuộm') || service.name.contains('nhuộm')}">
                                                    <i class="fas fa-palette me-1"></i>
                                                </c:when>
                                                <c:when test="${service.name.contains('Gội') || service.name.contains('gội')}">
                                                    <i class="fas fa-shower me-1"></i>
                                                </c:when>
                                                <c:when test="${service.name.contains('Massage') || service.name.contains('massage')}">
                                                    <i class="fas fa-hands me-1"></i>
                                                </c:when>
                                                <c:when test="${service.name.contains('Uốn') || service.name.contains('uốn')}">
                                                    <i class="fas fa-magic me-1"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-scissors me-1"></i>
                                                </c:otherwise>
                                            </c:choose>
                                            ${service.name}
                                            <c:if test="${service.price != null && service.price > 0}">
                                                <span class="text-muted small ms-auto">
                                                    - <c:choose>
                                                        <c:when test="${service.price >= 1000000}">
                                                            ${String.format("%,.0f", service.price / 1000000)}M ₫
                                                        </c:when>
                                                        <c:when test="${service.price >= 1000}">
                                                            ${String.format("%,.0f", service.price / 1000)}K ₫
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${String.format("%,.0f", service.price)} ₫
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </c:if>
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                            <small class="text-muted mt-2">* Vui lòng chọn ít nhất một dịch vụ</small>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>Hủy
                    </button>
                    <button type="button" class="btn btn-success" onclick="saveNewAppointment()">
                        <i class="fas fa-save me-1"></i>Thêm lịch hẹn
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header text-white">
                    <h5 class="modal-title" id="editModalLabel">
                        <i class="fas fa-edit me-2"></i>Chỉnh sửa Lịch hẹn
                    </h4>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="editForm">
                        <input type="hidden" id="appointmentId" name="appointmentId">

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">
                                    <i class="fas fa-user me-1 text-primary"></i>Khách hàng
                                </label>
                                <input type="text" class="form-control" id="customerName" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="status" class="form-label fw-bold">
                                    <i class="fas fa-flag me-1 text-primary"></i>Trạng thái
                                </label>
                                <select class="form-select" id="status" name="status">
                                    <option value="Pending">Chờ xác nhận</option>
                                    <option value="Confirmed">Đã xác nhận</option>
                                    <option value="Completed">Hoàn thành</option>
                                    <option value="Cancelled">Đã hủy</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">
                                <i class="fas fa-cut me-1 text-primary"></i>Dịch vụ
                            </label>
                            <div id="servicesList" class="border rounded p-3 bg-light">
                                <c:forEach var="service" items="${listService}">
                                    <div class="service-checkbox form-check">
                                        <input type="checkbox" class="form-check-input" id="service${service.id}" name="serviceIds" value="${service.id}">
                                        <label class="form-check-label" for="service${service.id}">
                                            <c:choose>
                                                <c:when test="${service.name.contains('Cắt') || service.name.contains('cắt')}">
                                                    <i class="fas fa-cut me-1"></i>
                                                </c:when>
                                                <c:when test="${service.name.contains('Cạo') || service.name.contains('cạo')}">
                                                    <i class="fas fa-razor me-1"></i>
                                                </c:when>
                                                <c:when test="${service.name.contains('Nhuộm') || service.name.contains('nhuộm')}">
                                                    <i class="fas fa-palette me-1"></i>
                                                </c:when>
                                                <c:when test="${service.name.contains('Gội') || service.name.contains('gội')}">
                                                    <i class="fas fa-shower me-1"></i>
                                                </c:when>
                                                <c:when test="${service.name.contains('Massage') || service.name.contains('massage')}">
                                                    <i class="fas fa-hands me-1"></i>
                                                </c:when>
                                                <c:when test="${service.name.contains('Uốn') || service.name.contains('uốn')}">
                                                    <i class="fas fa-magic me-1"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-scissors me-1"></i>
                                                </c:otherwise>
                                            </c:choose>
                                            ${service.name}
                                            <c:if test="${service.price != null && service.price > 0}">
                                                <span class="text-muted small ms-auto">
                                                    - <c:choose>
                                                        <c:when test="${service.price >= 1000000}">
                                                            ${String.format("%,.0f", service.price / 1000000)}M ₫
                                                        </c:when>
                                                        <c:when test="${service.price >= 1000}">
                                                            ${String.format("%,.0f", service.price / 1000)}K ₫
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${String.format("%,.0f", service.price)} ₫
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </c:if>
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>Hủy
                    </button>
                    <button type="button" class="btn btn-primary" onclick="saveChanges()">
                        <i class="fas fa-save me-1"></i>Lưu thay đổi
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div id="notificationToast" class="toast" role="alert">
            <div class="toast-header">
                <i class="fas fa-info-circle text-primary me-2"></i>
                <strong class="me-auto">Thông báo</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body" id="toastMessage">
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        // Store customer and staff data directly from JSP for client-side use
        const allCustomers = [
            <c:forEach var="customer" items="${listCustomer}" varStatus="loop">
                {
                    id: ${customer.id},
                    firstName: '${customer.firstName}',
                    lastName: '${customer.lastName}',
                    phoneNumber: '${customer.phoneNumber}' 
                }<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];

        const allStaff = [
            <c:forEach var="staff" items="${listStaff}" varStatus="loop">
                {
                    id: ${staff.id},
                    firstName: '${staff.firstName}',
                    lastName: '${staff.lastName}'
                }<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];

        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            updateStatistics();
            setupSearch();
            setupAddModalCustomerStaffLogic();
            initFlatpickrAndGenerateTimeSlots(); // New function call
        });

        // Update statistics (unchanged)
        function updateStatistics() {
            const rows = document.querySelectorAll('#appointmentsTable tbody tr');
            let pending = 0, confirmed = 0, completed = 0, cancelled = 0;

            rows.forEach(row => {
                const statusBadge = row.querySelector('.status-badge');
                if (statusBadge.classList.contains('status-pending')) pending++;
                else if (statusBadge.classList.contains('status-confirmed')) confirmed++;
                else if (statusBadge.classList.contains('status-completed')) completed++;
                else if (statusBadge.classList.contains('status-cancelled')) cancelled++;
            });

            document.getElementById('pendingCount').textContent = pending;
            document.getElementById('confirmedCount').textContent = confirmed;
            document.getElementById('completedCount').textContent = completed;
            document.getElementById('cancelledCount').textContent = cancelled;
        }

        // Setup search functionality for the main table (unchanged)
        function setupSearch() {
            const searchInput = document.getElementById('searchInput');
            searchInput.addEventListener('input', function() {
                const filter = this.value.toLowerCase();
                const rows = document.querySelectorAll('#appointmentsTable tbody tr');

                rows.forEach(row => {
                    const customerName = row.cells[1].textContent.toLowerCase();
                    row.style.display = customerName.includes(filter) ? '' : 'none';
                });
            });
        }

        // Logic for Customer Phone Lookup and Staff Dropdown in Add Modal (unchanged except for logs)
        function setupAddModalCustomerStaffLogic() {
            const customerPhoneInput = document.getElementById('addCustomerPhone');
            const customerNameDisplay = document.getElementById('customerNameDisplay');
            const addCustomerIdHidden = document.getElementById('addCustomerId');

            let timeout = null;

            customerPhoneInput.addEventListener('input', function() {
                clearTimeout(timeout);
                const phoneNumber = this.value.trim();

                if (phoneNumber.length === 0) {
                    customerNameDisplay.textContent = '';
                    customerNameDisplay.classList.remove('text-success', 'text-danger');
                    addCustomerIdHidden.value = '';
                    customerNameDisplay.style.backgroundColor = '';
                    customerNameDisplay.style.color = '';
                    customerNameDisplay.style.fontWeight = 'normal';
                    return;
                }

                timeout = setTimeout(() => { 
                    let foundCustomer = null;

                    for (let i = 0; i < allCustomers.length; i++) {
                        const currentCustomer = allCustomers[i];
                        const customerPhoneNumberInArray = currentCustomer.phoneNumber ? String(currentCustomer.phoneNumber).trim() : '';

                        if (customerPhoneNumberInArray === phoneNumber) {
                            foundCustomer = currentCustomer;
                            break;
                        }
                    }

                    if (foundCustomer) {
                        const displayFirstName = (foundCustomer.firstName || '').trim(); 
                        const displayLastName = (foundCustomer.lastName || '').trim();  

                        const fullNameToDisplay = "Khách hàng: " + displayLastName + " " + displayFirstName;
                        customerNameDisplay.textContent = fullNameToDisplay; 

                        customerNameDisplay.classList.remove('text-danger');
                        customerNameDisplay.classList.add('text-success');
                        customerNameDisplay.style.backgroundColor = '#d4edda';
                        customerNameDisplay.style.color = '#155724';
                        customerNameDisplay.style.fontWeight = 'bold';

                        addCustomerIdHidden.value = foundCustomer.id;
                    } else {
                        customerNameDisplay.textContent = 'Không tìm thấy khách hàng.';
                        customerNameDisplay.classList.remove('text-success');
                        customerNameDisplay.classList.add('text-danger');
                        
                        customerNameDisplay.style.backgroundColor = '#f8d7da';
                        customerNameDisplay.style.color = '#721c24';
                        customerNameDisplay.style.fontWeight = 'normal';

                        addCustomerIdHidden.value = '';
                    }
                }, 300);
            });
        }

        // --- NEW FUNCTIONS FOR APPOINTMENT TIME CONSTRAINTS ---
        let flatpickrInstance = null; // Store Flatpickr instance globally for destruction/re-initialization

        function generateTimeSlots(selectedDate) {
            const timeSlotsContainer = document.getElementById('timeSlotsContainer');
            const addAppointmentTimeHiddenInput = document.getElementById('addAppointmentTime');
            timeSlotsContainer.innerHTML = ''; // Clear previous slots
            addAppointmentTimeHiddenInput.value = ''; // Clear hidden time input

            if (!selectedDate) {
                timeSlotsContainer.innerHTML = '<span class="text-muted">Vui lòng chọn ngày để xem giờ khả dụng.</span>';
                return;
            }

            const now = new Date();
            const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
            const isSelectedDateToday = (selectedDate.toDateString() === today.toDateString());

            const startHour = 8;
            const startMinute = 30;
            const endHour = 20;
            const endMinute = 30;

            let currentSlotTime = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), selectedDate.getDate(), startHour, startMinute, 0, 0);
            const endTime = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), selectedDate.getDate(), endHour, endMinute, 0, 0);

            let slotsGenerated = 0;

            while (currentSlotTime.getTime() <= endTime.getTime()) {
                const slotText = currentSlotTime.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit', hour12: false });
                const slotValue = currentSlotTime.toISOString().slice(0, 16); // YYYY-MM-DDTHH:MM

                const button = document.createElement('button');
                button.type = 'button';
                button.classList.add('time-slot-btn');
                button.textContent = slotText;
                button.setAttribute('data-time', slotValue);

                // Disable past slots and slots outside operating hours
                const isPastSlot = isSelectedDateToday && (currentSlotTime.getTime() <= now.getTime());
                const isOutsideOperatingHours = (currentSlotTime.getHours() < startHour || (currentSlotTime.getHours() === startHour && currentSlotTime.getMinutes() < startMinute)) ||
                                                (currentSlotTime.getHours() > endHour || (currentSlotTime.getHours() === endHour && currentSlotTime.getMinutes() > endMinute));

                if (isPastSlot || isOutsideOperatingHours) {
                    button.classList.add('disabled');
                    button.disabled = true;
                } else {
                    button.addEventListener('click', function() {
                        document.querySelectorAll('.time-slot-btn').forEach(btn => btn.classList.remove('selected'));
                        this.classList.add('selected');
                        addAppointmentTimeHiddenInput.value = this.getAttribute('data-time');
                    });
                }
                timeSlotsContainer.appendChild(button);
                slotsGenerated++;

                // Move to next slot (30 minutes)
                currentSlotTime.setMinutes(currentSlotTime.getMinutes() + 30);
            }

            if (slotsGenerated === 0) {
                timeSlotsContainer.innerHTML = '<span class="text-muted">Không có giờ khả dụng cho ngày này.</span>';
            }
        }

        function initFlatpickrAndGenerateTimeSlots() {
            const addAppointmentDateInput = document.getElementById('addAppointmentDate');
            
            // Destroy previous Flatpickr instance if it exists
            if (flatpickrInstance) {
                flatpickrInstance.destroy();
            }

            flatpickrInstance = flatpickr(addAppointmentDateInput, {
                inline: false, // Set to true if you want the calendar always visible
                minDate: "today", // Disable past dates
                dateFormat: "Y-m-d", // Format for the date input
                altInput: true, // Display human-readable date
                altFormat: "d F, Y", // How the date is displayed to the user
                enableTime: false, // We handle time slots manually
                onChange: function(selectedDates, dateStr, instance) {
                    const selectedFlatpickrDate = selectedDates[0] || null; // Get the selected Date object
                    generateTimeSlots(selectedFlatpickrDate); // Regenerate time slots for the new date
                }
            });

            // Set initial date to today and generate slots when page loads or modal opens
            const now = new Date();
            const initialDateStr = now.getFullYear() + '-' + String(now.getMonth() + 1).padStart(2, '0') + '-' + String(now.getDate()).padStart(2, '0');
            
            flatpickrInstance.setDate(initialDateStr, true); // Set date without triggering onChange during init
            // Manually call generateTimeSlots as setDate(..., true) doesn't fire onChange
            generateTimeSlots(new Date(initialDateStr)); 
        }
        // --- END NEW FUNCTIONS FOR APPOINTMENT TIME CONSTRAINTS ---

    // Open add modal (MODIFIED to use initFlatpickrAndGenerateTimeSlots)
    function openAddModal() {
        document.getElementById('addForm').reset();
        document.getElementById('addNumberOfPeople').value = 1;

        // Reset customer phone lookup specific fields and styles
        document.getElementById('addCustomerPhone').value = '';
        document.getElementById('customerNameDisplay').textContent = '';
        document.getElementById('customerNameDisplay').classList.remove('text-success', 'text-danger');
        document.getElementById('customerNameDisplay').style.backgroundColor = '';
        document.getElementById('customerNameDisplay').style.color = '';
        document.getElementById('customerNameDisplay').style.fontWeight = 'normal';
        document.getElementById('addCustomerId').value = ''; 

        // Reset staff dropdown
        document.getElementById('addStaffId').value = ''; 

        const addCheckboxes = document.querySelectorAll('input[name="addServiceIds"]');
        addCheckboxes.forEach(cb => cb.checked = false);

        // Re-initialize Flatpickr and generate initial time slots for today
        initFlatpickrAndGenerateTimeSlots(); 
        
        // Clear any previous time slot selection
        document.querySelectorAll('.time-slot-btn').forEach(btn => btn.classList.remove('selected'));
        document.getElementById('addAppointmentTime').value = '';


        new bootstrap.Modal(document.getElementById('addModal')).show();
    }

    // Save new appointment (MODIFIED to use hidden input for full datetime)
    function saveNewAppointment() {
        const customerId = document.getElementById('addCustomerId').value;
        const staffId = document.getElementById('addStaffId').value;
        // Get the full datetime string from the hidden input, generated by time slot click
        const appointmentTime = document.getElementById('addAppointmentTime').value; 
        const numberOfPeople = document.getElementById('addNumberOfPeople').value;
        const checkedBoxes = document.querySelectorAll('input[name="addServiceIds"]:checked');

        // Validation
        if (!customerId || customerId === '') {
            showNotification('Vui lòng nhập và chọn khách hàng hợp lệ!', 'error');
            return;
        }

        if (!staffId || staffId === '') {
            showNotification('Vui lòng chọn nhân viên!', 'error');
            return;
        }

        if (!appointmentTime) { // Check if a time slot has been selected
            showNotification('Vui lòng chọn ngày và giờ hẹn cụ thể!', 'error');
            return;
        }
        
        // Additional validation: Ensure selected time is not in the past relative to CURRENT moment
        const selectedDateTime = new Date(appointmentTime);
        const now = new Date();
        // Allow selection up to current minute + 1 min buffer (to account for minor clock differences)
        if (selectedDateTime.getTime() < now.getTime() - 60000) { // 60000ms = 1 minute buffer
             showNotification('Thời gian hẹn đã chọn đã trôi qua. Vui lòng chọn thời gian trong tương lai.', 'error');
             return;
        }

        if (checkedBoxes.length === 0) {
            showNotification('Vui lòng chọn ít nhất một dịch vụ!', 'error');
            return;
        }

        const serviceIds = Array.from(checkedBoxes).map(cb => parseInt(cb.value));

        const data = {
            customerId: parseInt(customerId),
            staffId: parseInt(staffId),
            appointmentTime: appointmentTime,
            numberOfPeople: parseInt(numberOfPeople),
            serviceIds: serviceIds
        };

        const saveBtn = document.querySelector('#addModal .btn-success');
        const originalText = saveBtn.innerHTML;
        saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Đang thêm...';
        saveBtn.disabled = true;

        fetch('AddAppointmentServlet', { 
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (!response.ok) {
                return response.json().catch(() => {
                    throw new Error('Network response was not ok: ' + response.statusText + ' (Failed to parse JSON)');
                });
            }
            return response.json();
        })
        .then(data => {
            if (data.success) {
                showNotification('Thêm lịch hẹn thành công!', 'success');
                bootstrap.Modal.getInstance(document.getElementById('addModal')).hide();
                setTimeout(() => {
                    location.reload(); 
                }, 1500);
            } else {
                showNotification(data.message || 'Có lỗi xảy ra khi thêm lịch hẹn!', 'error');
            }
        })
        .catch(error => {
            console.error('Error adding appointment:', error);
            showNotification('Có lỗi xảy ra khi thêm lịch hẹn! Chi tiết: ' + error.message, 'error');
        })
        .finally(() => {
            saveBtn.innerHTML = originalText;
            saveBtn.disabled = false;
        });
    }

    // Open edit modal (unchanged)
    function openEditModal(appointmentId, status, services, customerName) {
        document.getElementById('appointmentId').value = appointmentId;
        document.getElementById('customerName').value = customerName;
        document.getElementById('status').value = status;

        const checkboxes = document.querySelectorAll('input[name="serviceIds"]');
        checkboxes.forEach(cb => cb.checked = false);

        const serviceNames = services.split(', ').map(s => s.trim()); 
        checkboxes.forEach(checkbox => {
            const label = checkbox.nextElementSibling;
            const labelServiceText = label.textContent.trim();
            const serviceNameMatch = labelServiceText.match(/^(.*?)(?:\s*-\s*\d+[MK]?\s*₫)?$/);
            const serviceName = serviceNameMatch ? serviceNameMatch[1].trim() : labelServiceText;

            if (serviceNames.includes(serviceName)) {
                checkbox.checked = true;
            }
        });

        new bootstrap.Modal(document.getElementById('editModal')).show();
    }

    // Save changes (for edit modal) (unchanged)
    function saveChanges() {
        const appointmentId = document.getElementById('appointmentId').value;
        const status = document.getElementById('status').value;
        const checkedBoxes = document.querySelectorAll('input[name="serviceIds"]:checked');

        if (checkedBoxes.length === 0) {
            showNotification('Vui lòng chọn ít nhất một dịch vụ!', 'error');
            return;
        }

        const serviceIds = Array.from(checkedBoxes).map(cb => parseInt(cb.value));

        const data = {
            id: parseInt(appointmentId),
            status: status,
            serviceIds: serviceIds
        };

        const saveBtn = document.querySelector('#editModal .btn-primary');
        const originalText = saveBtn.innerHTML;
        saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Đang lưu...';
        saveBtn.disabled = true;

        fetch('EditAppointmentServlet', { 
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (!response.ok) {
                return response.json().catch(() => {
                    throw new Error('Network response was not ok: ' + response.statusText + ' (Failed to parse JSON)');
                });
            }
            return response.json();
        })
        .then(data => {
            if (data.success) {
                showNotification('Cập nhật lịch hẹn thành công!', 'success');
                setTimeout(() => {
                    location.reload(); 
                }, 1500);
            } else {
                showNotification(data.message || 'Có lỗi xảy ra khi cập nhật!', 'error');
            }
        })
        .catch(error => {
            console.error('Error updating appointment:', error);
            showNotification('Có lỗi xảy ra khi cập nhật! Chi tiết: ' + error.message, 'error');
        })
        .finally(() => {
            saveBtn.innerHTML = originalText;
            saveBtn.disabled = false;
        });
    }

    // Show toast notification (unchanged)
    function showNotification(message, type = 'info') {
        const toast = document.getElementById('notificationToast');
        const toastMessage = document.getElementById('toastMessage');
        const toastIcon = toast.querySelector('.toast-header i');

        toastIcon.classList.remove('text-success', 'text-danger', 'text-primary');

        toastMessage.textContent = message;

        if (type === 'success') {
            toastIcon.className = 'fas fa-check-circle text-success me-2';
        } else if (type === 'error') {
            toastIcon.className = 'fas fa-exclamation-circle text-danger me-2';
        } else {
            toastIcon.className = 'fas fa-info-circle text-primary me-2';
        }

        new bootstrap.Toast(toast).show();
    }

    // Refresh data (unchanged)
    function refreshData() {
        location.reload();
    }
</script>
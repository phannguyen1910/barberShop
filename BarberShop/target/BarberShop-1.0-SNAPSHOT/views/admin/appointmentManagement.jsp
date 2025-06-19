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
    <style>
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
        }
        .status-pending { background-color: #ffc107; }
        .status-confirmed { background-color: #28a745; }
        .status-completed { background-color: #17a2b8; }
        .status-cancelled { background-color: #dc3545; }
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
        }
        .service-checkbox:hover {
            background-color: #f8f9fa;
        }
        .service-checkbox input:checked + label {
            color: #0d6efd;
            font-weight: 600;
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
    </style>
</head>
<body class="bg-light">
    <div class="container-fluid py-4">
        <!-- Header -->
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

        <!-- Statistics Cards -->
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

        <!-- Appointments Table -->
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
                                                            ${appointment.totalAmount / 1000000}M ₫
                                                        </c:when>
                                                        <c:when test="${appointment.totalAmount >= 1000}">
                                                            ${appointment.totalAmount / 1000}K ₫
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${appointment.totalAmount} ₫
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

    <!-- Add Modal -->
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
                                <label for="addCustomerId" class="form-label fw-bold">
                                    <i class="fas fa-user me-1 text-primary"></i>Khách hàng *
                                </label>
                                <select class="form-select" id="addCustomerId" name="customerId" required>
                                    <option value="">Chọn khách hàng...</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="addStaffId" class="form-label fw-bold">
                                    <i class="fas fa-user-tie me-1 text-primary"></i>Nhân viên *
                                </label>
                                <select class="form-select" id="addStaffId" name="staffId" required>
                                    <option value="">Chọn nhân viên...</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-8">
                                <label for="addAppointmentTime" class="form-label fw-bold">
                                    <i class="fas fa-calendar-alt me-1 text-primary"></i>Thời gian hẹn *
                                </label>
                                <input type="datetime-local" class="form-control" id="addAppointmentTime" name="appointmentTime" required>
                            </div>
                            <div class="col-md-4">
                                <label for="addNumberOfPeople" class="form-label fw-bold">
                                    <i class="fas fa-users me-1 text-primary"></i>Số người
                                </label>
                                <input type="number" class="form-control" id="addNumberOfPeople" name="numberOfPeople" 
                                       value="1" min="1" max="10" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">
                                <i class="fas fa-cut me-1 text-primary"></i>Dịch vụ *
                            </label>
                            <div id="addServicesList" class="border rounded p-3 bg-light">
                                <c:forEach var="service" items="${listService}">
                                    <div class="service-checkbox">
                                        <input type="checkbox" class="form-check-input" id="addService${service.id}" name="addServiceIds" value="${service.id}">
                                        <label class="form-check-label ms-2" for="addService${service.id}">
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
                                                <span class="text-muted small">
                                                    - <c:choose>
                                                        <c:when test="${service.price >= 1000000}">
                                                            ${service.price / 1000000}M ₫
                                                        </c:when>
                                                        <c:when test="${service.price >= 1000}">
                                                            ${service.price / 1000}K ₫
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${service.price} ₫
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </c:if>
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                            <small class="text-muted">* Vui lòng chọn ít nhất một dịch vụ</small>
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

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header text-white">
                    <h5 class="modal-title" id="editModalLabel">
                        <i class="fas fa-edit me-2"></i>Chỉnh sửa Lịch hẹn
                    </h5>
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
                                    <div class="service-checkbox">
                                        <input type="checkbox" class="form-check-input" id="service${service.id}" name="serviceIds" value="${service.id}">
                                        <label class="form-check-label ms-2" for="service${service.id}">
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
                                                <span class="text-muted small">
                                                    - <c:choose>
                                                        <c:when test="${service.price >= 1000000}">
                                                            ${service.price / 1000000}M ₫
                                                        </c:when>
                                                        <c:when test="${service.price >= 1000}">
                                                            ${service.price / 1000}K ₫
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${service.price} ₫
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

    <!-- Toast notification -->
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

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            updateStatistics();
            setupSearch();
        });

        // Update statistics
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

        // Setup search functionality
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

        // Open add modal
        function openAddModal() {
            // Set minimum datetime to current time
            const now = new Date();
            const minDateTime = now.toISOString().slice(0, 16);
            document.getElementById('addAppointmentTime').min = minDateTime;
            
            // Reset form
            document.getElementById('addForm').reset();
            document.getElementById('addNumberOfPeople').value = 1;
            
            // Clear all service checkboxes
            const addCheckboxes = document.querySelectorAll('input[name="addServiceIds"]');
            addCheckboxes.forEach(cb => cb.checked = false);
            
            // Load customers and staff data
            loadCustomersAndStaff();
            
            new bootstrap.Modal(document.getElementById('addModal')).show();
        }

        // Load customers and staff data
        function loadCustomersAndStaff() {
            fetch('AddAppointmentServlet', {
                method: 'GET'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Populate customers dropdown
                    const customerSelect = document.getElementById('addCustomerId');
                    customerSelect.innerHTML = '<option value="">Chọn khách hàng...</option>';
                    data.customers.forEach(customer => {
                        const option = document.createElement('option');
                        option.value = customer.id;
                        option.textContent = `${customer.name} - ${customer.phone}`;
                        customerSelect.appendChild(option);
                    });
                    
                    // Populate staff dropdown
                    const staffSelect = document.getElementById('addStaffId');
                    staffSelect.innerHTML = '<option value="">Chọn nhân viên...</option>';
                    data.staff.forEach(staff => {
                        const option = document.createElement('option');
                        option.value = staff.id;
                        option.textContent = staff.name;
                        staffSelect.appendChild(option);
                    });
                } else {
                    showNotification(data.message || 'Không thể tải dữ liệu!', 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showNotification('Có lỗi xảy ra khi tải dữ liệu!', 'error');
            });
        }

        // Save new appointment
        function saveNewAppointment() {
            const customerId = document.getElementById('addCustomerId').value;
            const staffId = document.getElementById('addStaffId').value;
            const appointmentTime = document.getElementById('addAppointmentTime').value;
            const numberOfPeople = document.getElementById('addNumberOfPeople').value;
            const checkedBoxes = document.querySelectorAll('input[name="addServiceIds"]:checked');
            
            // Validation
            if (!customerId) {
                showNotification('Vui lòng chọn khách hàng!', 'error');
                return;
            }
            
            if (!staffId) {
                showNotification('Vui lòng chọn nhân viên!', 'error');
                return;
            }
            
            if (!appointmentTime) {
                showNotification('Vui lòng chọn thời gian hẹn!', 'error');
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
            
            // Show loading
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
            .then(response => response.json())
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
                console.error('Error:', error);
                showNotification('Có lỗi xảy ra khi thêm lịch hẹn!', 'error');
            })
            .finally(() => {
                saveBtn.innerHTML = originalText;
                saveBtn.disabled = false;
            });
        }

        // Open edit modal
        function openEditModal(appointmentId, status, services, customerName) {
            document.getElementById('appointmentId').value = appointmentId;
            document.getElementById('customerName').value = customerName;
            document.getElementById('status').value = status;
            
            // Clear all checkboxes first
            const checkboxes = document.querySelectorAll('input[name="serviceIds"]');
            checkboxes.forEach(cb => cb.checked = false);
            
            // Check services based on current appointment
            const serviceNames = services.split(', ');
            checkboxes.forEach(checkbox => {
                const label = checkbox.nextElementSibling;
                const serviceName = label.textContent.split(' - ')[0].trim(); // Remove price part if exists
                
                // Check if this service name is in the appointment's services
                serviceNames.forEach(appointmentService => {
                    if (appointmentService.trim() === serviceName) {
                        checkbox.checked = true;
                    }
                });
            });
            
            new bootstrap.Modal(document.getElementById('editModal')).show();
        }

        // Save changes
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
            
            // Show loading
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
            .then(response => response.json())
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
                console.error('Error:', error);
                showNotification('Có lỗi xảy ra khi cập nhật!', 'error');
            })
            .finally(() => {
                saveBtn.innerHTML = originalText;
                saveBtn.disabled = false;
            });
        }

        // Show notification
        function showNotification(message, type = 'info') {
            const toast = document.getElementById('notificationToast');
            const toastMessage = document.getElementById('toastMessage');
            const toastIcon = toast.querySelector('.toast-header i');
            
            toastMessage.textContent = message;
            
            // Update icon and color based on type
            toastIcon.className = type === 'success' ? 'fas fa-check-circle text-success me-2' :
                                 type === 'error' ? 'fas fa-exclamation-circle text-danger me-2' :
                                 'fas fa-info-circle text-primary me-2';
            
            new bootstrap.Toast(toast).show();
        }

        // Refresh data
        function refreshData() {
            location.reload();
        }
    </script>
</body>
</html>
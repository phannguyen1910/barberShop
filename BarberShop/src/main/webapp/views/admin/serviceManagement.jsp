<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Dịch vụ - Barbershop Admin</title>
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

            .btn-danger {
                background: rgba(244, 67, 54, 0.2);
                color: #F44336;
                border: 1px solid rgba(244, 67, 54, 0.3);
                padding: 6px 12px;
                border-radius: 6px;
                font-size: 0.8rem;
            }

            .btn-danger:hover {
                background: rgba(244, 67, 54, 0.3);
                transform: translateY(-1px);
            }

            .btn-warning {
                background: rgba(255, 167, 38, 0.2);
                color: #FF6F00;
                border: 1px solid rgba(255, 167, 38, 0.3);
                padding: 6px 12px;
                border-radius: 6px;
                font-size: 0.8rem;
            }

            .btn-warning:hover {
                background: rgba(255, 167, 38, 0.3);
                transform: translateY(-1px);
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

            .service-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
                min-width: 600px;
            }

            .service-table th,
            .service-table td {
                padding: 15px 12px;
                text-align: left;
                border-bottom: 1px solid rgba(218, 165, 32, 0.1);
            }

            .service-table th {
                background: rgba(218, 165, 32, 0.1);
                color: #DAA520;
                font-weight: 600;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .service-table td {
                color: #fff;
                font-size: 0.9rem;
            }

            .service-table tbody tr {
                transition: all 0.3s ease;
            }

            .service-table tbody tr:hover {
                background: rgba(218, 165, 32, 0.05);
            }

            .money {
                color: #DAA520;
                font-weight: 600;
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

                .table-container {
                    padding: 15px;
                }

                .service-table {
                    font-size: 0.8rem;
                }

                .service-table th,
                .service-table td {
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
                        <h1><i class="fas fa-store"></i> Quản lý Dịch vụ</h1>
                        <p>Quản lý các dịch vụ của salon</p>
                    </div>
                    <div class="header-actions">
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addServiceModal">
                            <i class="fas fa-plus"></i>
                            Thêm Dịch vụ
                        </button>
                    </div>
                </div>

                <div class="table-container">
                    <div class="table-header">
                        <div>
                            <div class="table-title">Danh sách Dịch vụ</div>
                            <div class="table-info" id="tableInfo">Hiển thị 0 dịch vụ</div>
                        </div>
                    </div>
                    <table class="service-table">
                        <thead>
                            <tr>
                                <th>Tên Dịch vụ</th>
                                <th>Giá</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody id="serviceTableBody"></tbody>
                    </table>
                </div>
            </main>
        </div>

        <!-- Add Service Modal -->
        <div class="modal fade" id="addServiceModal" tabindex="-1" aria-labelledby="addServiceModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addServiceModalLabel">Thêm Dịch vụ Mới</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Tên Dịch vụ</label>
                            <input type="text" id="serviceNameAdd" class="form-control" placeholder="Nhập tên dịch vụ">
                        </div>
                        <div class="form-group">
                            <label>Giá (VNĐ)</label>
                            <input type="number" id="servicePriceAdd" class="form-control" placeholder="Nhập giá dịch vụ" min="0">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary" onclick="addService()">Thêm Dịch vụ</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Service Modal -->
        <div class="modal fade" id="editServiceModal" tabindex="-1" aria-labelledby="editServiceModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editServiceModalLabel">Sửa Dịch vụ</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="editServiceId">
                        <div class="form-group">
                            <label>Tên Dịch vụ</label>
                            <input type="text" id="serviceNameEdit" class="form-control" placeholder="Nhập tên dịch vụ">
                        </div>
                        <div class="form-group">
                            <label>Giá (VNĐ)</label>
                            <input type="number" id="servicePriceEdit" class="form-control" placeholder="Nhập giá dịch vụ" min="0">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary" onclick="saveEdit()">Lưu Thay đổi</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Sample service data with reasonable prices
            let services = [
                { id: "SRV001", name: "Cắt tóc thương gia", price: 200000 },
                { id: "SRV002", name: "Combo1", price: 300000 },
                { id: "SRV003", name: "Combo2", price: 350000 },
                { id: "SRV004", name: "Combo3", price: 400000 },
                { id: "SRV005", name: "Combo4", price: 450000 },
                { id: "SRV006", name: "Uốn cơ bản", price: 500000 },
                { id: "SRV007", name: "Uốn cao cấp", price: 800000 },
                { id: "SRV008", name: "Nhuộm cơ bản", price: 600000 },
                { id: "SRV009", name: "Nhuộm cao cấp", price: 1000000 },
                { id: "SRV010", name: "Lấy ráy tai", price: 100000 },
                { id: "SRV011", name: "Gội đầu thư giãn cơ bản", price: 150000 },
                { id: "SRV012", name: "Gội đầu thư giãn cao cấp", price: 250000 }
            ];

            // Initialize page
            document.addEventListener('DOMContentLoaded', function() {
                renderServices();
            });

            // Toggle sidebar for mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                if (sidebar) {
                    sidebar.classList.toggle('active');
                }
            }

            // Render services
            function renderServices() {
                const tableBody = document.getElementById('serviceTableBody');
                if (!tableBody) return;

                tableBody.innerHTML = '';

                services.forEach(service => {
                    const row = document.createElement('tr');

                    // Service Name
                    const nameCell = document.createElement('td');
                    nameCell.textContent = service.name || 'N/A';
                    row.appendChild(nameCell);

                    // Price
                    const priceCell = document.createElement('td');
                    priceCell.className = 'money';
                    priceCell.textContent = (service.price || 0).toLocaleString('vi-VN') + ' VNĐ';
                    row.appendChild(priceCell);

                    // Actions
                    const actionsCell = document.createElement('td');
                    const editBtn = document.createElement('button');
                    editBtn.className = 'btn btn-warning me-2';
                    editBtn.innerHTML = '<i class="fas fa-edit"></i> Sửa';
                    editBtn.onclick = function() { showEditModal(service); };
                    const deleteBtn = document.createElement('button');
                    deleteBtn.className = 'btn btn-danger';
                    deleteBtn.innerHTML = '<i class="fas fa-trash-alt"></i> Xóa';
                    deleteBtn.onclick = function() { deleteService(service.id); };
                    actionsCell.appendChild(editBtn);
                    actionsCell.appendChild(deleteBtn);
                    row.appendChild(actionsCell);

                    tableBody.appendChild(row);
                });

                const tableInfo = document.getElementById('tableInfo');
                if (tableInfo) {
                    tableInfo.textContent = 'Hiển thị ' + services.length + ' dịch vụ';
                }
            }

            // Add new service
            function addService() {
                const serviceName = document.getElementById('serviceNameAdd').value.trim();
                const servicePrice = parseInt(document.getElementById('servicePriceAdd').value);

                if (!serviceName || isNaN(servicePrice) || servicePrice < 0) {
                    alert('Vui lòng nhập đầy đủ và hợp lệ thông tin dịch vụ!');
                    return;
                }

                // Check for duplicate service names
                if (services.some(service => service.name.toLowerCase() === serviceName.toLowerCase())) {
                    alert('Dịch vụ này đã tồn tại! Vui lòng nhập tên dịch vụ khác.');
                    return;
                }

                const newService = {
                    id: 'SRV' + (services.length + 1).toString().padStart(3, '0'),
                    name: serviceName,
                    price: servicePrice
                };

                services.push(newService);
                renderServices();
                resetAddModal();

                if (typeof bootstrap !== 'undefined') {
                    const modal = bootstrap.Modal.getInstance(document.getElementById('addServiceModal'));
                    modal.hide();
                } else {
                    document.getElementById('addServiceModal').classList.remove('show');
                    document.body.classList.remove('modal-open');
                    document.querySelector('.modal-backdrop').remove();
                }
            }

            // Reset add modal
            function resetAddModal() {
                document.getElementById('serviceNameAdd').value = '';
                document.getElementById('servicePriceAdd').value = '';
            }

            // Delete service
            function deleteService(id) {
                if (confirm('Bạn có chắc chắn muốn xóa dịch vụ này?')) {
                    services = services.filter(service => service.id !== id);
                    renderServices();
                }
            }

            // Show edit modal
            function showEditModal(service) {
                document.getElementById('editServiceId').value = service.id;
                document.getElementById('serviceNameEdit').value = service.name;
                document.getElementById('servicePriceEdit').value = service.price;

                if (typeof bootstrap !== 'undefined') {
                    const modal = new bootstrap.Modal(document.getElementById('editServiceModal'));
                    modal.show();
                } else {
                    document.getElementById('editServiceModal').classList.add('show');
                    document.body.classList.add('modal-open');
                    const backdrop = document.createElement('div');
                    backdrop.classList.add('modal-backdrop', 'fade', 'show');
                    document.body.appendChild(backdrop);
                }
            }

            // Save edited service
            function saveEdit() {
                const serviceId = document.getElementById('editServiceId').value;
                const serviceName = document.getElementById('serviceNameEdit').value.trim();
                const servicePrice = parseInt(document.getElementById('servicePriceEdit').value);

                if (!serviceName || isNaN(servicePrice) || servicePrice < 0) {
                    alert('Vui lòng nhập đầy đủ và hợp lệ thông tin dịch vụ!');
                    return;
                }

                // Check for duplicate service names (excluding the current service)
                const existingService = services.find(service => service.id === serviceId);
                if (services.some(service => service.name.toLowerCase() === serviceName.toLowerCase() && service.id !== serviceId)) {
                    alert('Tên dịch vụ này đã tồn tại! Vui lòng nhập tên khác.');
                    return;
                }

                // Update the service
                existingService.name = serviceName;
                existingService.price = servicePrice;
                renderServices();

                if (typeof bootstrap !== 'undefined') {
                    const modal = bootstrap.Modal.getInstance(document.getElementById('editServiceModal'));
                    modal.hide();
                } else {
                    document.getElementById('editServiceModal').classList.remove('show');
                    document.body.classList.remove('modal-open');
                    document.querySelector('.modal-backdrop').remove();
                }
            }
        </script>
    </body>
</html>
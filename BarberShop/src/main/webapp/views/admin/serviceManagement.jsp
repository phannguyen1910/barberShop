<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <!-- Thêm taglib fn -->
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/ViewServices.css"> 
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

<c:if test="${not empty param.success}">
    <div class="alert alert-success">${param.success}</div>
</c:if>

<button class="mobile-menu-btn" onclick="toggleSidebar()">
    <i class="fas fa-bars"></i>
</button>

<div class="dashboard-layout">
    <nav class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="logo"><i class="fas fa-cut"></i></div>
            <div class="logo-text">BarberShop Pro</div>
            <div class="logo-subtitle">Admin Dashboard</div>
        </div>
        <div class="nav-menu">
            <div class="nav-item"><a href="${pageContext.request.contextPath}/views/admin/dashboard.jsp" class="nav-link"><i class="fas fa-tachometer-alt"></i> Dashboard</a></div>
            <div class="nav-item"><a href="${pageContext.request.contextPath}/admin/view-customers" class="nav-link"><i class="fas fa-users"></i> Quản lý Khách hàng</a></div>
            <div class="nav-item"><a href="${pageContext.request.contextPath}/admin/view-staff" class="nav-link"><i class="fas fa-user-tie"></i> Quản lý Nhân viên</a></div>
            <div class="nav-item"><a href="${pageContext.request.contextPath}/views/admin/appointmentManagement.jsp" class="nav-link"><i class="fas fa-calendar-check"></i> Quản lý Lịch hẹn</a></div>
            <div class="nav-item"><a href="${pageContext.request.contextPath}/views/admin/feedbackManagement.jsp" class="nav-link"><i class="fas fa-comments"></i> Quản lý Phản hồi</a></div>
            <div class="nav-item"><a href="${pageContext.request.contextPath}/ViewServicesServlet" class="nav-link active"><i class="fas fa-store"></i> Quản lý Dịch vụ</a></div>
            <div class="nav-item"><a href="${pageContext.request.contextPath}/views/admin/voucherManagement.jsp" class="nav-link"><i class="fas fa-ticket-alt"></i> Quản lý Voucher</a></div>
            <div class="nav-item"><a href="${pageContext.request.contextPath}/views/admin/franchiseManagement.jsp" class="nav-link"><i class="fas fa-handshake"></i> Quản lý Nhượng quyền</a></div>
            <div class="nav-item"><a href="${pageContext.request.contextPath}/views/admin/revenueManagement.jsp" class="nav-link"><i class="fas fa-chart-line"></i> Quản lý Doanh thu</a></div>
            <div class="nav-item"><a href="${pageContext.request.contextPath}/ViewScheduleServlet" class="nav-link"><i class="fas fa-calendar"></i> Lịch làm nhân viên</a></div>
            <div class="nav-item"><a href="${pageContext.request.contextPath}/views/admin/Holiday.jsp" class="nav-link"><i class="fas fa-calendar"></i> Quản lý ngày nghỉ</a></div>
        </div>
    </nav>

    <main class="main-content">
        <div class="header">
            <div><h1><i class="fas fa-store"></i> Quản lý Dịch vụ</h1><p>Quản lý các dịch vụ của salon</p></div>
            <div class="header-actions">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addServiceModal">
                    <i class="fas fa-plus"></i> Thêm Dịch vụ
                </button>
            </div>
        </div>

        <div class="table-container">
            <div class="table-header">
                <div>
                    <div class="table-title">Danh sách Dịch vụ</div>
                    <div class="table-info">Hiển thị ${services != null ? services.size() : 0} dịch vụ</div>
                </div>
            </div>
            <table class="service-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Dịch vụ</th>
                        <th>Giá</th>
                        <th>Thời gian (phút)</th>
                        <th>Mô tả</th>
                        <th>Hình ảnh</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="service" items="${services}" varStatus="loop">
                        <tr>
                            <td>${service.id}</td>
                            <td>${service.name}</td>
                            <td class="money"><fmt:formatNumber value="${service.price}" type="currency" currencySymbol="VNĐ"/></td>
                            <td>${service.duration}</td>
                            <td>${service.description}</td>
                            <td>
                                <c:if test="${not empty service.image}">
                                    <c:set var="firstImage" value="${fn:split(service.image, ',')[0]}"/>
                                    <img src="${pageContext.request.contextPath}/images/${firstImage}" alt="${service.name}" width="50" height="50"/>
                                </c:if>
                            </td>
                            <td>
                                <button class="btn btn-warning me-2" data-bs-toggle="modal" data-bs-target="#editServiceModal"
                                        onclick="showEditModal('${service.id}', '${service.name}', ${service.price}, ${service.duration}, '${service.description}')">
                                    <i class="fas fa-edit"></i> Sửa
                                </button>
                                <a href="${pageContext.request.contextPath}/DeleteService?id=${service.id}" class="btn btn-danger"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa dịch vụ này?')">
                                    <i class="fas fa-trash-alt"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
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
            <form id="addServiceForm" action="${pageContext.request.contextPath}/AddServiceServlet" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="form-group"><label>Tên Dịch vụ</label><input type="text" id="serviceNameAdd" name="serviceName" class="form-control" placeholder="Nhập tên dịch vụ" required></div>
                    <div class="form-group"><label>Giá (VNĐ)</label><input type="number" id="servicePriceAdd" name="servicePrice" class="form-control" placeholder="Nhập giá dịch vụ" min="0" required></div>
                    <div class="form-group"><label>Thời gian (phút)</label><input type="number" id="serviceDurationAdd" name="serviceDuration" class="form-control" placeholder="Nhập thời gian thực hiện" min="0" required></div>
                    <div class="form-group"><label>Mô tả</label><textarea id="serviceDescriptionAdd" name="serviceDescription" class="form-control" placeholder="Nhập mô tả dịch vụ"></textarea></div>
                    <div class="form-group"><label>Hình ảnh</label><input type="file" id="serviceImageAdd" name="serviceImage" class="form-control" accept="image/*"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Thêm Dịch vụ</button>
                </div>
            </form>
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
            <form id="editServiceForm" action="${pageContext.request.contextPath}/UpdateService" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <input type="hidden" id="editServiceId" name="serviceId">
                    <div class="form-group"><label>Tên Dịch vụ</label><input type="text" id="serviceNameEdit" name="serviceName" class="form-control" required></div>
                    <div class="form-group"><label>Giá (VNĐ)</label><input type="number" id="servicePriceEdit" name="servicePrice" class="form-control" min="0" required></div>
                    <div class="form-group"><label>Thời gian (phút)</label><input type="number" id="serviceDurationEdit" name="serviceDuration" class="form-control" min="0" required></div>
                    <div class="form-group"><label>Mô tả</label><textarea id="serviceDescriptionEdit" name="serviceDescription" class="form-control"></textarea></div>
                    <div class="form-group"><label>Hình ảnh</label><input type="file" id="serviceImageEdit" name="serviceImage" class="form-control" accept="image/*"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu Thay đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        if (sidebar) sidebar.classList.toggle('active');
    }

    function showEditModal(id, name, price, duration, description) {
        document.getElementById('editServiceId').value = id;
        document.getElementById('serviceNameEdit').value = name;
        document.getElementById('servicePriceEdit').value = price;
        document.getElementById('serviceDurationEdit').value = duration;
        document.getElementById('serviceDescriptionEdit').value = description || '';
        new bootstrap.Modal(document.getElementById('editServiceModal')).show();
    }
</script>
</body>
</html>
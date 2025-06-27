<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Lịch hẹn - Barbershop</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/material_blue.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        /* Global styles - Consistent with dashboard.jsp */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif; /* Adjusted to Inter for body text */
            background: linear-gradient(rgba(29, 29, 27, 0.7), rgba(29, 29, 27, 0.7)),
                url('https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1374&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            color: #e0e0e0; /* Default text color for main content */
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
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3); /* Added subtle shadow */
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
            color: #fff; /* Changed hover text color to white for better contrast */
        }

        .navbar-toggler {
            border-color: #DAA520;
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='%23DAA520' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        /* Dashboard Layout */
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
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: #DAA520;
            margin-bottom: 10px;
        }

        .logo-text {
            font-family: 'Playfair Display', serif;
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

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 30px;
            color: #e0e0e0;
        }

        .main-header {
            background: rgba(29, 29, 27, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 25px 30px;
            margin-bottom: 30px;
            border: 1px solid rgba(218, 165, 32, 0.2);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2); /* Enhanced shadow */
        }

        .main-header h2 {
            font-family: 'Playfair Display', serif; /* Use Playfair for main header */
            font-size: 2.2rem;
            color: #DAA520;
            margin-bottom: 8px;
        }

        .main-header .btn {
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .main-header .btn-success {
            background-color: #4CAF50;
            border-color: #4CAF50;
            color: white;
        }
        .main-header .btn-success:hover {
            background-color: #45a049;
            border-color: #45a049;
        }
        .main-header .btn-outline-primary {
            border-color: #DAA520;
            color: #DAA520;
        }
        .main-header .btn-outline-primary:hover {
            background-color: #DAA520;
            color: #1d1d1b;
        }

        .form-select, .form-control {
            background-color: rgba(255, 255, 255, 0.08); /* Slightly less transparent */
            border: 1px solid rgba(218, 165, 32, 0.4); /* Stronger border */
            color: #e0e0e0;
            padding: 0.75rem 1rem; /* Slightly larger padding for better touch */
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .form-select:focus, .form-control:focus {
            background-color: rgba(255, 255, 255, 0.15);
            border-color: #DAA520;
            box-shadow: 0 0 0 0.25rem rgba(218, 165, 32, 0.35); /* More prominent focus ring */
            color: #fff;
        }
        .form-select option {
            background-color: #1d1d1b;
            color: #e0e0e0;
        }
        .form-select:disabled, .form-control:disabled {
            background-color: rgba(255, 255, 255, 0.05);
            border-color: rgba(218, 165, 32, 0.1);
            color: #999;
        }

        .search-box::placeholder {
            color: #aaa;
        }

        .stats-grid .card {
    background: rgba(29, 29, 27, 0.9);
    backdrop-filter: blur(10px);
    border: 2px solid #B8860B;
    color: #fff;
    border-radius: 12px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    box-shadow: 0 4px 10px rgba(184, 134, 11, 0.3);
}

.stats-grid .card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 20px rgba(184, 134, 11, 0.5);
}

.stats-grid .card-title {
    color: #DAA520; /* Nhấn nhẹ tiêu đề bằng tông vàng sáng hơn */
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.stats-grid i {
    color: #B8860B;
    opacity: 0.7;
}


        /* Table Card - NEW STYLING for the table container */
        .card.table-card { /* Added a new class for the table's card */
            background: rgba(29, 29, 27, 0.9); /* Dark background */
            backdrop-filter: blur(10px);
            border: 1px solid rgba(218, 165, 32, 0.2);
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            overflow: hidden; /* Ensures rounded corners */
        }

        /* Table Header within the table-card */
        .card.table-card .card-header {
            background-color: rgba(218, 165, 32, 0.1); /* Light gold header */
            border-bottom: 1px solid rgba(218, 165, 32, 0.3);
            color: #DAA520; /* Gold text for table header title */
            font-weight: 600;
        }
        .card.table-card .card-header h5 {
            color: #DAA520; /* Ensure the h5 title is gold */
        }

        /* Table Body Styling */
        .table {
            color: #e0e0e0; /* Default text color for table body */
            margin-bottom: 0; /* Remove default table margin */
        }
        .table thead th {
            background-color: rgba(218, 165, 32, 0.1); /* Slightly lighter gold background for headers */
            border-bottom: 2px solid #DAA520; /* Solid gold line for table header */
            color: #DAA520; /* Gold text for table headers */
            font-weight: 600;
            padding: 1rem 0.75rem;
            vertical-align: middle;
        }
        .table tbody tr {
            
            transition: background-color 0.2s ease;
        }
        .table tbody tr:hover {
            
            background-color: linear-gradient(90deg, #DAA520, #B8860B); /* Slightly more prominent hover */
        }
        .table tbody td {
            border-top: 1px solid rgba(218, 165, 32, 0.15);
            vertical-align: middle;
            padding: 0.75rem;
            color: #e0e0e0; /* Default cell text color */
            background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
        }

        /* Table Specific Elements */
        .badge.bg-light {
            background-color: rgba(255, 255, 255, 0.15) !important; /* Lighter background for ID badge */
            color: #DAA520 !important; /* Gold text for ID badge */
            font-weight: 600;
        }
        .avatar {
            background-color: #DAA520 !important;
            color: #1d1d1b !important;
            font-weight: bold;
        }
        .text-primary { color: #DAA520 !important; } /* Icons and important text */
        .text-secondary { color: #ccc !important; } /* Muted text like time */
        .text-success { color: #4CAF50 !important; } /* Total amount */

        /* Status Badges - Keep distinct colors for status */
        .status-badge {
            font-weight: bold;
            padding: 0.4em 0.8em;
            border-radius: 0.3rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2); /* Subtle text shadow */
        }
        .status-pending { background-color: #ffc107; color: #1d1d1b; }
        .status-confirmed { background-color: #28a745; color: white; }
        .status-completed { background-color: #17a2b8; color: white; }
        .status-cancelled { background-color: #dc3545; color: white; }

        .edit-btn {
            border-color: #DAA520;
            color: #DAA520;
            padding: 6px 12px; /* Adjusted padding for smaller button */
            border-radius: 20px;
            font-size: 0.9rem;
        }
        .edit-btn:hover {
            background-color: #DAA520;
            color: #1d1d1b;
        }

        .services-list {
            max-width: 250px;
            white-space: normal;
            font-size: 0.95rem; /* Slightly smaller font for services list */
            color: #c0c0c0; /* Lighter color for service names */
        }

        /* Time slots buttons */
        #timeSlotsContainer {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            padding: 10px;
            border: 1px solid rgba(218, 165, 32, 0.2);
            border-radius: 8px;
            background-color: rgba(255, 255, 255, 0.05);
        }
        .time-slot-btn {
            background-color: rgba(218, 165, 32, 0.1);
            color: #DAA520;
            border: 1px solid rgba(218, 165, 32, 0.4);
            padding: 8px 15px;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }
        .time-slot-btn:hover:not(.disabled) {
            background-color: rgba(218, 165, 32, 0.3);
            color: #fff;
            transform: translateY(-2px);
        }
        .time-slot-btn.selected {
            background-color: #DAA520;
            color: #1d1d1b;
            border-color: #DAA520;
            font-weight: bold;
            transform: translateY(-1px);
        }
        .time-slot-btn.disabled {
            background-color: rgba(255, 255, 255, 0.05);
            color: #666;
            border-color: #333;
            cursor: not-allowed;
            opacity: 0.6;
            box-shadow: none;
        }

        /* Modal customizations */
        .modal-content {
            background: rgba(29, 29, 27, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(218, 165, 32, 0.3);
            color: #e0e0e0;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }
        .modal-header {
            background: rgba(218, 165, 32, 0.15);
            border-bottom: 1px solid rgba(218, 165, 32, 0.3);
            color: #DAA520 !important;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }
        .modal-header .modal-title {
            font-family: 'Playfair Display', serif;
            color: #DAA520 !important;
            font-weight: 600;
        }
        .modal-header .btn-close {
            filter: invert(1);
            font-size: 0.8rem;
        }
        .modal-footer {
            border-top: 1px solid rgba(218, 165, 32, 0.15);
            background: rgba(29, 29, 27, 0.8);
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }
        .modal-footer .btn {
            border-radius: 25px;
            padding: 8px 18px;
            font-weight: 500;
        }
        .modal-footer .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
            color: white;
        }
        .modal-footer .btn-primary {
            background-color: #DAA520;
            border-color: #DAA520;
            color: #1d1d1b;
        }
        .modal-footer .btn-primary:hover {
            background-color: #B8860B;
            border-color: #B8860B;
        }
        .modal-footer .btn-success {
             background-color: #4CAF50;
             border-color: #4CAF50;
             color: white;
         }
        .modal-footer .btn-success:hover {
            background-color: #45a049;
            border-color: #45a049;
        }

        .form-check-label {
            color: #e0e0e0;
            padding-left: 0.5rem;
        }
        .form-check-input {
            background-color: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(218, 165, 32, 0.3);
        }
        .form-check-input:checked {
            background-color: #DAA520;
            border-color: #DAA520;
        }
        .service-checkbox:hover .form-check-label {
            color: #DAA520;
        }

        .form-text {
            color: #DAA520 !important;
            font-weight: bold;
        }

        /* Toast notifications */
        .toast {
            background-color: rgba(29, 29, 27, 0.98);
            border: 1px solid rgba(218, 165, 32, 0.4);
            color: #e0e0e0;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }
        .toast-header {
            background-color: rgba(218, 165, 32, 0.2);
            color: #DAA520;
            border-bottom: 1px solid rgba(218, 165, 32, 0.3);
            padding: 0.75rem 1rem;
        }
        .toast-header .btn-close {
            filter: invert(1);
        }
        .toast-body {
            color: #e0e0e0;
            padding: 1rem;
        }

        /* Mobile Responsive adjustments */
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
            box-shadow: 0 2px 5px rgba(0,0,0,0.3);
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

            .dashboard-layout {
                padding-top: 70px;
            }

            .main-header .d-flex {
                flex-direction: column;
                align-items: flex-start !important;
                gap: 15px;
            }

            .main-header .form-select,
            .main-header .search-box,
            .main-header .btn-group,
            .main-header .btn {
                width: 100% !important;
            }
        }
    </style>
</head>
<body class="bg-dark">
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
                    <a href="${pageContext.request.contextPath}/admin/view-staff" class="nav-link">
                        <i class="fas fa-user-tie"></i>
                        <span>Quản lý Nhân viên</span>
                    </a>
                </div>
                <div class="nav-item">
                    <a href="${pageContext.request.contextPath}/AppointmentManagerServlet" class="nav-link active">
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

        <main class="main-content">
            <div class="container-fluid py-4">
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="main-header d-flex justify-content-between align-items-center flex-wrap gap-3">
                            <h2 class="text-primary mb-0">
                                <i class="fas fa-calendar-alt me-2"></i>
                                Quản lý Lịch hẹn
                            </h2>
                            <div class="d-flex gap-2 flex-wrap">
                                <button class="btn btn-success" onclick="openAddModal()">
                                    <i class="fas fa-plus me-1"></i>Thêm lịch hẹn
                                </button>
                                <select id="branchFilter" class="form-select" style="width: 200px;">
                                    <option value="all">Tất cả chi nhánh</option>
                                    <c:forEach var="branch" items="${branchList}">
                                        <option value="${branch.id}">${branch.name}</option>
                                    </c:forEach>
                                </select>
                                <input type="text" id="searchInput" class="form-control search-box"
                                       placeholder="Tìm kiếm theo tên khách hàng..." style="width: 300px;">
                                <button class="btn btn-outline-primary" onclick="refreshData()">
                                    <i class="fas fa-sync-alt"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mb-4 stats-grid">
                    <div class="col-md-3">
                        <div class="card text-white">
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
                        <div class="card  text-white">
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
                        <div class="card  text-white">
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
                        <div class="card  text-white">
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
                        <div class="card border-0 table-card"> <div class="card-header py-3">
                                <h5 class="mb-0">Danh sách Lịch hẹn</h5> </div>
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
                                            <tr data-branch-id="${appointment.branchId}">
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
        </main>
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
                        <div class="mb-3">
                            <label for="addBranchId" class="form-label fw-bold">
                                <i class="fas fa-store me-1 text-primary"></i>Chi nhánh *
                            </label>
                            <select class="form-select" id="addBranchId" name="branchId" required>
                                <option value="">Chọn chi nhánh...</option>
                                <c:forEach var="branch" items="${branchList}">
                                    <option value="${branch.id}">${branch.name}</option>
                                </c:forEach>
                            </select>
                        </div>

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
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label for="addAppointmentDate" class="form-label fw-bold">
                                    <i class="fas fa-calendar-alt me-1 text-primary"></i>Ngày hẹn *
                                </label>
                                <input type="text" class="form-control" id="addAppointmentDate" name="appointmentDate" placeholder="Chọn ngày" required readonly>
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

    <script src="https://cdn.jsdelivr.net/npm/luxon@3.4.4/build/global/luxon.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        // Store customer data directly from JSP for client-side use
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

        // Store ALL staff data, including branchId, for client-side filtering
        const allStaff = [            <c:forEach var="staff" items="${listStaff}" varStatus="loop">                {                    id: ${staff.id},                    firstName: '${staff.firstName}',                    lastName: '${staff.lastName}',                    branchId: ${staff.branchId}                }<c:if test="${!loop.last}">,</c:if>            </c:forEach>        ];

        // Store all appointments for client-side filtering
        const allAppointments = [            <c:forEach var="appointment" items="${listAppointment}" varStatus="loop">                {                    id: ${appointment.id},                    customerId: ${appointment.customerId},                    staffId: ${appointment.staffId},                    appointmentTime: '${appointment.appointmentTime}',                    status: '${appointment.status}',                    customerName: '${appointment.customerName}',                    services: '${appointment.services}',                    totalAmount: ${appointment.totalAmount},                    branchId: ${appointment.branchId}                }<c:if test="${!loop.last}">,</c:if>            </c:forEach>        ];

        // Toggle sidebar for mobile - Copied from dashboard.jsp
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }

        // Close sidebar when clicking outside on mobile - Copied from dashboard.jsp
        document.addEventListener('click', function (event) {
            const sidebar = document.getElementById('sidebar');
            const menuBtn = document.querySelector('.mobile-menu-btn');

            if (window.innerWidth <= 768 && !sidebar.contains(event.target) && !menuBtn.contains(event.target)) {
                sidebar.classList.remove('active');
            }
        });

        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            updateStatistics();
            setupSearch();
            setupAddModalCustomerStaffLogic();
            initFlatpickrAndGenerateTimeSlots();
            setupBranchFilter();
            filterAppointments();
            setupAddModalBranchStaffFiltering();
        });

        // Update statistics
        function updateStatistics() {
            const rows = document.querySelectorAll('#appointmentsTable tbody tr');
            let pending = 0, confirmed = 0, completed = 0, cancelled = 0;

            rows.forEach(row => {
                if (row.style.display !== 'none') {
                    const statusBadge = row.querySelector('.status-badge');
                    if (statusBadge.classList.contains('status-pending')) pending++;
                    else if (statusBadge.classList.contains('status-confirmed')) confirmed++;
                    else if (statusBadge.classList.contains('status-completed')) completed++;
                    else if (statusBadge.classList.contains('status-cancelled')) cancelled++;
                }
            });

            document.getElementById('pendingCount').textContent = pending;
            document.getElementById('confirmedCount').textContent = confirmed;
            document.getElementById('completedCount').textContent = completed;
            document.getElementById('cancelledCount').textContent = cancelled;
        }

        // Setup search functionality for the main table
        function setupSearch() {
            const searchInput = document.getElementById('searchInput');
            searchInput.addEventListener('input', filterAppointments);
        }

        // Logic for Customer Phone Lookup and Staff Dropdown in Add Modal
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
                    customerNameDisplay.style.backgroundColor = '';
                    customerNameDisplay.style.color = '';
                    customerNameDisplay.style.fontWeight = 'normal';
                    addCustomerIdHidden.value = '';
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

        // --- FUNCTIONS FOR APPOINTMENT TIME CONSTRAINTS ---
        let flatpickrInstance = null;

        function generateTimeSlots(selectedDate) {
            const { DateTime } = luxon;
            const timeSlotsContainer = document.getElementById('timeSlotsContainer');
            const addAppointmentTimeHiddenInput = document.getElementById('addAppointmentTime');
            timeSlotsContainer.innerHTML = '';
            addAppointmentTimeHiddenInput.value = '';

            if (!selectedDate) {
                timeSlotsContainer.innerHTML = '<span class="text-muted">Vui lòng chọn ngày để xem giờ khả dụng.</span>';
                return;
            }

            const nowVN = DateTime.now().setZone('Asia/Ho_Chi_Minh');
            const selectedDateVN = DateTime.fromJSDate(selectedDate, { zone: 'Asia/Ho_Chi_Minh' });
            const isSelectedDateToday = selectedDateVN.hasSame(nowVN, 'day');

            const startHour = 8;
            const startMinute = 30;
            const endHour = 20;
            const endMinute = 30;

            let currentSlotTime = DateTime.fromObject({
                year: selectedDateVN.year,
                month: selectedDateVN.month,
                day: selectedDateVN.day,
                hour: startHour,
                minute: startMinute
            }, { zone: 'Asia/Ho_Chi_Minh' });

            const endTime = DateTime.fromObject({
                year: selectedDateVN.year,
                month: selectedDateVN.month,
                day: selectedDateVN.day,
                hour: endHour,
                minute: endMinute
            }, { zone: 'Asia/Ho_Chi_Minh' });

            let slotsGenerated = 0;

            while (currentSlotTime <= endTime) {
                const slotText = currentSlotTime.toFormat('HH:mm');
                const slotValue = currentSlotTime.toISO({ suppressMilliseconds: true, includeOffset: false });

                const button = document.createElement('button');
                button.type = 'button';
                button.classList.add('time-slot-btn');
                button.textContent = slotText;
                button.setAttribute('data-time', slotValue);

                const isPastSlot = isSelectedDateToday && currentSlotTime <= nowVN;

                if (isPastSlot) {
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

                currentSlotTime = currentSlotTime.plus({ minutes: 30 });
            }

            if (slotsGenerated === 0) {
                timeSlotsContainer.innerHTML = '<span class="text-muted">Không có giờ khả dụng cho ngày này.</span>';
            }
        }

        function initFlatpickrAndGenerateTimeSlots() {
            const addAppointmentDateInput = document.getElementById('addAppointmentDate');

            if (flatpickrInstance) {
                flatpickrInstance.destroy();
            }

            flatpickrInstance = flatpickr(addAppointmentDateInput, {
                inline: false,
                minDate: "today",
                dateFormat: "Y-m-d",
                altInput: true,
                altFormat: "d F, Y",
                onChange: function(selectedDates, dateStr, instance) {
                    const selectedFlatpickrDate = selectedDates[0] || null;
                    generateTimeSlots(selectedFlatpickrDate);
                }
            });

            const { DateTime } = luxon;
            const nowVN = DateTime.now().setZone('Asia/Ho_Chi_Minh');
            const initialDateStr = nowVN.toFormat('yyyy-MM-dd');

            flatpickrInstance.setDate(initialDateStr, true);
            generateTimeSlots(new Date(initialDateStr));
        }

        // Open add modal
        function openAddModal() {
            document.getElementById('addForm').reset();
            document.getElementById('addCustomerPhone').value = '';
            document.getElementById('customerNameDisplay').textContent = '';
            document.getElementById('customerNameDisplay').classList.remove('text-success', 'text-danger');
            document.getElementById('customerNameDisplay').style.backgroundColor = '';
            document.getElementById('customerNameDisplay').style.color = '';
            document.getElementById('customerNameDisplay').style.fontWeight = 'normal';
            document.getElementById('addCustomerId').value = '';
            document.getElementById('addStaffId').value = '';
            document.getElementById('addBranchId').value = '';
            filterStaffByBranch(); // Filter staff when branch is reset

            const addCheckboxes = document.querySelectorAll('input[name="addServiceIds"]');
            addCheckboxes.forEach(cb => cb.checked = false);

            initFlatpickrAndGenerateTimeSlots();

            document.querySelectorAll('.time-slot-btn').forEach(btn => btn.classList.remove('selected'));
            document.getElementById('addAppointmentTime').value = '';

            new bootstrap.Modal(document.getElementById('addModal')).show();
        }

        // Save new appointment
        function saveNewAppointment() {
            const customerId = document.getElementById('addCustomerId').value;
            const staffId = document.getElementById('addStaffId').value;
            const appointmentTime = document.getElementById('addAppointmentTime').value;
            const branchId = document.getElementById('addBranchId').value;
            const checkedBoxes = document.querySelectorAll('input[name="addServiceIds"]:checked');

            // Validation
            if (!branchId || branchId === '') {
                showNotification('Vui lòng chọn chi nhánh!', 'error');
                return;
            }

            if (!customerId || customerId === '') {
                showNotification('Vui lòng nhập và chọn khách hàng hợp lệ!', 'error');
                return;
            }

            if (!staffId || staffId === '') {
                showNotification('Vui lòng chọn nhân viên!', 'error');
                return;
            }

            if (!appointmentTime) {
                showNotification('Vui lòng chọn ngày và giờ hẹn cụ thể!', 'error');
                return;
            }

            const { DateTime } = luxon;
            const selectedDateTime = DateTime.fromISO(appointmentTime, { zone: 'Asia/Ho_Chi_Minh' });
            const nowVN = DateTime.now().setZone('Asia/Ho_Chi_Minh');
            const gracePeriodMs = 5 * 60 * 1000; // 5 minutes

            if (selectedDateTime < nowVN.minus({ milliseconds: gracePeriodMs })) {
                showNotification('Thời gian hẹn đã chọn đã trôi qua quá lâu. Vui lòng chọn thời gian gần đây hơn hoặc trong tương lai.', 'error');
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
                branchId: parseInt(branchId),
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

        // Open edit modal
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

        // Show toast notification
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

        // Refresh data
        function refreshData() {
            location.reload();
        }

        // Setup branch filter
        function setupBranchFilter() {
            const branchFilterSelect = document.getElementById('branchFilter');
            branchFilterSelect.addEventListener('change', filterAppointments);
        }

        // Filter appointments
        function filterAppointments() {
            const searchInput = document.getElementById('searchInput');
            const branchFilterSelect = document.getElementById('branchFilter');

            const searchTerm = searchInput.value.toLowerCase();
            const selectedBranchId = branchFilterSelect.value === 'all' ? null : parseInt(branchFilterSelect.value);

            const rows = document.querySelectorAll('#appointmentsTable tbody tr');

            let pending = 0, confirmed = 0, completed = 0, cancelled = 0;

            rows.forEach(row => {
                const customerName = row.cells[1].textContent.toLowerCase();
                const rowBranchId = parseInt(row.getAttribute('data-branch-id'));
                const statusBadge = row.querySelector('.status-badge');

                const matchesSearch = customerName.includes(searchTerm);
                const matchesBranch = (selectedBranchId === null || rowBranchId === selectedBranchId);

                if (matchesSearch && matchesBranch) {
                    row.style.display = '';
                    if (statusBadge.classList.contains('status-pending')) pending++;
                    else if (statusBadge.classList.contains('status-confirmed')) confirmed++;
                    else if (statusBadge.classList.contains('status-completed')) completed++;
                    else if (statusBadge.classList.contains('status-cancelled')) cancelled++;
                } else {
                    row.style.display = 'none';
                }
            });

            document.getElementById('pendingCount').textContent = pending;
            document.getElementById('confirmedCount').textContent = confirmed;
            document.getElementById('completedCount').textContent = completed;
            document.getElementById('cancelledCount').textContent = cancelled;
        }

        // Filter staff by branch
        function filterStaffByBranch() {
            const selectedBranchId = document.getElementById('addBranchId').value;
            const staffSelect = document.getElementById('addStaffId');

            staffSelect.innerHTML = '<option value="">Chọn nhân viên...</option>';

            if (selectedBranchId && selectedBranchId !== '') {
                const filteredStaff = allStaff.filter(staff => staff.branchId == parseInt(selectedBranchId));

                filteredStaff.forEach(staff => {
                    const option = document.createElement('option');
                    option.value = staff.id;
                    option.textContent = `${staff.lastName} ${staff.firstName}`;
                    staffSelect.appendChild(option);
                });
            }
        }

        // Setup listener for branch dropdown in Add Modal
        function setupAddModalBranchStaffFiltering() {
            const branchSelect = document.getElementById('addBranchId');
            branchSelect.addEventListener('change', filterStaffByBranch);
        }
    </script>
</body>
</html>
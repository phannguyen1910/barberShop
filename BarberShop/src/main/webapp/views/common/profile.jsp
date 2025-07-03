<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Kiểm tra xem đối tượng Customer có trong session không
    if (session.getAttribute("customer") == null) {
        response.sendRedirect(request.getContextPath() + "/login"); // Chuyển hướng về trang login nếu chưa đăng nhập
        return;
    }
    // Ghi chú: Nếu bạn muốn hiển thị một thông báo lỗi cụ thể khi chưa đăng nhập
    // sau khi chuyển hướng, bạn có thể đặt một attribute vào request trước khi sendRedirect.
    // request.getSession().setAttribute("loginMessage", "Bạn cần đăng nhập để xem thông tin.");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Profile - Cut&Styles Barber</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/profile.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <style>
            /* General styles for the Profile Page to match overall theme */
            body {
                font-family: 'Inter', sans-serif;
                background: linear-gradient(rgba(29, 29, 27, 0.7), rgba(29, 29, 27, 0.7)),
                    url('https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1374&q=80');
                background-size: cover;
                background-position: center;
                background-attachment: fixed;
                min-height: 100vh;
                color: #e0e0e0; /* Light text for dark background */
            }

            .section-title {
                font-family: 'Playfair Display', serif;
                font-size: 2.5rem;
                font-weight: 700;
                color: #DAA520; /* Gold accent color */
                text-align: center;
                margin-bottom: 2.5rem;
                position: relative;
                padding-bottom: 0.5rem;
            }

            .section-title::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 3px;
                background-color: #DAA520;
                border-radius: 2px;
            }

            .status-unknown {
                color: gray;
                font-weight: bold;
            }

            .service-card { /* Reusing name, but acts as a content card */
                background: rgba(29, 29, 27, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 30px;
                border: 1px solid rgba(218, 165, 32, 0.2);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
                color: #e0e0e0;
                max-width: 800px; /* Limit width for better readability */
                margin: 0 auto; /* Center the card */
                margin-bottom: 30px; /* Add space below this card */
            }

            .table-responsive {
                margin-top: 20px;
            }

            .table {
                color: #e0e0e0;
            }

            .table-borderless tbody tr td {
                border: none;
                padding-top: 10px;
                padding-bottom: 10px;
            }

            .fw-bold {
                color: #DAA520; /* Gold for bold labels */
                font-weight: 600 !important;
            }

            .btn-primary {
                background-color: #DAA520;
                border-color: #DAA520;
                color: #1d1d1b; /* Dark text on gold button */
                font-weight: 500;
                padding: 10px 20px;
                border-radius: 25px;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                background-color: #B8860B;
                border-color: #B8860B;
                color: #fff; /* White text on hover */
                transform: translateY(-2px);
            }

            .btn-primary:active {
                transform: translateY(0);
            }

            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border-color: #badbcc;
                text-align: center;
                margin-bottom: 1rem;
                border-radius: 8px;
                padding: 15px;
            }

            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border-color: #f5c6cb;
                text-align: center;
                margin-bottom: 1rem;
                border-radius: 8px;
                padding: 15px;
            }

            /* Enhanced Modal Styles - White background with black text */
            #historyTableModal .modal-content {
                background: #ffffff; /* White background */
                border-radius: 15px;
                border: 2px solid #DAA520; /* Gold border */
                color: #000000; /* Black text */
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            }

            #historyTableModal .modal-header {
                background: linear-gradient(135deg, #DAA520, #B8860B);
                border-bottom: none;
                border-radius: 15px 15px 0 0;
                padding: 20px 30px;
            }

            #historyTableModal .modal-title {
                font-weight: 700;
                color: #ffffff; /* White text on gold background */
                font-family: 'Playfair Display', serif;
                font-size: 1.5rem;
            }

            #historyTableModal .btn-close {
                filter: brightness(0) invert(1); /* White close button */
            }

            #historyTableModal .modal-body {
                padding: 30px;
                background: #ffffff;
            }

            #historyTableModal .table {
                color: #000000; /* Black text */
                margin-bottom: 0;
                border-collapse: separate;
                border-spacing: 0;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            #historyTableModal .table thead th {
                background: linear-gradient(135deg, #DAA520, #B8860B);
                color: #ffffff; /* White text on gold background */
                border: none;
                text-align: center;
                vertical-align: middle;
                font-weight: 600;
                padding: 15px 12px;
                font-size: 0.95rem;
            }

            #historyTableModal .table thead th:first-child {
                border-top-left-radius: 10px;
            }

            #historyTableModal .table thead th:last-child {
                border-top-right-radius: 10px;
            }

            #historyTableModal .table tbody tr td {
                vertical-align: middle;
                text-align: center;
                padding: 12px;
                border-bottom: 1px solid #e9ecef;
                font-size: 0.9rem;
            }

            #historyTableModal .table tbody tr:nth-child(even) {
                background-color: #f8f9fa; /* Light gray stripe */
            }

            #historyTableModal .table tbody tr:hover {
                background-color: #fff3cd; /* Light gold hover effect */
                transform: translateY(-1px);
                transition: all 0.2s ease;
            }

            #historyTableModal .modal-footer {
                background: #f8f9fa;
                border-top: 1px solid #dee2e6;
                border-radius: 0 0 15px 15px;
                padding: 20px 30px;
            }

            /* Status styles with better contrast for white background */
            .status-pending {
                color: #ff8c00;
                font-weight: bold;
                background: #fff3cd;
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 0.8rem;
            }
            .status-confirmed {
                color: #28a745;
                font-weight: bold;
                background: #d4edda;
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 0.8rem;
            }
            .status-completed {
                color: #17a2b8;
                font-weight: bold;
                background: #d1ecf1;
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 0.8rem;
            }
            .status-cancelled {
                color: #dc3545;
                font-weight: bold;
                background: #f8d7da;
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 0.8rem;
            }

            /* Cancel button styles */
            .btn-cancel {
                background-color: #dc3545;
                border-color: #dc3545;
                color: #ffffff;
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-cancel:hover {
                background-color: #c82333;
                border-color: #bd2130;
                color: #ffffff;
                transform: scale(1.05);
            }

            .btn-cancel:disabled {
                background-color: #6c757d;
                border-color: #6c757d;
                color: #ffffff;
                cursor: not-allowed;
                opacity: 0.6;
            }

            /* Loading message styles */
            #noHistoryMessage {
                color: #6c757d;
                font-style: italic;
                padding: 40px 20px;
                text-align: center;
                font-size: 1.1rem;
            }

            /* Footer Styles from dashboard/appointment management */
            .footer {
                background: rgba(29, 29, 27, 0.95); /* Dark background for consistency */
                backdrop-filter: blur(10px);
                color: #f5f5f5;
                padding: 40px 0;
                margin-top: 60px; /* Space above footer */
                border-top: 2px solid rgba(218, 165, 32, 0.3);
            }

            .footer .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 15px;
            }

            .footer-col {
                margin-bottom: 30px;
            }

            .footer-logo {
                width: 120px; /* Adjust size as needed */
                margin-bottom: 20px;
                filter: brightness(1.2); /* Make logo stand out on dark */
            }

            .footer-title {
                font-size: 1.2rem;
                font-weight: 600;
                color: #DAA520; /* Gold color for titles */
                margin-bottom: 20px;
            }

            .footer-links {
                list-style: none;
                padding: 0;
            }

            .footer-links li {
                margin-bottom: 10px;
            }

            .footer-links a {
                color: #cccccc;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .footer-links a:hover {
                color: #DAA520; /* Gold hover effect */
            }

            .footer-contact p {
                color: #cccccc;
                margin-bottom: 8px;
                display: flex;
                align-items: flex-start;
            }

            .footer-contact i {
                margin-right: 10px;
                color: #DAA520; /* Gold icons */
                font-size: 1.1em;
                flex-shrink: 0; /* Prevent icon from shrinking */
            }

            .footer-bottom {
                border-top: 1px solid rgba(255, 255, 255, 0.1);
                padding-top: 20px;
                margin-top: 20px;
                color: #999999;
                font-size: 0.9rem;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .section-title {
                    font-size: 2rem;
                }
                .service-card {
                    padding: 20px;
                }
                .footer-col {
                    text-align: center;
                }
                .footer-contact p {
                    justify-content: center;
                }
                .footer-logo {
                    margin-left: auto;
                    margin-right: auto;
                }

                #historyTableModal .modal-body {
                    padding: 15px;
                }

                #historyTableModal .table {
                    font-size: 0.8rem;
                }

                .btn-cancel {
                    font-size: 0.7rem;
                    padding: 4px 8px;
                }
            }
        </style>
    </head>
    <body>
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <%-- Hiển thị errorMessage từ Servlet nếu có (ví dụ: chưa đăng nhập) --%>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <jsp:include page="/views/common/navbar.jsp"/>

        <div class="container mt-5">
            <h2 class="section-title">Thông tin cá nhân</h2>

            <div class="service-card shadow-sm">
                <div class="service-info">
                    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                        <a href="${pageContext.request.contextPath}/views/common/editProfile.jsp" class="btn btn-primary">
                            <i class="fa fa-edit"></i> Chỉnh sửa thông tin
                        </a>
                        <%-- Nút mở Modal cho Lịch sử đặt lịch --%>
                        <button id="showHistoryModalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#historyTableModal">
                            <i class="fas fa-history"></i> Lịch sử đặt lịch
                        </button>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-borderless">
                            <tbody>
                                <tr>
                                    <td class="fw-bold" style="width: 150px;">Họ:</td>
                                    <td>${sessionScope.customer.lastName}</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Tên:</td>
                                    <td>${sessionScope.customer.firstName}</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Email:</td>
                                    <td>${sessionScope.customer.email}</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Số điện thoại:</td>
                                    <td>${sessionScope.customer.phoneNumber}</td>
                                </tr>
                                <%-- Kiểm tra role nếu Customer có thuộc tính role và là Staff --%>
                                <c:if test="${sessionScope.customer.role == 'Staff'}">
                                    <tr>
                                        <td class="fw-bold">Ảnh:</td>
                                        <td>
                                            <c:if test="${not empty sessionScope.customer.img}">
                                                <img src="${pageContext.request.contextPath}/${sessionScope.customer.img}" alt="Staff Image" width="100">
                                            </c:if>
                                            <c:if test="${empty sessionScope.customer.img}">
                                                Không có ảnh
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <%-- Modal Dialog cho Lịch sử đặt lịch --%>
        <div class="modal fade" id="historyTableModal" tabindex="-1" aria-labelledby="historyTableModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="historyTableModalLabel">
                            <i class="fas fa-history me-2"></i>Lịch sử đặt lịch của bạn
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div id="historyTableContainer" class="table-responsive">
                            <p id="noHistoryMessage" class="text-center">Đang tải lịch sử đặt lịch...</p>
                            <table class="table" id="historyTable" style="display: none;"> <%-- Mặc định ẩn bảng --%>
                                <thead>
                                    <tr>
                                        <th>Thời gian</th>
                                        <th>Dịch vụ</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Nhân viên</th>
                                        <th>Chi nhánh</th>
                                        <th>Thao tác</th>
                                        <th>Thanh toán còn lại</th><%-- New column for cancel button --%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%-- Dữ liệu sẽ được điền vào đây bởi JavaScript --%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>Đóng
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-6 footer-col">
                        <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Cut&Styles Logo" class="footer-logo">                    
                    </div>

                    <div class="col-lg-4 col-md-6 footer-col">
                        <h4 class="footer-title">Liên kết nhanh</h4>
                        <ul class="footer-links">
                            <li><a href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/common/franchise.jsp">Liên hệ nhượng quyền</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/commit/details.jsp">Chính sách cam kết</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-4 col-md-6 footer-col">
                        <h4 class="footer-title">Thông tin liên hệ</h4>
                        <div class="footer-contact">
                            <p><i class="bi bi-geo-alt-fill"></i> <span>Khu đô thị FPT city, Hòa Hải, Ngũ Hành Sơn, Đà Nẵng</span></p>
                            <p><i class="bi bi-telephone-fill"></i> <span>Liên hệ học nghề tóc: 0774511941</span></p>
                            <p><i class="bi bi-clock-fill"></i> <span>Giờ phục vụ: Thứ 2 đến Chủ Nhật, 8h30 - 20h30</span></p>
                        </div>
                    </div>
                </div>

                <div class="row footer-bottom">
                    <div class="col-12 text-center">
                        <p>&copy; 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
                    </div>
                </div>
            </div>
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const showHistoryModalBtn = document.getElementById('showHistoryModalBtn');
                const historyTableBody = document.querySelector('#historyTable tbody');
                const historyTable = document.getElementById('historyTable');
                const noHistoryMessage = document.getElementById('noHistoryMessage');

                showHistoryModalBtn.addEventListener('click', function () {
                    // Hiển thị thông báo "Đang tải..." và ẩn bảng cũ
                    noHistoryMessage.textContent = 'Đang tải lịch sử đặt lịch...';
                    noHistoryMessage.style.display = 'block';
                    historyTable.style.display = 'none';
                    historyTableBody.innerHTML = ''; // Xóa nội dung cũ trong bảng

                    fetch('${pageContext.request.contextPath}/HistoryAppointmentServlet')
                            .then(response => {
                                return response.text().then(text => {
                                    if (!response.ok) {
                                        try {
                                            const errorData = JSON.parse(text);
                                            if (response.status === 401 && errorData.error) {
                                                throw new Error(errorData.error);
                                            }
                                            throw new Error(`Lỗi Server (${response.status} ${response.statusText}): ` + (errorData.message || JSON.stringify(errorData)));
                                        } catch (e) {
                                            console.error("Raw Server Error Response (not JSON):", text);
                                            const errorMessage = text.substring(0, Math.min(text.length, 200));
                                            throw new Error(`Lỗi Server (${response.status} ${response.statusText}): ` + errorMessage + '...');
                                        }
                                    }
                                    return JSON.parse(text);
                                });
                            })
                            .then(data => {
                                noHistoryMessage.style.display = 'none';
                                if (data && data.length > 0) {
                                    historyTable.style.display = 'table';
                                    data.forEach(appointment => {
                                        const row = historyTableBody.insertRow();

                                        row.insertCell().textContent = formatDateTime(appointment.appointmentTime);
                                        row.insertCell().textContent = appointment.services;

                                        const totalAmountCell = row.insertCell();
                                        totalAmountCell.textContent = formatCurrency(appointment.totalAmount);

                                        // Trạng thái
                                        const statusCell = row.insertCell();
                                        const statusSpan = document.createElement('span');
                                        statusSpan.textContent = appointment.status;
                                        statusSpan.className = getStatusClass(appointment.status);
                                        statusCell.appendChild(statusSpan);

                                        row.insertCell().textContent = appointment.staffName;
                                        row.insertCell().textContent = appointment.branchName;

                                        // Thao tác
                                        const actionCell = row.insertCell();
                                        const canCancel = appointment.status === 'Pending' || appointment.status === 'Confirmed';
                                        if (canCancel) {
                                            const cancelBtn = document.createElement('button');
                                            cancelBtn.className = 'btn btn-cancel';
                                            cancelBtn.innerHTML = '<i class="fas fa-times me-1"></i>Hủy';
                                            cancelBtn.onclick = function () {
                                                handleCancelAppointment(appointment.id, appointment.status);
                                            };
                                            actionCell.appendChild(cancelBtn);
                                        } else {
                                            const disabledBtn = document.createElement('button');
                                            disabledBtn.className = 'btn btn-cancel';
                                            disabledBtn.innerHTML = '<i class="fas fa-ban me-1"></i>Hủy';
                                            disabledBtn.disabled = true;
                                            actionCell.appendChild(disabledBtn);
                                        }

                                        // ✅ Thanh toán còn lại (hiển thị nút nếu Confirmed)
                                        const remainCell = row.insertCell();
                                        if (appointment.status.toLowerCase() === 'confirmed') {
                                            const form = document.createElement('form');
                                            form.method = 'POST';
                                            form.action = '${pageContext.request.contextPath}/final-payment';

                                            const input = document.createElement('input');
                                            input.type = 'hidden';
                                            input.name = 'appointmentId';
                                            input.value = appointment.id;

                                            const payBtn = document.createElement('button');
                                            payBtn.className = 'btn btn-primary';
                                            payBtn.type = 'submit';
                                            payBtn.innerHTML = '<i class="fas fa-credit-card me-1"></i>Thanh toán';

                                            form.appendChild(input);
                                            form.appendChild(payBtn);
                                            remainCell.appendChild(form);
                                        } else {
                                            remainCell.textContent = '-';
                                        }

                                    });

                                } else {
                                    noHistoryMessage.textContent = 'Bạn chưa có lịch sử đặt lịch nào.';
                                    noHistoryMessage.style.display = 'block';
                                    historyTable.style.display = 'none';
                                }
                            })
                            .catch(error => {
                                console.error('Error fetching history:', error);
                                noHistoryMessage.textContent = 'Không thể tải lịch sử đặt lịch: ' + error.message;
                                noHistoryMessage.style.display = 'block';
                                historyTable.style.display = 'none';
                                alert('Lỗi: ' + error.message);
                            });
                });

                // Function to handle cancel appointment
                function handleCancelAppointment(appointmentId, status) {
                    if (status === 'Confirmed') {
                        // Show warning for confirmed appointments
                        if (confirm('Nếu như hủy lịch bạn sẽ mất tiền đặt cọc. Bạn có chắc chắn muốn hủy lịch không?')) {
                            cancelAppointment(appointmentId);
                        }
                    } else if (status === 'Pending') {
                        // Direct confirmation for pending appointments
                        if (confirm('Bạn có chắc chắn muốn hủy lịch hẹn này không?')) {
                            cancelAppointment(appointmentId);
                        }
                    }
                }

                // Function to send cancel request to servlet
                function cancelAppointment(appointmentId) {
                    // Create form and submit
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/CancelAppointmentServlet';

                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'appointmentId';
                    input.value = appointmentId;

                    form.appendChild(input);
                    document.body.appendChild(form);
                    form.submit();
                }

                // Function to get status CSS class
                function getStatusClass(status) {
                    switch (status) {
                        case 'Pending':
                            return 'status-pending';
                        case 'Confirmed':
                            return 'status-confirmed';
                        case 'Completed':
                            return 'status-completed';
                        case 'Cancelled':
                            return 'status-cancelled';
                        default:
                            return 'status-unknown';
                    }
                }

                // Hàm định dạng ngày giờ
                function formatDateTime(isoString) {
                    if (!isoString)
                        return '';
                    try {
                        const date = new Date(isoString);
                        if (isNaN(date.getTime())) {
                            throw new Error('Invalid date string');
                        }
                        const options = {
                            year: 'numeric',
                            month: '2-digit',
                            day: '2-digit',
                            hour: '2-digit',
                            minute: '2-digit',
                            second: '2-digit',
                            hour12: false
                        };
                        return date.toLocaleString('vi-VN', options);
                    } catch (e) {
                        console.error("Lỗi định dạng ngày giờ cho chuỗi:", isoString, e);
                        return isoString;
                    }
                }

                // Hàm định dạng tiền tệ
                function formatCurrency(amount) {
                    const numAmount = parseFloat(amount);
                    if (isNaN(numAmount)) {
                        console.warn("Giá trị không phải số để định dạng tiền tệ:", amount);
                        return amount;
                    }
                    return numAmount.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                }
            });
        </script>
    </body>
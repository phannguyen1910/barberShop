<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                color: #e0e0e0;
            }

            .section-title {
                font-family: 'Playfair Display', serif;
                font-size: 2.5rem;
                font-weight: 700;
                color: #DAA520;
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

            /* Modern Profile Card */
            .profile-card {
                background: linear-gradient(135deg, #DAA520 0%, #B8860B 100%);
                border-radius: 25px;
                padding: 0;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
                color: white;
                overflow: hidden;
                margin-bottom: 30px;
                position: relative;
            }

            .profile-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 100%);
                pointer-events: none;
            }

            .profile-header {
                padding: 40px 30px 30px;
                text-align: center;
                position: relative;
                z-index: 2;
            }

            .profile-avatar {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                border: 4px solid rgba(255, 255, 255, 0.3);
                margin: 0 auto 20px;
                overflow: hidden;
                background: rgba(255, 255, 255, 0.1);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 3rem;
                color: rgba(255, 255, 255, 0.8);
            }

            .profile-avatar img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .profile-name {
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 8px;
                text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            }

            .profile-role {
                font-size: 1.1rem;
                opacity: 0.9;
                margin-bottom: 25px;
            }

            .profile-edit-btn {
                background: rgba(255, 255, 255, 0.15);
                border: 2px solid rgba(255, 255, 255, 0.3);
                color: white;
                padding: 12px 30px;
                border-radius: 25px;
                font-weight: 500;
                transition: all 0.3s ease;
                backdrop-filter: blur(10px);
                text-decoration: none;
                display: inline-block;
            }

            .profile-edit-btn:hover {
                background: rgba(255, 255, 255, 0.25);
                border-color: rgba(255, 255, 255, 0.5);
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            }

            /* Profile Info Cards */
            .profile-info {
                background: rgba(255, 255, 255, 0.95);
                border-radius: 0 0 25px 25px;
                padding: 30px;
                color: #333;
                position: relative;
                z-index: 2;
            }

            .info-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 25px;
                margin-bottom: 30px;
            }

            .info-item {
                background: white;
                padding: 20px;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
                border-left: 4px solid #DAA520;
                transition: all 0.3s ease;
            }

            .info-item:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
            }

            .info-icon {
                color: #DAA520;
                font-size: 1.2rem;
                margin-bottom: 8px;
            }

            .info-label {
                font-size: 0.9rem;
                color: #666;
                margin-bottom: 5px;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .info-value {
                font-size: 1.1rem;
                font-weight: 600;
                color: #333;
                word-break: break-word;
            }

            .history-btn {
                background: linear-gradient(135deg, #DAA520, #B8860B);
                border: none;
                color: white;
                padding: 15px 30px;
                border-radius: 25px;
                font-weight: 600;
                font-size: 1.1rem;
                width: 100%;
                transition: all 0.3s ease;
                box-shadow: 0 5px 15px rgba(218, 165, 32, 0.3);
            }

            .history-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(218, 165, 32, 0.4);
                background: linear-gradient(135deg, #B8860B, #DAA520);
            }

            .status-unknown {
                color: gray;
                font-weight: bold;
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
                background: #ffffff;
                border-radius: 15px;
                border: 2px solid #DAA520;
                color: #000000;
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
                color: #ffffff;
                font-family: 'Playfair Display', serif;
                font-size: 1.5rem;
            }

            #historyTableModal .btn-close {
                filter: brightness(0) invert(1);
            }

            #historyTableModal .modal-body {
                padding: 30px;
                background: #ffffff;
            }

            #historyTableModal .table {
                color: #000000;
                margin-bottom: 0;
                border-collapse: separate;
                border-spacing: 0;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            #historyTableModal .table thead th {
                background: linear-gradient(135deg, #DAA520, #B8860B);
                color: #ffffff;
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
                background-color: #f8f9fa;
            }

            #historyTableModal .table tbody tr:hover {
                background-color: #fff3cd;
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

            /* Footer Styles */
            .footer {
                background: rgba(29, 29, 27, 0.95);
                backdrop-filter: blur(10px);
                color: #f5f5f5;
                padding: 40px 0;
                margin-top: 60px;
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
                width: 120px;
                margin-bottom: 20px;
                filter: brightness(1.2);
            }

            .footer-title {
                font-size: 1.2rem;
                font-weight: 600;
                color: #DAA520;
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
                color: #DAA520;
            }

            .footer-contact p {
                color: #cccccc;
                margin-bottom: 8px;
                display: flex;
                align-items: flex-start;
            }

            .footer-contact i {
                margin-right: 10px;
                color: #DAA520;
                font-size: 1.1em;
                flex-shrink: 0;
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
                
                .profile-card {
                    margin: 0 10px;
                }
                
                .profile-header {
                    padding: 30px 20px 20px;
                }
                
                .profile-name {
                    font-size: 1.5rem;
                }
                
                .info-grid {
                    grid-template-columns: 1fr;
                    gap: 15px;
                }
                
                .info-item {
                    padding: 15px;
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
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <jsp:include page="/views/common/navbar.jsp"/>

        <div class="container mt-5">
            <h2 class="section-title">Thông tin cá nhân</h2>

            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">
                    <div class="profile-card">
                        <div class="profile-header">
                            <div class="profile-avatar">
                                <c:choose>
                                    <c:when test="${sessionScope.customer.role == 'Staff' && not empty sessionScope.customer.img}">
                                        <img src="${pageContext.request.contextPath}/${sessionScope.customer.img}" alt="Profile Picture">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-user"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="profile-name">
                                ${sessionScope.customer.lastName} ${sessionScope.customer.firstName}
                            </div>
                            <div class="profile-role">
                                <c:choose>
                                    <c:when test="${sessionScope.customer.role == 'Staff'}">
                                        Nhân viên
                                    </c:when>
                                    <c:otherwise>
                                        Khách hàng
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <a href="${pageContext.request.contextPath}/views/common/editProfile.jsp" class="profile-edit-btn">
                                <i class="fas fa-edit me-2"></i>Chỉnh sửa thông tin
                            </a>
                        </div>
                        
                        <div class="profile-info">
                            <div class="info-grid">
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div class="info-label">Họ và tên</div>
                                    <div class="info-value">${sessionScope.customer.lastName} ${sessionScope.customer.firstName}</div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="fas fa-envelope"></i>
                                    </div>
                                    <div class="info-label">Email</div>
                                    <div class="info-value">${sessionScope.customer.email}</div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="fas fa-phone"></i>
                                    </div>
                                    <div class="info-label">Số điện thoại</div>
                                    <div class="info-value">${sessionScope.customer.phoneNumber}</div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="fas fa-map-marker-alt"></i>
                                    </div>
                                    <div class="info-label">Số đơn đã đặt</div>
                                    <div class="info-value">${quantityAppointment}</div>
                                </div>
                            </div>
                            
                            <button id="showHistoryModalBtn" class="history-btn" data-bs-toggle="modal" data-bs-target="#historyTableModal">
                                <i class="fas fa-history me-2"></i>Lịch sử đặt lịch
                            </button>
                        </div>
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
                            <table class="table" id="historyTable" style="display: none;">
                                <thead>
                                    <tr>
                                        <th>Thời gian</th>
                                        <th>Dịch vụ</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Nhân viên</th>
                                        <th>Chi nhánh</th>
                                        <th>Thao tác</th>
                                        <th>Thanh toán còn lại</th>
                                    </tr>
                                </thead>
                                <tbody>
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

        <%@ include file="/views/common/footer.jsp" %>
        

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
</html>
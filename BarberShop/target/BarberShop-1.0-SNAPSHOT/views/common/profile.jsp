<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    if (session.getAttribute("firstName") == null || session.getAttribute("account") == null) {
        response.sendRedirect(request.getContextPath() + "/profile");
        return;
    }
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
</head>
<body>
    <c:if test="${not empty message}">
<<<<<<< Updated upstream
    <div class="alert alert-success">${message}</div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>
=======
        <div class="alert alert-success">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <%-- Hiển thị errorMessage từ Servlet nếu có (ví dụ: chưa đăng nhập) --%>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <%-- Hiển thị thông báo gửi feedback thành công nếu có msg=success --%>
    <c:if test="${param.msg == 'success'}">
        <div class="alert alert-success alert-dismissible fade show mx-auto text-center" id="feedbackAlert" style="max-width: 400px;">
            <strong><i class="fas fa-check-circle"></i> Thành công!</strong> Gởi feedback thành công
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <%-- Hiển thị thông báo gửi feedback thất bại nếu có msg=error --%>
    <c:if test="${param.msg == 'error'}">
        <div class="alert alert-danger alert-dismissible fade show mx-auto text-center" id="feedbackAlert" style="max-width: 400px;">
            <strong><i class="fas fa-times-circle"></i> Thất bại!</strong> Gởi feedback thất bại. Vui lòng thử lại!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

>>>>>>> Stashed changes
    <jsp:include page="/views/common/navbar.jsp"/>
    <div class="container mt-5">
        <h2 class="section-title">Thông tin cá nhân</h2>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>
       
        <div class="service-card shadow-sm">
            <div class="service-info">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <a href="${pageContext.request.contextPath}/views/common/editProfile.jsp" class="btn btn-primary">
                        <i class="fa fa-edit"></i> Chỉnh sửa thông tin
                    </a>
                </div>
                <div class="table-responsive">
                    <table class="table table-borderless">
                        <tbody>
                            <tr>
                                <td class="fw-bold" style="width: 150px;">Họ:</td>
                                <td>${sessionScope.lastName}</td>
                            </tr>
                            <tr>
                                <td class="fw-bold">Tên:</td>
                                <td>${sessionScope.firstName}</td>
                            </tr>
                            <tr>
                                <td class="fw-bold">Email:</td>
                                <td>${sessionScope.email}</td>
                            </tr>
                            <tr>
                                <td class="fw-bold">Số điện thoại:</td>
                                <td>${sessionScope.phoneNumber}</td>
                            </tr>
                            <!-- ✅ SỬA: Kiểm tra role chính xác (có thể là 'Staff' hoặc 'staff') -->
                            <c:if test="${sessionScope.account.role == 'Staff' || sessionScope.account.role == 'staff'}">
                                <tr>
                                    <td class="fw-bold">Ảnh:</td>
                                    <td>
                                        <c:if test="${not empty sessionScope.img}">
                                            <img src="${pageContext.request.contextPath}/${sessionScope.img}" alt="Staff Image" width="100">
                                        </c:if>
                                        <c:if test="${empty sessionScope.img}">
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
<<<<<<< Updated upstream
                                             
=======
                                        
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
                                    <th>Feedback</th>
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

>>>>>>> Stashed changes
<footer class="footer">
    <div class="container">
        <div class="row">
            <!-- Logo and About -->
            <div class="col-lg-4 col-md-6 footer-col">
                <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Cut&Styles Logo" class="footer-logo">                      
            </div>

            <!-- Links -->
            <div class="col-lg-4 col-md-6 footer-col">
                <h4 class="footer-title">Liên kết nhanh</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/common/franchise.jsp">Liên hệ nhượng quyền</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/commit/details.jsp">Chính sách cam kết</a></li>
                </ul>
            </div>

            <!-- Contact -->
            <div class="col-lg-4 col-md-6 footer-col">
                <h4 class="footer-title">Thông tin liên hệ</h4>
                <div class="footer-contact">
                    <p><i class="bi bi-geo-alt-fill"></i> <span>Khu đô thị FPT city, Hòa Hải, Ngũ Hành Sơn, Đà Nẵng</span></p>
                    <p><i class="bi bi-telephone-fill"></i> <span>Liên hệ học nghề tóc: 0774511941</span></p>
                    <p><i class="bi bi-clock-fill"></i> <span>Giờ phục vụ: Thứ 2 đến Chủ Nhật, 8h30 - 20h30</span></p>
                </div>
            </div>
        </div>

        <!-- Footer bottom -->
        <div class="row footer-bottom">
            <div  class="col-12 text-center">
                <p>&copy; 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
            </div>
        </div>
    </div>
</footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<<<<<<< Updated upstream
</body>
</html>
=======
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const showHistoryModalBtn = document.getElementById('showHistoryModalBtn');
            const historyTableBody = document.querySelector('#historyTable tbody');
            const historyTable = document.getElementById('historyTable');
            const noHistoryMessage = document.getElementById('noHistoryMessage');

            showHistoryModalBtn.addEventListener('click', function() {
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
                                
                                const statusCell = row.insertCell();
                                const statusSpan = document.createElement('span');
                                statusSpan.textContent = appointment.status;
                                statusSpan.className = getStatusClass(appointment.status);
                                statusCell.appendChild(statusSpan);
                                
                                row.insertCell().textContent = appointment.staffName; 
                                row.insertCell().textContent = appointment.branchName;
                                
                                // Add cancel button cell
                                const actionCell = row.insertCell();
                                const canCancel = appointment.status === 'Pending' || appointment.status === 'Confirmed';
                                
                                if (canCancel) {
                                    const cancelBtn = document.createElement('button');
                                    cancelBtn.className = 'btn btn-cancel';
                                    cancelBtn.innerHTML = '<i class="fas fa-times me-1"></i>Hủy';
                                    cancelBtn.onclick = function() {
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

                                const feedbackCell = row.insertCell();
                                if (appointment.status === 'Completed') {
                                    // Tạo form chuyển sang feedback.jsp, truyền customerId, staffId, appointmentId
                                    const feedbackForm = document.createElement('form');
                                    feedbackForm.action = '${pageContext.request.contextPath}/views/common/feedback.jsp';
                                    feedbackForm.method = 'get';
                                    feedbackForm.style.display = 'flex';
                                    feedbackForm.style.flexDirection = 'column';
                                    feedbackForm.style.alignItems = 'center';
                                    // Tiêu đề Feedback
                                    const feedbackLabel = document.createElement('span');
                                    feedbackLabel.textContent = 'Feedback';
                                    feedbackLabel.style.fontWeight = 'bold';
                                    feedbackLabel.style.marginBottom = '4px';
                                    feedbackForm.appendChild(feedbackLabel);
                                    // Hidden input
                                    const inputCustomer = document.createElement('input');
                                    inputCustomer.type = 'hidden';
                                    inputCustomer.name = 'customerId';
                                    inputCustomer.value = appointment.customerId || '${sessionScope.customer.id}';
                                    feedbackForm.appendChild(inputCustomer);
                                    const inputStaff = document.createElement('input');
                                    inputStaff.type = 'hidden';
                                    inputStaff.name = 'staffId';
                                    inputStaff.value = appointment.staffId || '';
                                    feedbackForm.appendChild(inputStaff);
                                    const inputAppointment = document.createElement('input');
                                    inputAppointment.type = 'hidden';
                                    inputAppointment.name = 'appointmentId';
                                    inputAppointment.value = appointment.id;
                                    feedbackForm.appendChild(inputAppointment);
                                    // Nút gửi feedback
                                    const feedbackBtn = document.createElement('button');
                                    feedbackBtn.type = 'submit';
                                    feedbackBtn.className = 'btn btn-primary';
                                    feedbackBtn.style.marginTop = '4px';
                                    feedbackBtn.textContent = 'Gửi Feedback';
                                    feedbackForm.appendChild(feedbackBtn);
                                    feedbackCell.appendChild(feedbackForm);
                                } else {
                                    feedbackCell.textContent = '-';
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
                switch(status) {
                    case 'Pending': return 'status-pending';
                    case 'Confirmed': return 'status-confirmed';
                    case 'Completed': return 'status-completed';
                    case 'Cancelled': return 'status-cancelled';
                    default: return 'status-unknown';
                }
            }

            // Hàm định dạng ngày giờ
            function formatDateTime(isoString) {
                if (!isoString) return '';
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
                return numAmount.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
            }

            window.addEventListener('DOMContentLoaded', function() {
                var alert = document.getElementById('feedbackAlert');
                if (alert) {
                    setTimeout(function() {
                        // Sử dụng Bootstrap để fade out alert
                        alert.classList.remove('show');
                        alert.classList.add('fade');
                        setTimeout(function() {
                            if (alert.parentNode) alert.parentNode.removeChild(alert);
                        }, 500); // Đợi hiệu ứng fade out
                    }, 1500);
                }
            });
        });
    </script>
</body>
>>>>>>> Stashed changes

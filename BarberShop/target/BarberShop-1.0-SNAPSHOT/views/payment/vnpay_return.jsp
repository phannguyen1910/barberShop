<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả thanh toán - Cut&Styles Barber</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/emailjs-com@3.2.0/dist/email.min.js"></script>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
            padding: 50px;
        }
        .card {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        .icon {
            font-size: 60px;
            margin-bottom: 20px;
        }
        .success {
            color: #2ecc71;
        }
        .fail {
            color: #e74c3c;
        }
        h2 {
            color: #333;
            font-family: 'Playfair Display', serif;
        }
        p {
            color: #666;
            font-size: 16px;
        }
        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            border-radius: 5px;
        }
        .btn-primary {
            background-color: #ffd700;
            color: #1a1a1a;
            border: none;
        }
        .btn-primary:hover {
            background-color: #e6c200;
        }
        .alert {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            max-width: 400px;
            padding: 1rem;
            border-radius: 8px;
        }
        .alert-danger {
            background: #e74c3c;
            color: white;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <%@ include file="/views/common/navbar.jsp" %>

    <div class="card">
        <c:choose>
            <c:when test="${transResult == true}">
                <div class="text-center">
                    <i class="fas fa-check-circle icon success"></i>
                    <h2>Thanh toán thành công!</h2>
                    <p>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi. Thông tin lịch hẹn đã được gửi đến email của bạn.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center">
                    <i class="fas fa-times-circle icon fail"></i>
                    <h2>Thanh toán thất bại!</h2>
                    <p>Đã xảy ra lỗi: ${error != null ? error : 'Vui lòng thử lại hoặc liên hệ qua hotline 0774511941.'}</p>
                </div>
            </c:otherwise>
        </c:choose>

        <a href="${pageContext.request.contextPath}/views/common/home.jsp" class="btn btn-primary">← Trở về trang chủ</a>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-container">
            <div>
                <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Cut&Styles Logo" class="footer-logo">
            </div>
            <div>
                <h4 class="footer-title">Liên kết nhanh</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/common/franchise.jsp">Liên hệ nhượng quyền</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/commit/support.jsp">Chính sách cam kết</a></li>
                </ul>
            </div>
            <div>
                <h4 class="footer-title">Thông tin liên hệ</h4>
                <div class="footer-contact">
                    <p><i class="bi bi-geo-alt-fill"></i> Khu đô thị FPT city, Hòa Hải, Ngũ Hành Sơn, Đà Nẵng</p>
                    <p><i class="bi bi-telephone-fill"></i> Liên hệ học nghề tóc: 0774511941</p>
                    <p><i class="bi bi-clock-fill"></i> Giờ phục vụ: Thứ 2 đến Chủ Nhật, 8h30 - 20h30</p>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
        </div>
    </footer>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Khởi tạo EmailJS
            emailjs.init("YOUR_EMAILJS_USER_ID"); // Thay bằng User ID của bạn

            // Gửi email thông báo nếu thanh toán thành công
            <c:if test="${transResult == true && not empty appointment}">
                const services = [
                    <c:forEach var="service" items="${services}" varStatus="loop">
                        "${service.name}"<c:if test="${not loop.last}">, </c:if>
                    </c:forEach>
                ].join(", ");
                const templateParams = {
                    toEmail: "${customerEmail}",
                    customer_name: "${customerName}",
                    appointment_id: "${appointment.id}",
                    staff_name: "${staffName}",
                    branch_name: "${branchName}",
                    appointment_date: "<fmt:formatDate value='${appointment.dateTime}' pattern='dd/MM/yyyy' />",
                    appointment_time: "<fmt:formatDate value='${appointment.dateTime}' pattern='HH:mm' />",
                    service_name: services,
                    total_amount: "<fmt:formatNumber value='${appointment.totalAmount}' type='number' groupingUsed='true' /> VNĐ",
                    payment_type: "${paymentType == 'final' ? 'Thanh toán toàn bộ' : 'Đặt cọc'}",
                    appointment_time_created: new Date().toLocaleString('vi-VN')
                };

                emailjs.send("YOUR_SERVICE_ID", "YOUR_TEMPLATE_ID", templateParams)
                    .then(function (response) {
                        console.log("Email sent:", response);
                    })
                    .catch(function (error) {
                        console.error("Email sending failed:", error);
                        const alertHtml = `
                            <div class="alert alert-danger">
                                <i class="bi bi-exclamation-triangle"></i> Lỗi gửi email xác nhận. Vui lòng liên hệ qua hotline 0774511941.
                            </div>
                        `;
                        document.body.insertAdjacentHTML('beforeend', alertHtml);
                        setTimeout(() => {
                            const alert = document.querySelector('.alert');
                            if (alert) alert.remove();
                        }, 5000);
                    });
            </c:if>
        });
    </script>
</body>
</html>
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

 

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Khởi tạo EmailJS
            emailjs.init("ERXsjxf2H9KyqK2hi"); // Thay bằng User ID của bạn

            // Log để debug
            console.log("transResult:", "${transResult}");
            console.log("customerEmail:", "${customerEmail}");
            console.log("staffFullName:", "${staffFullName}");
            console.log("selectedBranchName:", "${selectedBranchName}");
            console.log("appointmentTime:", "${appointmentTime}");
            console.log("serviceNamesList:", "${serviceNamesList}");
            console.log("selectedTotalPrice:", "${selectedTotalPrice}");
   

            // Gửi email thông báo nếu thanh toán thành công
            <c:if test="${transResult == true}">
                // Kiểm tra dữ liệu trước khi gửi
                if (!"${customerEmail}"|| !"${staffFullName}" || 
                    !"${selectedBranchName}" || !"${appointmentTime}" || !"${serviceNamesList}" || 
                    !"${selectedTotalPrice}") {
                    console.error("Lỗi: Thiếu dữ liệu để gửi email.");
                    const alertHtml = `
                        <div class="alert alert-danger">
                            <i class="bi bi-exclamation-triangle"></i> Lỗi gửi email xác nhận do thiếu dữ liệu. Vui lòng liên hệ qua hotline 0774511941.
                        </div>
                    `;
                    document.body.insertAdjacentHTML('beforeend', alertHtml);
                    setTimeout(() => {
                        const alert = document.querySelector('.alert');
                        if (alert) alert.remove();
                    }, 5000);
                    return;
                }

                const templateParams = {
                    to_email: "${customerEmail}",
                    staff_name: "${staffFullName}",
                    branch_name: "${selectedBranchName}",
                    appointment_time: new Date("${appointmentTime}").toLocaleString('vi-VN', { 
                        day: '2-digit', 
                        month: '2-digit', 
                        year: 'numeric', 
                        hour: '2-digit', 
                        minute: '2-digit' 
                    }),
                    service_name: "${serviceNamesList}",
                    total_amount: new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(${selectedTotalPrice}),
                    appointment_time_created: new Date().toLocaleString('vi-VN')
                };

                console.log("Template Params:", templateParams);

                emailjs.send("service_sy1vkhc", "template_5izwd4m", templateParams)
                    .then(function (response) {
                        console.log("Email sent successfully:", response);
                    })
                    .catch(function (error) {
                        console.error("Email sending failed:", error);
                        const alertHtml = `
                            <div class="alert alert-danger">
                                <i class="bi bi-exclamation-triangle"></i> Lỗi gửi email xác nhận: ${error.text || 'Không xác định'}. Vui lòng liên hệ qua hotline 0774511941.
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
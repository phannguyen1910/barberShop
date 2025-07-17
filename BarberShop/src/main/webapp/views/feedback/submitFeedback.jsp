<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gửi Phản hồi - Barbershop</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
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

        .custom-navbar {
            background: rgba(29, 29, 27, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 2px solid rgba(218, 165, 32, 0.3);
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

        .container {
            max-width: 600px;
            margin: 100px auto;
            padding: 30px;
            background: rgba(29, 29, 27, 0.9);
            border-radius: 15px;
            border: 1px solid rgba(218, 165, 32, 0.2);
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

        .btn-primary {
            background: linear-gradient(45deg, #DAA520, #B8860B);
            color: #1d1d1b;
            font-weight: 600;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(218, 165, 32, 0.4);
        }

        .btn-secondary {
            background: rgba(218, 165, 32, 0.1);
            color: #DAA520;
            border: 1px solid rgba(218, 165, 32, 0.3);
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: rgba(218, 165, 32, 0.2);
        }

        .alert {
            background: rgba(218, 165, 32, 0.1);
            color: #DAA520;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg custom-navbar border-bottom shadow-sm">
        <div class="container-fluid px-4">
            <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Logo" width="55" height="55" class="me-2">
            </a>
            <div class="collapse navbar-collapse justify-content-end">
                <div class="d-flex gap-2 align-items-center">
                    <div class="text-warning d-none d-lg-block me-3">
                        <i class="fas fa-user me-1"></i>
                        <span>${sessionScope.customer.firstName} ${sessionScope.customer.lastName}</span>
                    </div>
                    <a class="btn btn-warning" href="${pageContext.request.contextPath}/logout" onclick="return confirm('Bạn có chắc chắn muốn đăng xuất?')">
                        <i class="fas fa-sign-out-alt me-1"></i>
                        Đăng xuất
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container">
        <h1 class="text-center mb-4" style="color: #DAA520;"><i class="fas fa-comments"></i> Gửi Phản hồi</h1>
        <div id="alertMessage" class="alert"></div>
        <form id="feedbackForm" action="${pageContext.request.contextPath}/FeedbackServlet" method="post">
            <div class="form-group">
                <label>Mã lịch hẹn</label>
                <input type="text" name="appointmentId" class="form-control" placeholder="Nhập mã lịch hẹn" required>
            </div>
            <div class="form-group">
                <label>Đánh giá sao</label>
                <select name="rating" class="form-control" required>
                    <option value="1">1 Sao</option>
                    <option value="2">2 Sao</option>
                    <option value="3">3 Sao</option>
                    <option value="4">4 Sao</option>
                    <option value="5">5 Sao</option>
                </select>
            </div>
            <div class="form-group">
                <label>Phản hồi</label>
                <textarea name="comment" class="form-control" rows="5" placeholder="Nhập phản hồi của bạn" required></textarea>
            </div>
            <div class="form-group text-center">
                <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Gửi phản hồi</button>
                <button type="button" class="btn btn-secondary" onclick="resetForm()">Hủy</button>
            </div>
        </form>
    </div>

    <script>
        function resetForm() {
            document.getElementById('feedbackForm').reset();
            document.getElementById('alertMessage').style.display = 'none';
        }

        // Check for success message from servlet
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('success') === 'true') {
            const alertMessage = document.getElementById('alertMessage');
            alertMessage.textContent = 'Phản hồi đã được gửi thành công!';
            alertMessage.style.display = 'block';
            setTimeout(() => { alertMessage.style.display = 'none'; }, 3000);
        } else if (urlParams.get('error')) {
            const alertMessage = document.getElementById('alertMessage');
            alertMessage.textContent = 'Có lỗi xảy ra khi gửi phản hồi. Vui lòng thử lại.';
            alertMessage.style.display = 'block';
            setTimeout(() => { alertMessage.style.display = 'none'; }, 3000);
        }
    </script>
</body>
</html>
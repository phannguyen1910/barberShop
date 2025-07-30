<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Profile - Cut&Styles Barber</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/editprofile.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <script>
            function validateForm() {
                const action = document.querySelector('button[type="submit"]:focus').value;
                const phoneNumber = document.getElementById("phoneNumber").value;
                const currentPassword = document.getElementById("currentPassword").value;
                const newPassword = document.getElementById("newPassword").value;
                const confirmPassword = document.getElementById("confirmPassword").value;
                const errorDiv = document.getElementById("formError");

                if (action === "updateProfile") {
                    // Validation cho số điện thoại
                    const phonePattern = /^[0-9]{10,15}$/;
                    if (phoneNumber && !phonePattern.test(phoneNumber)) {
                        errorDiv.innerText = "Số điện thoại phải chứa 10-15 chữ số.";
                        return false;
                    }
                } else if (action === "changePassword") {
                    // Validation cho mật khẩu
                    if (!currentPassword || !newPassword || !confirmPassword) {
                        errorDiv.innerText = "Vui lòng nhập đầy đủ thông tin mật khẩu.";
                        return false;
                    }
                    if (newPassword !== confirmPassword) {
                        errorDiv.innerText = "Mật khẩu mới và xác nhận mật khẩu không khớp.";
                        return false;
                    }
                    if (newPassword.length < 6) {
                        errorDiv.innerText = "Mật khẩu mới phải có ít nhất 6 ký tự.";
                        return false;
                    }
                }
                errorDiv.innerText = "";
                return true;
            }
        </script>
    </head>

    <body>
        <jsp:include page="/views/common/navbar.jsp"/>
        <div class="container mt-5">
            <h2 class="section-title text-center mb-4">Chỉnh sửa thông tin cá nhân</h2>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <div class="service-card shadow-sm">
                <div class="service-info">
                    <form action="${pageContext.request.contextPath}/EditProfileServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm()" autocomplete="off">
                        
                        <div class="mb-3">
                            <label for="firstName" class="form-label">Tên</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" value="${sessionScope.firstName}" required>
                        </div>
                        <div class="mb-3">
                            <label for="lastName" class="form-label">Họ</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" value="${sessionScope.lastName}" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${sessionScope.email}" required>
                        </div>
                        <div class="mb-3">
                            <label for="phoneNumber" class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${sessionScope.phoneNumber}">
                        </div>
                        <c:if test="${sessionScope.account.role == 'Staff'}">
                            <div class="mb-3">
                                <label for="img" class="form-label">Ảnh (chỉ dành cho nhân viên)</label>
                                <input type="file" class="form-control" id="img" name="img" accept="image/*">
                                <c:if test="${not empty sessionScope.img}">
                                    <img src="${pageContext.request.contextPath}/${sessionScope.img}" alt="Current Staff Image" width="100" class="mt-2">
                                </c:if>
                            </div>
                        </c:if>
                        <!-- Form thay đổi mật khẩu -->
                        <h5 class="mt-4">Thay đổi mật khẩu</h5>
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">Mật khẩu hiện tại</label>
                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" autocomplete="new-password">
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Mật khẩu mới</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword">
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                        </div>
                        <div class="text-center">
                            <button type="submit" name="action" value="updateProfile" class="btn btn-primary">Lưu thay đổi hồ sơ</button>
                            <button type="submit" name="action" value="changePassword" class="btn btn-primary">Thay đổi mật khẩu</button>
                            <a href="${pageContext.request.contextPath}/profile" class="btn btn-secondary">Hủy</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

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
    </body>
</html>
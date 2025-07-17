<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cut&Styles Barber - Đăng ký</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/register.css">  
        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>
        <div class="register-container">
            <div class="scissor-icon scissor-1">✂️</div>
            <div class="scissor-icon scissor-2">✂️</div>

            <div class="logo">
                <h1>Cut&<span>Styles</span></h1>
                <p>PREMIUM BARBER SHOP</p>
            </div>

            <form action="register" method="post" id="registerForm">
                <div class="form-columns">
                    <div class="form-group">
                        <label for="firstName">Họ</label>
                        <i class="fas fa-user"></i>
                        <input type="text" id="firstName" name="firstName" placeholder="Nhập họ của bạn" required>
                    </div>

                    <div class="form-group">
                        <label for="lastName">Tên</label>
                        <i class="fas fa-user"></i>
                        <input type="text" id="lastName" name="lastName" placeholder="Nhập tên của bạn" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="phone">Số điện thoại</label>
                    <i class="fas fa-phone"></i>
                    <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại" required>
                </div>


                <div class="form-group">
                    <label for="email">Email</label>
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" name="email" placeholder="Nhập địa chỉ email" required>
                </div>


                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" placeholder="Tạo mật khẩu" required 
                           onkeyup="checkPasswordStrength()">
                    <i class="fas fa-eye toggle-password" onclick="togglePassword('password')"></i>

                    <div class="password-requirements">
                        <p>Mật khẩu phải có:</p>
                        <ul>
                            <li id="length"><i class="far fa-circle"></i> Ít nhất 8 ký tự</li>
                            <li id="uppercase"><i class="far fa-circle"></i> Ít nhất 1 chữ cái viết hoa</li>
                            <li id="lowercase"><i class="far fa-circle"></i> Ít nhất 1 chữ cái viết thường</li>
                            <li id="number"><i class="far fa-circle"></i> Ít nhất 1 số</li>
                        </ul>
                    </div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu</label>
                    <i class="fas fa-lock"></i>
                    <input type="password" id="confirmPassword" name="confirmPassword" 
                           placeholder="Nhập lại mật khẩu" required onkeyup="checkPasswordMatch()">
                    <i class="fas fa-eye toggle-password" onclick="togglePassword('confirmPassword')"></i>
                </div>

                <div class="terms">
                    <input type="checkbox" id="terms" name="terms" required>
                    <label for="terms">Tôi đồng ý với <a href="terms.jsp">Điều khoản dịch vụ</a> và <a href="privacy.jsp">Chính sách bảo mật</a> của Cut&Styles Barber</label>
                </div>

                <button type="submit" class="register-btn" id="registerBtn">Đăng ký</button>

                <div class="login-link">
                    Bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập ngay</a>
                </div>
            </form>
        </div>

        <script>
            function togglePassword(inputId) {
                const passwordInput = document.getElementById(inputId);
                const toggleIcon = passwordInput.nextElementSibling;

                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    toggleIcon.classList.remove('fa-eye');
                    toggleIcon.classList.add('fa-eye-slash');
                } else {
                    passwordInput.type = 'password';
                    toggleIcon.classList.remove('fa-eye-slash');
                    toggleIcon.classList.add('fa-eye');
                }
            }

            function checkPasswordStrength() {
                const password = document.getElementById('password').value;

                if (password.length >= 8) {
                    document.getElementById('length').innerHTML = '<i class="fas fa-check-circle" style="color: #4CAF50;"></i> Ít nhất 8 ký tự';
                } else {
                    document.getElementById('length').innerHTML = '<i class="far fa-circle"></i> Ít nhất 8 ký tự';
                }

                if (/[A-Z]/.test(password)) {
                    document.getElementById('uppercase').innerHTML = '<i class="fas fa-check-circle" style="color: #4CAF50;"></i> Ít nhất 1 chữ cái viết hoa';
                } else {
                    document.getElementById('uppercase').innerHTML = '<i class="far fa-circle"></i> Ít nhất 1 chữ cái viết hoa';
                }

                if (/[a-z]/.test(password)) {
                    document.getElementById('lowercase').innerHTML = '<i class="fas fa-check-circle" style="color: #4CAF50;"></i> Ít nhất 1 chữ cái viết thường';
                } else {
                    document.getElementById('lowercase').innerHTML = '<i class="far fa-circle"></i> Ít nhất 1 chữ cái viết thường';
                }

                if (/[0-9]/.test(password)) {
                    document.getElementById('number').innerHTML = '<i class="fas fa-check-circle" style="color: #4CAF50;"></i> Ít nhất 1 số';
                } else {
                    document.getElementById('number').innerHTML = '<i class="far fa-circle"></i> Ít nhất 1 số';
                }

                checkPasswordMatch();
            }

            function checkPasswordMatch() {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

                if (confirmPassword === '') {
                    return;
                }

                if (password === confirmPassword) {
                    document.getElementById('confirmPassword').style.borderColor = '#4CAF50';
                    document.getElementById('confirmPassword').style.boxShadow = '0 0 0 3px rgba(76, 175, 80, 0.2)';
                } else {
                    document.getElementById('confirmPassword').style.borderColor = '#f44336';
                    document.getElementById('confirmPassword').style.boxShadow = '0 0 0 3px rgba(244, 67, 54, 0.2)';
                }
            }

            document.getElementById('registerForm').addEventListener('submit', function (e) {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const terms = document.getElementById('terms').checked;

                const isStrong = password.length >= 8 &&
                        /[A-Z]/.test(password) &&
                        /[a-z]/.test(password) &&
                        /[0-9]/.test(password);

                const isMatch = password === confirmPassword;

                if (!isStrong || !isMatch || !terms) {
                    e.preventDefault();

                    if (!isStrong) {
                        alert('Vui lòng tạo mật khẩu đủ mạnh theo yêu cầu.');
                    } else if (!isMatch) {
                        alert('Mật khẩu xác nhận không khớp.');
                    } else if (!terms) {
                        alert('Bạn cần đồng ý với Điều khoản dịch vụ và Chính sách bảo mật.');
                    }
                }
            });
        </script>
    </body>
</html>
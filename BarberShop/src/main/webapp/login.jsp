<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cut&Styles Barber - Đăng nhập</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/login.css"> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>
        <%
            String savedUsername = "";
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("username")) {
                        savedUsername = cookie.getValue();
                    }
                }
            }
            String errorMes = (String) request.getAttribute("errorMes");
            String username = (String) request.getAttribute("username");
        %>
        <div class="login-container">
            <div class="scissor-icon scissor-1">✂️</div>
            <div class="scissor-icon scissor-2">✂️</div>

            <div class="logo">
                <h1>Cut&<span>Styles</span></h1>
                <p>PREMIUM BARBER SHOP</p>
            </div>
            <!-- Form đăng nhập -->
            <form class="login-form" action="login" method="post">
                <div class="form-group">
                    <label for="username">Email</label>
                    <i class="fas fa-user"></i>
                    <input type="text" id="username" name="username" required value="<%= username != null ? username : (savedUsername != null ? savedUsername : "")%>">
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" required>
                    <i class="fas fa-eye toggle-password" onclick="togglePassword()"></i>
                </div>

                <!-- Display message if login fail -->
                <span style="color:red;"><%= errorMes != null ? errorMes : ""%></span>

                <div class="form-footer">
                    <div class="checkbox">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">Ghi nhớ đăng nhập</label>
                    </div>
                    <a href="${pageContext.request.contextPath}/views/auth/forgot-password.jsp" class="forgot-link">Quên mật khẩu?</a>
                </div>

                <button type="submit" class="login-btn">Đăng nhập</button>

         <div class="social-login">
                    <p>Hoặc đăng nhập với</p>
                    <div class="social-icons">
                        <!-- Fixed: Removed space in redirect_uri and use consistent client_id -->
                        <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid&redirect_uri=http://localhost:8080/Cut_StyleBarber/login&response_type=code&client_id=205755126849-3i67q0ljfm9tea75ibskib9rnhat6ofd.apps.googleusercontent.com&approval_prompt=force"
                           class="social-icon google">
                            <i class="fab fa-google"></i>
                            <span>Đăng nhập với Google</span>
                        </a>
                    </div>
                </div>

                <div class="register-link">
                    Bạn chưa có tài khoản? <a href="${pageContext.request.contextPath}/views/auth/register.jsp">Đăng ký ngay</a>         
                    <a href="${pageContext.request.contextPath}/views/common/home.jsp">Quay về trang chủ 🏠</a>
                </div>

            </form>
        </div>

     <script src="https://accounts.google.com/gsi/client" async defer></script>
    <script>
        window.onload = function () {
            google.accounts.id.initialize({
                client_id: "22042647871-2b6gsvrtpn5andptksj5mk4rpml9hdji.apps.googleusercontent.com",
                callback: handleCredentialResponse
            });

            google.accounts.id.renderButton(
                document.getElementById("google-signin-btn"),
                { theme: "outline", size: "large" } // Tùy chỉnh nút Google
            );
        };

        function handleCredentialResponse(response) {
            // Gửi ID token đến server để xử lý
            const idToken = response.credential;
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "${pageContext.request.contextPath}/google-callback", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    window.location.href = "${pageContext.request.contextPath}/views/common/home.jsp";
                }
            };
            xhr.send("id_token=" + idToken);
        }

        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.querySelector('.toggle-password');
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
    </script>
    </body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Enter OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: url('https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1374&q=80') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .otp-container {
            background: rgba(255, 245, 230, 0.95);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            max-width: 400px;
            width: 100%;
            border: 1px solid #d4a373;
        }
        h2, h3 {
            color: #333;
        }
        .input-group-text {
            background: #d4a373;
            color: #fff;
        }
        .form-control {
            border: 1px solid #d4a373;
            background: #fff;
        }
        .btn-primary {
            background: #d4a373;
            border: none;
            transition: background 0.3s ease;
        }
        .btn-primary:hover {
            background: #b8860b;
        }
        .btn-outline-primary {
            border-color: #d4a373;
            color: #d4a373;
            transition: all 0.3s ease;
        }
        .btn-outline-primary:hover {
            background: #d4a373;
            color: #fff;
        }
        #countdown-text {
            color: #ff6f61;
            font-weight: 500;
        }
        #resend-btn {
            display: none;
        }
        .text-danger {
            color: #ff6f61 !important;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="otp-container text-center">
        <h3><i class="fa fa-lock fa-3x text-primary"></i></h3>
        <h2 class="my-3">Enter OTP</h2>
        <% if (request.getAttribute("message") != null) { %>
            <p class="text-danger"><%= request.getAttribute("message") %></p>
        <% } %>
        <form action="${pageContext.request.contextPath}/validate-otp" method="post">
            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                    <input type="text" class="form-control" name="enteredOTP" placeholder="Enter OTP" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary w-100">Verify OTP</button>
        </form>
        <div class="mt-3">
            <p id="countdown-text">You can resend OTP after <span id="countdown"></span> s.</p>
            <button id="resend-btn" class="btn btn-outline-primary w-100" onclick="resendOTP()">
                <i class="fas fa-redo"></i> Resend OTP
            </button>
        </div>
    </div>

    <script>
        window.onload = function () {
            let lastOTPSentTime = <%= session.getAttribute("otpGeneratedTime") %>;
            if (!lastOTPSentTime) {
                window.location.href = "${pageContext.request.contextPath}/views/auth/forgot-password.jsp";
                return;
            }

            let elapsed = Math.floor((Date.now() - lastOTPSentTime) / 1000);
            let countdown = 60 - elapsed;

            const countdownText = document.getElementById("countdown-text");
            const countdownSpan = document.getElementById("countdown");
            const resendButton = document.getElementById("resend-btn");

            if (countdown > 0) {
                countdownSpan.innerText = countdown;
                let interval = setInterval(() => {
                    countdown--;
                    countdownSpan.innerText = countdown;
                    if (countdown <= 0) {
                        clearInterval(interval);
                        countdownText.style.display = "none";
                        resendButton.style.display = "block";
                    }
                }, 1000);
            } else {
                countdownText.style.display = "none";
                resendButton.style.display = "block";
            }
        };

        function resendOTP() {
            let btn = document.getElementById("resend-btn");
            btn.innerHTML = "Resending...";
            btn.disabled = true;
            window.location.href = 'resend-otp';
        }
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nhập số điện thoại</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                background-image: url('https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1374&q=80');
                background-size: cover;
                background-position: center;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            /* Hiệu ứng mờ cho nền */
            body::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5); /* Lớp phủ tối để làm nổi bật form */
                backdrop-filter: blur(5px); /* Hiệu ứng mờ */
            }

            .phone-container {
                position: relative;
                background-color: rgba(255, 255, 255, 0.95); /* Màu trắng trong suốt nhẹ */
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
                text-align: center;
                max-width: 400px;
                width: 90%;
                transition: transform 0.3s ease;
            }

            .phone-container:hover {
                transform: translateY(-5px); /* Hiệu ứng nổi lên khi hover */
            }

            .phone-container h2 {
                margin-bottom: 25px;
                font-size: 24px;
                color: #333;
                font-weight: 600;
            }

            .phone-container input[type="text"] {
                padding: 12px;
                margin-bottom: 20px;
                width: 100%;
                box-sizing: border-box;
                border: 2px solid #ddd;
                border-radius: 8px;
                font-size: 16px;
                transition: border-color 0.3s ease;
            }

            .phone-container input[type="text"]:focus {
                border-color: #4CAF50;
                outline: none;
            }

            .phone-container button {
                padding: 12px 30px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.1s ease;
            }

            .phone-container button:hover {
                background-color: #45a049;
                transform: scale(1.05); /* Hiệu ứng phóng to nhẹ khi hover */
            }

            .phone-container button:active {
                transform: scale(0.95); /* Hiệu ứng nhấn nút */
            }

            /* Responsive design */
            @media (max-width: 480px) {
                .phone-container {
                    padding: 20px;
                    width: 85%;
                }

                .phone-container h2 {
                    font-size: 20px;
                }

                .phone-container input[type="text"],
                .phone-container button {
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body>
        <div class="phone-container">
            <h2>Chào mừng bạn! Vui lòng nhập số điện thoại</h2>
            <form action="${pageContext.request.contextPath}/updatePhone" method="get">
                <input type="text" name="phoneNumber" placeholder="Nhập số điện thoại" required>
                <input type="hidden" name="email" value="${email}">
                <button type="submit">Xác nhận</button>
            </form>
        </div>
    </body>
</html>
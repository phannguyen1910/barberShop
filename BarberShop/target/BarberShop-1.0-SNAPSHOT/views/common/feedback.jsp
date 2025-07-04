<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gửi Feedback</title>
    <style>
        .feedback-container {
            max-width: 500px;
            margin: 40px auto;
            padding: 24px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background: #fafafa;
        }
        textarea {
            width: 100%;
            min-height: 100px;
            margin-bottom: 16px;
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #bbb;
            font-size: 16px;
        }
        button {
            padding: 8px 24px;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<div class="feedback-container">
    <h2>Gửi phản hồi dịch vụ</h2>
    <form action="${pageContext.request.contextPath}/addFeedback" method="post">
        <input type="hidden" name="customerId" value="${param.customerId}" />
        <input type="hidden" name="staffId" value="${param.staffId != null && param.staffId != '' ? param.staffId : '0'}" />
        <input type="hidden" name="appointmentId" value="${param.appointmentId}" />
        <input type="hidden" name="serviceId" value="${param.serviceId != null ? param.serviceId : '1'}" />
        <label for="comment">Nội dung phản hồi:</label><br>
        <textarea id="comment" name="comment" required placeholder="Nhập nội dung phản hồi..."></textarea><br>
        <label for="rating">Đánh giá sao:</label><br>
        <select id="rating" name="rating" required style="margin-bottom: 16px; width: 100%; padding: 8px; border-radius: 4px; border: 1px solid #bbb; font-size: 16px;">
            <option value="5">5 sao - Tuyệt vời</option>
            <option value="4">4 sao - Tốt</option>
            <option value="3">3 sao - Bình thường</option>
            <option value="2">2 sao - Chưa tốt</option>
            <option value="1">1 sao - Rất tệ</option>
        </select><br>
        <button type="submit">Gửi Feedback</button>
    </form>
</div>
</body>
</html> 
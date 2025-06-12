package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy session và hủy session hiện tại
        HttpSession session = request.getSession(false); // false: không tạo session mới nếu không có
        if (session != null) {
            // Hủy session
            session.invalidate();
        }

        // Redirect về trang đăng nhập hoặc trang chủ
        response.sendRedirect(request.getContextPath() + "/views/common/home.jsp");
    }

}

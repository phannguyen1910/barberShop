package controller;

import babershopDAO.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ban-customer")
public class BanCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean ban = Boolean.parseBoolean(request.getParameter("ban"));

            System.out.println("📥 Dữ liệu nhận được - ID: " + id + ", Ban: " + ban); // ✅ Log 1

            boolean success = CustomerDAO.banCustomer(id, ban);

            if (success) {
                System.out.println("✔ Đã cập nhật trạng thái cho tài khoản ID: " + id + " → status = " + (ban ? 0 : 1));
            } else {
                System.out.println("❌ Cập nhật thất bại cho tài khoản ID: " + id);
            }
        } catch (Exception e) {
            System.out.println("🔥 Lỗi trong servlet:");
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/view-customers");
    }


    // 👉 Hàm phụ trợ cập nhật status tài khoản
    private boolean updateAccountStatus(int accountId, int status) {
        String sql = "UPDATE Account SET status = ? WHERE id = ?";
        try (var con = CustomerDAO.getConnect(); var ps = con.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setInt(2, accountId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("🔥 ERROR when updating account status: " + e);
            return false;
        }
    }
}


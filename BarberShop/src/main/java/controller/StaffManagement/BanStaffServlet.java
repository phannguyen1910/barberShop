package controller.StaffManagement;

import babershopDAO.StaffDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/ban-staff")
@MultipartConfig
public class BanStaffServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int accountId = Integer.parseInt(request.getParameter("id"));
        boolean ban = Boolean.parseBoolean(request.getParameter("ban"));
        int newStatus = ban ? 0 : 1;

        boolean success = StaffDAO.banStaff(accountId, newStatus);

        response.setContentType("application/json");
        response.getWriter().print("{\"success\":" + success + ", \"newStatus\":" + newStatus + "}");
    }
}

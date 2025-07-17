
package controller.Authentication;

import babershopDAO.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/ChangePasswordServlet"})
public class ChangePasswordServlet extends HttpServlet {

 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChangePasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");

        try {
            AccountDAO accountDAO = new AccountDAO();
            String email = "kanekitv171@gmail.com";
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            response.getWriter().write(currentPassword);
            response.getWriter().write(newPassword);
            System.out.println("=== DEBUG INFO ===");
            System.out.println("Email: " + email);
            System.out.println("Current Password: " + currentPassword);
            System.out.println("New Password: " + newPassword);

            String result = accountDAO.changePassword(email, currentPassword, newPassword);
            System.out.println("Change password result: " + result);

            if (result != null) {
                request.setAttribute("errorMessage", result);
                System.out.println(result);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            } else {
                response.sendRedirect("profile.jsp");
            }

        } catch (Exception e) {
            System.err.println("Exception in ChangePasswordServlet:");
            e.printStackTrace();
            response.setStatus(500);
            response.getWriter().write("Lỗi server: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}

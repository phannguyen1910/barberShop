package controller;

import babershopDAO.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Staff;
import model.Admin;

/**
 *
 * @author Sekiro
 */
@WebServlet(name = "EditProfileServlet", urlPatterns = {"/EditProfileServlet"})
public class EditProfileServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        AccountDAO accountDAO = new AccountDAO();

        // Kiểm tra và gán giá trị mặc định nếu phoneNumber là null
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            phoneNumber = (String) session.getAttribute("phoneNumber"); // Lấy giá trị cũ
        }

        // Lấy accountId từ session, nếu không có thì dùng giá trị mặc định
        Integer accountId = (Integer) session.getAttribute("accountId");
        if (accountId == null) {
            accountId = 3; // Giá trị mặc định, cần thay bằng logic lấy từ session sau khi đăng nhập
        }

        // Cập nhật thông tin cá nhân
        String message = accountDAO.editProfile(accountId, firstName, lastName, phoneNumber);
        String role = accountDAO.checkRole(accountId);
        System.out.println("Message from editProfile: " + message);

        // Lưu thông tin vào session để sử dụng lại
        session.setAttribute("firstName", firstName);
        session.setAttribute("lastName", lastName);
        session.setAttribute("phoneNumber", phoneNumber);
        session.setAttribute("email", email);

        // Chuẩn bị dữ liệu để chuyển về profile.jsp
        request.setAttribute("message", message);
        if ("Change profile successful".equals(message)) {
            if ("Customer".equals(role)) {
                Customer customer = new Customer(email, phoneNumber, password, "Customer", 1, firstName, lastName);
                session.setAttribute("customer", customer);
                request.setAttribute("customer", customer);
            } else if ("Staff".equals(role)) {
                Staff staff = new Staff(firstName, lastName, email, phoneNumber, password, "Staff", 1);
                session.setAttribute("staff", staff);
                request.setAttribute("staff", staff);
            } else if ("Admin".equals(role)) {
                Admin admin = new Admin(1, firstName, lastName, email, phoneNumber, password, role, 1);
                session.setAttribute("admin", admin);
                request.setAttribute("admin", admin);
            }
        }

        // Chuyển hướng về profile.jsp
        request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
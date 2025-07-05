package controller.Authentication;

import babershopDAO.AccountDAO;
import babershopDAO.AdminDAO;
import babershopDAO.BranchDAO;
import babershopDAO.CustomerDAO;
import babershopDAO.StaffDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Customer;
import model.Staff;
import java.io.IOException;
import model.Admin;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null) {
            request.setAttribute("errorMessage", "Vui lòng đăng nhập để xem hồ sơ.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String role = account.getRole().toLowerCase(); // Chuẩn hóa role
            switch (role) {
                case "customer":
                    Customer customer = CustomerDAO.getCustomerByAccountId(account.getId());
                    if (customer != null) {
                        session.setAttribute("user", customer);
                        session.setAttribute("customer", customer); // Thêm customer vào session
                        session.setAttribute("firstName", customer.getFirstName());
                        session.setAttribute("lastName", customer.getLastName());
                        session.setAttribute("email", customer.getEmail());
                        session.setAttribute("phoneNumber", customer.getPhoneNumber());
                        session.removeAttribute("password");
            request.setAttribute("account", account);
            request.getRequestDispatcher("/views/common/profile.jsp").forward(request, response);
                    } else {
                        request.setAttribute("errorMessage", "Không tìm thấy thông tin khách hàng.");
                    }
                    break;
                case "staff":
                    Staff staff = StaffDAO.getStaffByAccountId(account.getId());
                    System.out.println(staff.getAccountId());
                    BranchDAO branchDAO = new BranchDAO();
                    String branchName = branchDAO.getBranchNameById(staff.getBranchId());
                    if (staff != null) {
                        session.setAttribute("user", staff);
                        session.setAttribute("staff", staff); // Thêm staff vào session
                        session.setAttribute("firstName", staff.getFirstName());
                        session.setAttribute("lastName", staff.getLastName());
                        session.setAttribute("email", staff.getEmail());
                        session.setAttribute("phoneNumber", staff.getPhoneNumber());
                        session.setAttribute("img", staff.getImg());
                        session.setAttribute("branchName", branchName);
                                 session.removeAttribute("password");
            request.setAttribute("account", account);
            request.getRequestDispatcher("/views/staff/profileOfStaff.jsp").forward(request, response);
                    } else {
                        request.setAttribute("errorMessage", "Không tìm thấy thông tin nhân viên.");
                    }
                    break;
                case "admin":
                    Admin admin = AdminDAO.getAdminByAccountId(account.getId());
                    if (admin != null) {
                        session.setAttribute("user", admin);
                        session.setAttribute("staff", admin); // Thêm staff vào session
                        session.setAttribute("firstName", admin.getFirstName());
                        session.setAttribute("lastName", admin.getLastName());
                        session.setAttribute("email", admin.getEmail());
                        session.setAttribute("phoneNumber", admin.getPhoneNumber());
                        session.setAttribute("account", account);
                    } else {
                        request.setAttribute("errorMessage", "Không tìm thấy thông tin nhân viên.");
                    }
                    break;
                    
                default:
                    request.setAttribute("errorMessage", "Vai trò không hợp lệ.");
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải thông tin hồ sơ: " + e.getMessage());
            request.getRequestDispatcher("/views/common/profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Chuyển POST sang doGet
    }

    @Override
    public String getServletInfo() {
        return "Profile Servlet for displaying Customer or Staff profile information";
    }
}
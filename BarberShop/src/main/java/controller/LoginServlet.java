package controller;

import babershopDAO.AccountDAO;
import babershopDAO.AdminDAO;
import babershopDAO.CustomerDAO;
import babershopDAO.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Admin;
import model.Customer;
import model.GoogleAccount;
import model.Staff;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login", "/updatePhone"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String servletPath = request.getServletPath();
        System.out.println("Servlet Path: " + servletPath); // Log để debug

        if ("/updatePhone".equals(servletPath)) {
            System.out.println("Processing /updatePhone in doGet");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            System.out.println("Email: " + email + ", PhoneNumber: " + phoneNumber);

            // Cập nhật phoneNumber vào cơ sở dữ liệu
            try (java.sql.Connection conn = AccountDAO.getConnect();
                 java.sql.PreparedStatement stmt = conn.prepareStatement("UPDATE [dbo].[Account] SET phoneNumber = ? WHERE email = ?")) {
                stmt.setString(1, phoneNumber);
                stmt.setString(2, email);
                int rowsAffected = stmt.executeUpdate();
                System.out.println("Rows affected: " + rowsAffected);
            } catch (java.sql.SQLException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/views/auth/phoneInput.jsp?error=update_failed");
                return;
            }

            // Lấy lại tài khoản và lưu vào session
            Account account = AccountDAO.getAccountByEmail(email);
            if (account != null) {
                HttpSession session = request.getSession();
                session.setAttribute("account", account);

                // Lưu thông tin customer, staff, admin vào session
                Customer customer = CustomerDAO.getCustomerByAccountId(account.getId());
                session.setAttribute("customer", customer);
                Staff staff = StaffDAO.getStaffByAccountId(account.getId());
                session.setAttribute("staff", staff);
                Admin admin = AdminDAO.getAdminByAccountId(account.getId());
                session.setAttribute("admin", admin);

                // Chuyển hướng dựa trên role
                if ("Admin".equals(account.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/views/admin/dashboard.jsp");
                } else if ("Staff".equals(account.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/views/staff/registerForAShift.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/views/common/home.jsp");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=account_not_found");
            }
        } else {
            // Xử lý Google OAuth callback (logic đăng nhập bằng Google)
            String code = request.getParameter("code");
            if (code != null && !code.isEmpty()) {
                try {
                    // Bước 1: Lấy access token từ Google
                    GoogleLogin gg = new GoogleLogin();
                    String accessToken = gg.getToken(code);
                    System.out.println("Access Token: " + accessToken);
                    // Bước 2: Lấy thông tin user từ Google
                    GoogleAccount googleAcc = gg.getUserInfo(accessToken);
                    System.out.println("Google Account: " + googleAcc);
                    if (googleAcc != null && googleAcc.getEmail() != null) {
                        String email = googleAcc.getEmail();
                        String name = googleAcc.getName();
                        // Bước 3: Kiểm tra xem email đã tồn tại trong database chưa
                        Account existingAccount = AccountDAO.getAccountByEmail(email);            
                        if (existingAccount == null) {
                            // Bước 4: Nếu chưa tồn tại, tạo account mới
                            System.out.println("Tạo account mới cho email: " + email);                       
                            // Tạo Account mới với role Customer
                            int accountId = AccountDAO.addAccount(email, null);
                            
                            if (accountId > 0) {
                                // Tách tên từ Google name (firstName, lastName)
                                String firstName = "";
                                String lastName = "";
                                
                                if (name != null && !name.trim().isEmpty()) {
                                    String[] nameParts = name.trim().split("\\s+");
                                    if (nameParts.length == 1) {
                                        firstName = nameParts[0];
                                        lastName = "";
                                    } else if (nameParts.length >= 2) {
                                        firstName = nameParts[0];
                                        // Ghép các phần còn lại thành lastName
                                        StringBuilder lastNameBuilder = new StringBuilder();
                                        for (int i = 1; i < nameParts.length; i++) {
                                            if (i > 1) lastNameBuilder.append(" ");
                                            lastNameBuilder.append(nameParts[i]);
                                        }
                                        lastName = lastNameBuilder.toString();
                                    }
                                } else {
                                    firstName = "User";
                                    lastName = "";
                                }
                                // Tạo Customer record
                                CustomerDAO.insertCustomer(accountId, firstName, lastName);
                                // Chuyển hướng đến trang nhập số điện thoại
                                request.setAttribute("email", email);
                                request.getRequestDispatcher("/views/auth/phoneInput.jsp").forward(request, response);
                                return;
                            } else {
                                response.sendRedirect(request.getContextPath() + "/login.jsp?error=create_account_failed");
                                return;
                            }
                        } else {
                            // Kiểm tra nếu phoneNumber là null hoặc rỗng
                            if (existingAccount.getPhoneNumber() == null || existingAccount.getPhoneNumber().trim().isEmpty()) {
                                request.setAttribute("email", email);
                                request.getRequestDispatcher("/views/auth/phoneInput.jsp").forward(request, response);
                                return;
                            }
                            
                            HttpSession session = request.getSession();
                            session.setAttribute("account", existingAccount);

                            // Lưu thông tin customer, staff, admin vào session
                            Customer customer = CustomerDAO.getCustomerByAccountId(existingAccount.getId());
                            session.setAttribute("customer", customer);
                            Staff staff = StaffDAO.getStaffByAccountId(existingAccount.getId());
                            session.setAttribute("staff", staff);
                            Admin admin = AdminDAO.getAdminByAccountId(existingAccount.getId());
                            session.setAttribute("admin", admin);

                            // Chuyển hướng dựa trên role
                            if ("Admin".equals(existingAccount.getRole())) {
                                response.sendRedirect(request.getContextPath() + "/views/admin/dashboard.jsp");
                            } else if ("Staff".equals(existingAccount.getRole())) {
                                response.sendRedirect(request.getContextPath() + "/views/staff/registerForAShift.jsp");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/views/common/home.jsp");
                            }
                        }
                    } else {
                        response.sendRedirect(request.getContextPath() + "/login.jsp?error=google_info_failed");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/login.jsp?error=google_login_failed");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);

        // Sử dụng AccountDAO để kiểm tra đăng nhập
        Account account = AccountDAO.checkAccount(email, password);

        if (account != null) {
            HttpSession session = request.getSession();
            session.setAttribute("account", account);

            Customer customer = CustomerDAO.getCustomerByAccountId(account.getId());
            session.setAttribute("customer", customer);
            Staff staff = StaffDAO.getStaffByAccountId(account.getId());
            session.setAttribute("staff", staff);
            Admin admin = AdminDAO.getAdminByAccountId(account.getId());
            session.setAttribute("admin", admin);
            if ("Admin".equals(account.getRole())) {
                response.sendRedirect(request.getContextPath() + "/views/admin/dashboard.jsp");
            } else if ("Staff".equals(account.getRole())) {
                response.sendRedirect(request.getContextPath() + "/views/staff/registerForAShift.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/views/common/home.jsp");
            }
            // Lưu email vào cookie nếu 'remember me' được chọn
            if ("on".equals(remember)) {
                Cookie userCookie = new Cookie("username", email);
                userCookie.setMaxAge(3 * 24 * 60 * 60);
                response.addCookie(userCookie);
            }
        } else {
            request.setAttribute("loginError", "Sai email hoặc mật khẩu!");
            System.out.println("Login fail");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
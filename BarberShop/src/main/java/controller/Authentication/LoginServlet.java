package controller.Authentication;

import controller.Authentication.GoogleLogin;
import babershopDAO.AccountDAO;
import babershopDAO.AdminDAO;
import babershopDAO.CustomerDAO;
import babershopDAO.StaffDAO;
import java.io.IOException;
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

@WebServlet(name = "LoginServlet", urlPatterns = {"/login", "/updatePhone"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String servletPath = request.getServletPath();
        System.out.println("Servlet Path: " + servletPath);

        if ("/updatePhone".equals(servletPath)) {
            System.out.println("Processing /updatePhone in doGet");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            System.out.println("Email: " + email + ", PhoneNumber: " + phoneNumber);

            try (java.sql.Connection conn = AccountDAO.getConnect();
                 java.sql.PreparedStatement stmt = conn.prepareStatement("UPDATE [dbo].[Account] SET phoneNumber = ? WHERE email = ?")) {
                stmt.setString(1, phoneNumber);
                stmt.setString(2, email);
                int rowsAffected = stmt.executeUpdate();
                System.out.println("Rows affected: " + rowsAffected);
            } catch (java.sql.SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMes", "Cập nhật số điện thoại thất bại!");
                request.getRequestDispatcher("/views/auth/phoneInput.jsp").forward(request, response);
                return;
            }

            Account account = AccountDAO.getAccountByEmail(email);
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
            } else {
                request.setAttribute("errorMes", "Không tìm thấy tài khoản!");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } else {
            String code = request.getParameter("code");
            if (code != null && !code.isEmpty()) {
                try {
                    GoogleLogin gg = new GoogleLogin();
                    String accessToken = gg.getToken(code);
                    System.out.println("Access Token: " + accessToken);
                    GoogleAccount googleAcc = gg.getUserInfo(accessToken);
                    System.out.println("Google Account: " + googleAcc);
                    if (googleAcc != null && googleAcc.getEmail() != null) {
                        String email = googleAcc.getEmail();
                        String name = googleAcc.getName();
                        Account existingAccount = AccountDAO.getAccountByEmail(email);            
                        if (existingAccount == null) {
                            System.out.println("Tạo account mới cho email: " + email);                       
                            int accountId = AccountDAO.addAccount(email, null);
                            
                            if (accountId > 0) {
                                String firstName = "";
                                String lastName = "";
                                
                                if (name != null && !name.trim().isEmpty()) {
                                    String[] nameParts = name.trim().split("\\s+");
                                    if (nameParts.length == 1) {
                                        firstName = nameParts[0];
                                        lastName = "";
                                    } else if (nameParts.length >= 2) {
                                        firstName = nameParts[0];
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
                                CustomerDAO.insertCustomer(accountId, firstName, lastName);
                                request.setAttribute("email", email);
                                request.getRequestDispatcher("/views/auth/phoneInput.jsp").forward(request, response);
                                return;
                            } else {
                                request.setAttribute("errorMes", "Tạo tài khoản thất bại!");
                                request.getRequestDispatcher("/login.jsp").forward(request, response);
                                return;
                            }
                        } else {
                            if (existingAccount.getPhoneNumber() == null || existingAccount.getPhoneNumber().trim().isEmpty()) {
                                request.setAttribute("email", email);
                                request.getRequestDispatcher("/views/auth/phoneInput.jsp").forward(request, response);
                                return;
                            }
                            
                            HttpSession session = request.getSession();
                            session.setAttribute("account", existingAccount);
                            Customer customer = CustomerDAO.getCustomerByAccountId(existingAccount.getId());
                            session.setAttribute("customer", customer);
                            Staff staff = StaffDAO.getStaffByAccountId(existingAccount.getId());
                            session.setAttribute("staff", staff);
                            Admin admin = AdminDAO.getAdminByAccountId(existingAccount.getId());
                            session.setAttribute("admin", admin);

                            if ("Admin".equals(existingAccount.getRole())) {
                                response.sendRedirect(request.getContextPath() + "/DashboardServlet");
                            } else if ("Staff".equals(existingAccount.getRole())) {
                                response.sendRedirect(request.getContextPath() + "/views/staff/registerForAShift.jsp");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/views/common/home.jsp");
                            }
                        }
                    } else {
                        request.setAttribute("errorMes", "Không lấy được thông tin từ Google!");
                        request.getRequestDispatcher("/login.jsp").forward(request, response);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("errorMes", "Đăng nhập bằng Google thất bại!");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                }
            } else {
                request.getRequestDispatcher("/login.jsp").forward(request, response);
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
                response.sendRedirect(request.getContextPath() + "/DashboardServlet");
            } else if ("Staff".equals(account.getRole())) {
                response.sendRedirect(request.getContextPath() + "/views/staff/registerForAShift.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/views/common/home.jsp");
            }
            if ("on".equals(remember)) {
                Cookie userCookie = new Cookie("username", email);
                userCookie.setMaxAge(3 * 24 * 60 * 60);
                response.addCookie(userCookie);
            }
        } else {
            request.setAttribute("errorMes", "Sai email hoặc mật khẩu!");
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
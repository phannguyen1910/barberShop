package controller;

import babershopDAO.AccountDAO;
import babershopDAO.CustomerDAO;
import babershopDAO.StaffDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Account;
import model.Customer;
import model.Staff;
import java.io.File;
import java.io.IOException;

@WebServlet(name = "EditProfileServlet", urlPatterns = {"/EditProfileServlet"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class EditProfileServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "image/staff";

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
        Account account = (Account) session.getAttribute("account");

        if (account == null || (!"customer".equalsIgnoreCase(account.getRole()) && !"staff".equalsIgnoreCase(account.getRole()))) {
            request.setAttribute("error", "Bạn không có quyền chỉnh sửa thông tin.");
            request.getRequestDispatcher("/views/common/profile.jsp").forward(request, response);
            return;
        }

        String action = request.getParameter("action");
        AccountDAO accountDAO = new AccountDAO();
        String message = null;

        if ("updateProfile".equals(action)) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");

            if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
                if (!phoneNumber.matches("^[0-9]{10,15}$")) {
                    message = "Số điện thoại phải chứa 10-15 chữ số.";
                    request.setAttribute("error", message);
                    request.getRequestDispatcher("/views/common/editProfile.jsp").forward(request, response);
                    return;
                }
                if (!phoneNumber.equals(account.getPhoneNumber()) && CustomerDAO.checkPhoneExist(phoneNumber)) {
                    message = "Số điện thoại đã được sử dụng.";
                    request.setAttribute("error", message);
                    request.getRequestDispatcher("/views/common/editProfile.jsp").forward(request, response);
                    return;
                }
            } else {
                phoneNumber = account.getPhoneNumber();
            }

            // Kiểm tra đổi email
            if (email != null && !email.equals(account.getEmail())) {
                if (AccountDAO.checkExistedEmail(email)) {
                    message = "Email đã được sử dụng.";
                    request.setAttribute("error", message);
                    request.getRequestDispatcher("/views/common/editProfile.jsp").forward(request, response);
                    return;
                } else {
                    boolean updated = AccountDAO.updateEmail(account.getId(), email);
                    if (!updated) {
                        message = "Lỗi khi cập nhật email.";
                        request.setAttribute("error", message);
                        request.getRequestDispatcher("/views/common/editProfile.jsp").forward(request, response);
                        return;
                    }
                }
            }

            String imgPath = null;
            if ("staff".equalsIgnoreCase(account.getRole())) {
                Part filePart = request.getPart("img");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = extractFileName(filePart);
                    String applicationPath = request.getServletContext().getRealPath("");
                    String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    imgPath = UPLOAD_DIR + File.separator + fileName;
                    filePart.write(uploadPath + File.separator + fileName);
                } else {
                    Staff staff = (Staff) session.getAttribute("staff");
                    if (staff != null) {
                        imgPath = staff.getImg();
                    }
                }
            }

            message = accountDAO.editProfile(account.getId(), firstName, lastName, phoneNumber);
            if ("staff".equalsIgnoreCase(account.getRole()) && imgPath != null) {
                try (java.sql.Connection conn = AccountDAO.getConnect();
                     java.sql.PreparedStatement stmt = conn.prepareStatement("UPDATE Staff SET img = ? WHERE accountId = ?")) {
                    stmt.setString(1, imgPath);
                    stmt.setInt(2, account.getId());
                    stmt.executeUpdate();
                } catch (Exception e) {
                    e.printStackTrace();
                    message = "Lỗi khi cập nhật hình ảnh: " + e.getMessage();
                }
            }

            Account updatedAccount = AccountDAO.getAccountById(account.getId());
            session.setAttribute("account", updatedAccount);
            if ("customer".equalsIgnoreCase(updatedAccount.getRole())) {
                Customer updatedCustomer = CustomerDAO.getCustomerByAccountId(updatedAccount.getId());
                session.setAttribute("customer", updatedCustomer);
                session.setAttribute("user", updatedCustomer);
                session.setAttribute("firstName", updatedCustomer != null ? updatedCustomer.getFirstName() : "");
                session.setAttribute("lastName", updatedCustomer != null ? updatedCustomer.getLastName() : "");
                session.setAttribute("email", updatedAccount.getEmail());
                session.setAttribute("phoneNumber", updatedAccount.getPhoneNumber());
            } else if ("staff".equalsIgnoreCase(updatedAccount.getRole())) {
                Staff updatedStaff = StaffDAO.getStaffByAccountId(updatedAccount.getId());
                session.setAttribute("staff", updatedStaff);
                session.setAttribute("user", updatedStaff);
                session.setAttribute("firstName", updatedStaff != null ? updatedStaff.getFirstName() : "");
                session.setAttribute("lastName", updatedStaff != null ? updatedStaff.getLastName() : "");
                session.setAttribute("email", updatedStaff != null ? updatedStaff.getEmail() : "");
                session.setAttribute("phoneNumber", updatedStaff != null ? updatedStaff.getPhoneNumber() : "");
                session.setAttribute("img", updatedStaff != null ? updatedStaff.getImg() : null);
            }
        } else if ("changePassword".equals(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (currentPassword == null || currentPassword.trim().isEmpty() ||
                    newPassword == null || newPassword.trim().isEmpty() ||
                    confirmPassword == null || confirmPassword.trim().isEmpty()) {
                message = "Vui lòng nhập đầy đủ thông tin mật khẩu.";
            } else if (!newPassword.equals(confirmPassword)) {
                message = "Mật khẩu mới và xác nhận mật khẩu không khớp.";
            } else if (newPassword.length() < 6) {
                message = "Mật khẩu mới phải có ít nhất 6 ký tự.";
            } else {
                message = accountDAO.changePassword(account.getEmail(), currentPassword, newPassword);
                if ("Change password successful".equals(message)) {
                    message = "Thay đổi mật khẩu thành công.";
                    account.setPassword(null);
                    session.setAttribute("account", account);
                }
            }
        } else {
            message = "Hành động không hợp lệ.";
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("/views/common/profile.jsp").forward(request, response);
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    @Override
    public String getServletInfo() {
        return "Edit Profile Servlet for updating customer and staff profile information and changing password";
    }
}

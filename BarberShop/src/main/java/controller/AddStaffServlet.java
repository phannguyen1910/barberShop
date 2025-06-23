package controller;

import babershopDAO.StaffDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/add-staff")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,    // 2MB
    maxFileSize = 1024 * 1024 * 10,         // 10MB
    maxRequestSize = 1024 * 1024 * 50       // 50MB
)
public class AddStaffServlet extends HttpServlet {

    private final String UPLOAD_DIR = "image/staff";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Lấy thông tin từ form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone");
        String role = request.getParameter("role");

        // Xử lý file ảnh (nếu có)
        String img = null;
        Part filePart = request.getPart("img");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            img = UPLOAD_DIR + File.separator + fileName; // Lưu đường dẫn tương đối
        }

        // Gọi DAO để lưu
        try {
            StaffDAO.addStaff(firstName, lastName, email, phoneNumber, role, img);
            // Lưu thông báo thành công vào session
            HttpSession session = request.getSession();
            session.setAttribute("message", "Thêm nhân viên thành công!");
            // Chuyển hướng với tham số success
            response.sendRedirect(request.getContextPath() + "/admin/view-staff?success=true");
        } catch (Exception e) {
            // Xử lý lỗi và lưu thông báo lỗi
            HttpSession session = request.getSession();
            session.setAttribute("message", "Thêm nhân viên thất bại: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/view-staff?success=false");
        }
    }
}
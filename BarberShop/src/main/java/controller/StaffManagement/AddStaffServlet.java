package controller.StaffManagement;

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
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class AddStaffServlet extends HttpServlet {

    private final String UPLOAD_DIR = "image/staff";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone");
        String role = request.getParameter("role");

        // ✅ Đọc branchId từ form
        String branchIdStr = request.getParameter("branchId");
        int branchId = branchIdStr != null ? Integer.parseInt(branchIdStr) : 0;

        String img = null;
        Part filePart = request.getPart("img");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "image/staff";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            img = "image/staff/" + fileName;
        }

        try {
            // ✅ Gọi DAO với branchId
            StaffDAO.addStaff(firstName, lastName, email, phoneNumber, role, img, branchId);

            HttpSession session = request.getSession();
            session.setAttribute("message", "Thêm nhân viên thành công!");
            response.sendRedirect(request.getContextPath() + "/admin/view-staff?success=true");
        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("message", "Thêm nhân viên thất bại: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/view-staff?success=false");
        }
    }
}


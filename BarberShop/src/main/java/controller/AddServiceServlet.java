package controller;

import babershopDAO.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;

/**
 * Servlet xử lý thêm dịch vụ mới và upload ảnh.
 * <p>
 * - Ảnh được ghi vào thư mục <web‑app>/image/{imgFolder}/{fileName}.<br>
 * - Cột `service.image` trong DB chỉ lưu relative path sau `/image/`,
 *   ví dụ: <code>combo1/1721159879563_7.png</code>.<br>
 * - JSP hiển thị: <code>&lt;img src="${pageContext.request.contextPath}/image/${service.image}" ...&gt;</code>
 */
@WebServlet("/AddServiceServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,   // 2 MB
        maxFileSize = 1024 * 1024 * 10,        // 10 MB
        maxRequestSize = 1024 * 1024 * 50      // 50 MB
)
public class AddServiceServlet extends HttpServlet {

    /**
     * Thư mục public chứa ảnh, nằm ngay dưới web‑root và được mapping trực tiếp qua URL
     *   {contextPath}/image/*
     */
    private static final String PUBLIC_IMAGE_DIR = "image";

    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        serviceDAO = new ServiceDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // ----------------- LẤY & VALIDATE DỮ LIỆU FORM -----------------
        String name         = request.getParameter("serviceName");
        String priceStr     = request.getParameter("servicePrice");
        String durationStr  = request.getParameter("serviceDuration");
        String description  = request.getParameter("serviceDescription");
        String categoryStr  = request.getParameter("serviceCategory");

        // Thư mục con chứa ảnh (vd: combo1, combo2...). Có thể gửi từ <input name="imgFolder">.
        // Nếu form không gửi, mặc định "default" để khỏi null.
        String imgFolder    = request.getParameter("imgFolder");
        if (imgFolder == null || imgFolder.isBlank()) {
            imgFolder = "default";
        }
        // Chuẩn hoá thư mục: bỏ ký tự \, ../, khoảng trắng
        imgFolder = imgFolder.trim().replace('\\', '/').replace("..", "");
        while (imgFolder.startsWith("/")) imgFolder = imgFolder.substring(1);

        // Kiểm tra dữ liệu tối thiểu
        if (name == null || name.trim().isEmpty() || priceStr == null || durationStr == null || categoryStr == null) {
            String msg = URLEncoder.encode("Vui lòng điền đầy đủ thông tin", "UTF-8");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?error=" + msg);
            return;
        }

        double price;
        int duration;
        int categoryID;
        try {
            price = Double.parseDouble(priceStr);
            duration = Integer.parseInt(durationStr);

            switch (categoryStr) {
                case "dichvu1": categoryID = 1; break;
                case "dichvu2": categoryID = 2; break;
                case "dichvu3": categoryID = 3; break;
                case "dichvu4": categoryID = 4; break;
                case "dichvu5": categoryID = 5; break;
                default: throw new NumberFormatException("Loại dịch vụ không hợp lệ");
            }

            if (price < 0 || duration < 0) throw new NumberFormatException();
        } catch (NumberFormatException ex) {
            String msg = URLEncoder.encode("Giá, thời gian phải là số dương và loại dịch vụ hợp lệ", "UTF-8");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?error=" + msg);
            return;
        }

        // ----------------- XỬ LÝ ẢNH UPLOAD -----------------
        Part filePart = request.getPart("serviceImage"); // <input type="file" name="serviceImage">
        String storedRelativePath = null;                 // giá trị sẽ lưu DB (combo1/xxx.png)

        if (filePart != null && filePart.getSize() > 0 && extractFileName(filePart) != null) {
            String originalName   = extractFileName(filePart);
            String uniqueFileName = System.currentTimeMillis() + "_" + originalName;

            // Thư mục ghi file trên ổ đĩa: {webapp}/image/{imgFolder}
            String appPath   = request.getServletContext().getRealPath("");
            File folder      = new File(appPath, PUBLIC_IMAGE_DIR + File.separator + imgFolder);
            if (!folder.exists()) folder.mkdirs();

            // Ghi file (ghi đè nếu trùng)
            File targetFile = new File(folder, uniqueFileName);
            filePart.write(targetFile.getAbsolutePath());

            // Giá trị lưu DB (không có phần PUBLIC_IMAGE_DIR)
            storedRelativePath = imgFolder + "/" + uniqueFileName;
        }

        // ----------------- LƯU DB & CHUYỂN HƯỚNG -----------------
        try {
            serviceDAO.insertService(name, price, duration, description, storedRelativePath, categoryID);
            String msg = URLEncoder.encode("Thêm dịch vụ thành công", "UTF-8");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?success=" + msg);
        } catch (Exception ex) {
            ex.printStackTrace();
            String msg = URLEncoder.encode("Có lỗi xảy ra khi thêm dịch vụ: " + ex.getMessage(), "UTF-8");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?error=" + msg);
        }
    }

    /**
     * Lấy tên file gốc từ header multipart.
     */
    private String extractFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        if (cd == null) return null;
        for (String token : cd.split(";")) {
            token = token.trim();
            if (token.startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}

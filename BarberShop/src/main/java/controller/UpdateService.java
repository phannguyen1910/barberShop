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
 * Servlet xử lý cập nhật dịch vụ và upload ảnh.
 * <p>
 * - Ảnh được ghi vào thư mục <web-app>/image/{imgFolder}/{fileName}.<br>
 * - Cột `service.image` trong DB chỉ lưu relative path sau `/image/`,
 *   ví dụ: <code>default/1721159879563_7.png</code>.<br>
 * - JSP hiển thị: <code>&lt;img src="${pageContext.request.contextPath}/image/${service.image}" ...&gt;</code>
 */
@WebServlet(name = "UpdateService", urlPatterns = {"/UpdateService"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,     // 10MB
        maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class UpdateService extends HttpServlet {

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

        // Lấy dữ liệu từ form
        String idStr = request.getParameter("serviceId");
        String name = request.getParameter("serviceName");
        String priceStr = request.getParameter("servicePrice");
        String durationStr = request.getParameter("serviceDuration");
        String description = request.getParameter("serviceDescription");
        String categoryStr = request.getParameter("serviceCategory");
        String imgFolder = request.getParameter("imgFolder");

        // Log dữ liệu đầu vào
        System.out.println("UpdateService: idStr=" + idStr + ", name=" + name + ", priceStr=" + priceStr +
                ", durationStr=" + durationStr + ", description=" + description + ", categoryStr=" + categoryStr +
                ", imgFolder=" + imgFolder);

        // Chuẩn hóa imgFolder
        if (imgFolder == null || imgFolder.isBlank()) {
            imgFolder = "default";
        }
        imgFolder = imgFolder.trim().replace('\\', '/').replace("..", "");
        while (imgFolder.startsWith("/")) imgFolder = imgFolder.substring(1);
        System.out.println("UpdateService: Standardized imgFolder=" + imgFolder);

        // Kiểm tra dữ liệu tối thiểu
        if (idStr == null || name == null || name.trim().isEmpty() || priceStr == null || durationStr == null || categoryStr == null) {
            String message = URLEncoder.encode("Vui lòng điền đầy đủ thông tin", "UTF-8");
            System.out.println("UpdateService: Validation failed - missing required fields");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?error=" + message);
            return;
        }

        int id;
        double price;
        int duration;
        int categoryID;
        try {
            id = Integer.parseInt(idStr);
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
            if (price < 0 || duration < 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            String message = URLEncoder.encode("ID, giá, thời gian phải là số dương và loại dịch vụ hợp lệ", "UTF-8");
            System.out.println("UpdateService: Validation failed - " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?error=" + message);
            return;
        }

        // Xử lý tải lên tệp hình ảnh (nếu có)
        Part filePart = request.getPart("serviceImage");
        String storedRelativePath = null;
        if (filePart != null && filePart.getSize() > 0 && extractFileName(filePart) != null) {
            String originalName = extractFileName(filePart);
            String uniqueFileName = System.currentTimeMillis() + "_" + originalName;
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + PUBLIC_IMAGE_DIR + File.separator + imgFolder;

            File uploadDir = new File(uploadPath);
            System.out.println("UpdateService: Creating directory: " + uploadPath);
            if (!uploadDir.exists()) {
                boolean created = uploadDir.mkdirs();
                System.out.println("UpdateService: Directory created: " + created);
            }

            String filePath = uploadPath + File.separator + uniqueFileName;
            System.out.println("UpdateService: Writing file to: " + filePath);
            filePart.write(filePath);
            storedRelativePath = imgFolder + "/" + uniqueFileName;
            System.out.println("UpdateService: Stored relative path: " + storedRelativePath);
        }

        // Lưu vào DB
        try {
            System.out.println("UpdateService: Calling updateService with id=" + id + ", name=" + name +
                    ", price=" + price + ", duration=" + duration + ", description=" + description +
                    ", imagePath=" + storedRelativePath + ", categoryID=" + categoryID);
            serviceDAO.updateService(id, name, (float) price, duration, description, storedRelativePath, categoryID);
            String message = URLEncoder.encode("Cập nhật dịch vụ thành công", "UTF-8");
            System.out.println("UpdateService: Update successful");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?success=" + message);
        } catch (Exception e) {
            e.printStackTrace();
            String message = URLEncoder.encode("Có lỗi xảy ra khi cập nhật dịch vụ: " + e.getMessage(), "UTF-8");
            System.out.println("UpdateService: Update failed - " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?error=" + message);
        }
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition == null) return null;
        for (String token : contentDisposition.split(";")) {
            token = token.trim();
            if (token.startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
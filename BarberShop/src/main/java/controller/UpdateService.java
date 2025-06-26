/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import babershopDAO.ServiceDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.net.URLEncoder;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateService", urlPatterns = {"/UpdateService"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateService extends HttpServlet {

private static final String UPLOAD_DIR = "uploads";
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
        String imagePath = null;

        if (idStr == null || name == null || name.trim().isEmpty() || priceStr == null || durationStr == null) {
            String message = URLEncoder.encode("Vui lòng điền đầy đủ thông tin", "UTF-8");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?error=" + message);
            return;
        }

        int id;
        double price;
        int duration;
        try {
            id = Integer.parseInt(idStr);
            price = Double.parseDouble(priceStr);
            duration = Integer.parseInt(durationStr);
            if (price < 0 || duration < 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            String message = URLEncoder.encode("ID, giá và thời gian phải là số dương", "UTF-8");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?error=" + message);
            return;
        }

        // Xử lý tải lên tệp hình ảnh (nếu có)
        Part filePart = request.getPart("serviceImage");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName(filePart);
            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String filePath = uploadPath + File.separator + uniqueFileName;
            filePart.write(filePath);
            imagePath = uniqueFileName; // Cập nhật hình ảnh mới
        }

        try {
            serviceDAO.updateService(id, name, (float) price, duration, description); // Giả sử updateService nhận imagePath
            if (imagePath != null) {
                // Cập nhật image nếu có tệp mới (tùy thuộc vào logic DAO)
                // Lưu ý: Cần điều chỉnh DAO nếu muốn cập nhật image
            }
            String message = URLEncoder.encode("Cập nhật dịch vụ thành công", "UTF-8");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?success=" + message);
        } catch (Exception e) {
            e.printStackTrace();
            String message = URLEncoder.encode("Có lỗi xảy ra khi cập nhật dịch vụ: " + e.getMessage(), "UTF-8");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?error=" + message);
        }
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

}

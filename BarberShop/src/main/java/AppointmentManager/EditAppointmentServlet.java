/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AppointmentManager;

import babershopDAO.AppointmentDAO;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.sql.SQLException;
import org.json.JSONObject;

/**
 *
 * @author Sekiro
 */
@WebServlet(name = "EditAppointmentServlet", urlPatterns = {"/EditAppointmentServlet"})
public class EditAppointmentServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditAppointmentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditAppointmentServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    
    
    
    
private AppointmentDAO appointmentDAO;

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    processRequest(request, response);
}

private final Gson gson = new Gson();

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    
    try {
        // Đọc dữ liệu JSON từ request body
        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        
        String jsonData = sb.toString();
        System.out.println("Received JSON: " + jsonData); // Debug log
        
        // Kiểm tra JSON có rỗng không
        if (jsonData == null || jsonData.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new Response(false, "Dữ liệu JSON trống", null)));
            return;
        }
        
        // Parse JSON thành đối tượng
        AppointmentUpdateRequest updateRequest = gson.fromJson(jsonData, AppointmentUpdateRequest.class);
        
        // Kiểm tra dữ liệu đầu vào chi tiết hơn
        if (updateRequest == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new Response(false, "Không thể parse JSON", null)));
            return;
        }
        
        if (updateRequest.appointmentId <= 0) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new Response(false, "ID lịch hẹn không hợp lệ", null)));
            return;
        }
        
        if (updateRequest.status == null || updateRequest.status.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new Response(false, "Trạng thái không được để trống", null)));
            return;
        }
        
        if (updateRequest.serviceIds == null || updateRequest.serviceIds.length == 0) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new Response(false, "Phải chọn ít nhất một dịch vụ", null)));
            return;
        }
        
        // Validate status values
        String[] validStatuses = {"pending", "confirmed", "completed", "cancelled"};
        boolean isValidStatus = false;
        for (String validStatus : validStatuses) {
            if (validStatus.equals(updateRequest.status)) {
                isValidStatus = true;
                break;
            }
        }
        
        if (!isValidStatus) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new Response(false, "Trạng thái không hợp lệ", null)));
            return;
        }
        
        System.out.println("Processing update for appointment ID: " + updateRequest.appointmentId); // Debug log
        
        // Khởi tạo DAO nếu chưa có
        if (appointmentDAO == null) {
            appointmentDAO = new AppointmentDAO();
        }
        
        // Gọi DAO để cập nhật lịch hẹn
        boolean success = appointmentDAO.editAppointmentService(
            updateRequest.appointmentId, 
            updateRequest.serviceIds, 
            updateRequest.status
        );
        
        if (success) {
            // Trả về phản hồi thành công
            response.getWriter().write(gson.toJson(new Response(true, "Cập nhật lịch hẹn thành công", null)));
        } else {
            // Trả về phản hồi thất bại
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(new Response(false, "Không thể cập nhật lịch hẹn. Vui lòng kiểm tra lại dữ liệu.", null)));
        }
        
    } catch (JsonSyntaxException e) {
        System.err.println("JSON Syntax Error: " + e.getMessage()); // Debug log
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write(gson.toJson(new Response(false, "Lỗi định dạng JSON: " + e.getMessage(), null)));
    } catch (SQLException e) {
        System.err.println("Database Error: " + e.getMessage()); // Debug log
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write(gson.toJson(new Response(false, "Lỗi cơ sở dữ liệu: " + e.getMessage(), null)));
    } catch (Exception e) {
        System.err.println("Unexpected Error: " + e.getMessage()); // Debug log
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write(gson.toJson(new Response(false, "Lỗi không xác định: " + e.getMessage(), null)));
    }
}

// Lớp để parse JSON từ request
private static class AppointmentUpdateRequest {
    int appointmentId;
    String status;
    int[] serviceIds;
    
    // Constructor mặc định
    public AppointmentUpdateRequest() {}
    
    // Getters và Setters (nếu cần)
    public int getAppointmentId() { return appointmentId; }
    public void setAppointmentId(int appointmentId) { this.appointmentId = appointmentId; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public int[] getServiceIds() { return serviceIds; }
    public void setServiceIds(int[] serviceIds) { this.serviceIds = serviceIds; }
}

// Lớp để trả về phản hồi JSON
private static class Response {
    boolean success;
    String message;
    Object data;
    
    Response(boolean success, String message, Object data) {
        this.success = success;
        this.message = message;
        this.data = data;
    }
    
    // Getters (nếu cần)
    public boolean isSuccess() { return success; }
    public String getMessage() { return message; }
    public Object getData() { return data; }
}
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

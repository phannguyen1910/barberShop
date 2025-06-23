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
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Sekiro
 */
@WebServlet(name = "EditAppointmentServlet", urlPatterns = {"/EditAppointmentServlet"})
public class EditAppointmentServlet extends HttpServlet {


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
    
    

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    processRequest(request, response);
}

private AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Đọc JSON từ request body
            BufferedReader reader = request.getReader();
            StringBuilder jsonInput = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonInput.append(line);
            }

            JSONObject jsonObject = new JSONObject(jsonInput.toString());
            int appointmentId = jsonObject.getInt("id");
            String status = jsonObject.getString("status");
            JSONArray serviceIdsArray = jsonObject.getJSONArray("serviceIds");
            int[] serviceIds = new int[serviceIdsArray.length()];
            for (int i = 0; i < serviceIdsArray.length(); i++) {
                serviceIds[i] = serviceIdsArray.getInt(i);
            }

            // Gọi DAO để chỉnh sửa lịch hẹn
            boolean success = appointmentDAO.editAppointmentService(appointmentId, serviceIds, status);

            // Lấy danh sách tên dịch vụ để trả về client
            String[] serviceNames = getServiceNames(serviceIds); // Giả định có phương thức này

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", success);
            if (success) {
                jsonResponse.put("services", new JSONArray(serviceNames));
            } else {
                jsonResponse.put("message", "Không thể chỉnh sửa lịch hẹn");
            }
            out.print(jsonResponse.toString());

        } catch (SQLException e) {
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print(jsonResponse.toString());
        } catch (Exception e) {
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Lỗi: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(jsonResponse.toString());
        } finally {
            out.close();
        }
    }

    // Phương thức giả định để lấy tên dịch vụ từ ServiceId
    private String[] getServiceNames(int[] serviceIds) {
        // Đây là mock data, bạn cần thay bằng truy vấn thực tế từ bảng Service
        String[] serviceNames = new String[serviceIds.length];
        for (int i = 0; i < serviceIds.length; i++) {
            switch (serviceIds[i]) {
                case 1:
                    serviceNames[i] = "Cắt tóc";
                    break;
                case 2:
                    serviceNames[i] = "Cạo mặt";
                    break;
                case 3:
                    serviceNames[i] = "Nhuộm tóc";
                    break;
                case 4:
                    serviceNames[i] = "Gội đầu";
                    break;
                default:
                    serviceNames[i] = "Dịch vụ không xác định";
            }
        }
        return serviceNames;
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

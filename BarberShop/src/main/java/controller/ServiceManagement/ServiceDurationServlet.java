package controller.ServiceManagement;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import babershopDAO.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Service;

@WebServlet(name = "ServiceDurationServlet", urlPatterns = {"/api/service-duration"})
public class ServiceDurationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        try {
            String[] serviceIds = request.getParameterValues("serviceIds");
            
            if (serviceIds == null || serviceIds.length == 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\": \"Không có dịch vụ nào được chọn\"}");
                return;
            }

            ServiceDAO serviceDAO = new ServiceDAO();
            int totalDuration = 0;
            List<Service> services = serviceDAO.getChoosedService(serviceIds);

            for (Service service : services) {
                totalDuration += service.getDuration();
            }

            // Trả về tổng thời lượng
            String jsonOutput = gson.toJson(new ServiceDurationResponse(totalDuration, services));
            out.print(jsonOutput);

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\": \"" + e.getMessage() + "\"}");
            System.err.println("Lỗi khi tính thời lượng dịch vụ: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // Inner class để trả về thông tin thời lượng
    public static class ServiceDurationResponse {
        private int totalDurationMinutes;
        private List<Service> services;

        public ServiceDurationResponse(int totalDurationMinutes, List<Service> services) {
            this.totalDurationMinutes = totalDurationMinutes;
            this.services = services;
        }

        public int getTotalDurationMinutes() {
            return totalDurationMinutes;
        }

        public void setTotalDurationMinutes(int totalDurationMinutes) {
            this.totalDurationMinutes = totalDurationMinutes;
        }

        public List<Service> getServices() {
            return services;
        }

        public void setServices(List<Service> services) {
            this.services = services;
        }
    }
} 
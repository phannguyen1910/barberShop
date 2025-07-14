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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import model.Service;

@WebServlet(name = "ServiceDurationServlet", urlPatterns = {"/api/service-duration"})
public class ServiceDurationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    PrintWriter out = response.getWriter();
    Gson gson = new Gson();

    try {
        String[] serviceIds = request.getParameterValues("serviceIds");
        if (serviceIds == null || serviceIds.length == 0) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.write("{\"error\": \"No service IDs provided\"}");
            return;
        }

        List<Integer> serviceIdList = new ArrayList<>();
        for (String id : serviceIds) {
            try {
                serviceIdList.add(Integer.parseInt(id));
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"error\": \"Invalid service ID format\"}");
                return;
            }
        }

        ServiceDAO serviceDAO = new ServiceDAO();
        List<Service> services = serviceDAO.getServicesByIds(serviceIdList); // New method in ServiceDAO
        int totalDuration = services.stream().mapToInt(Service::getDuration).sum();

        Map<String, Object> responseData = new HashMap<>();
        responseData.put("totalDurationMinutes", totalDuration);
        responseData.put("services", services);

        out.write(gson.toJson(responseData));
    } catch (Exception e) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        out.write("{\"error\": \"Error processing request: " + e.getMessage() + "\"}");
    } finally {
        out.close();
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
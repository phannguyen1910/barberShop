package controller.StaffManagement;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "TestServlet", urlPatterns = {"/TestServlet"})
public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set JSON content type
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Disable cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        System.out.println("DEBUG (TestServlet): Received GET request.");
        
        try {
            // Simple test data
            List<String> testSlots = Arrays.asList("08:30", "09:00", "09:30", "10:00");
            
            // Return JSON response
            response.getWriter().write(new Gson().toJson(testSlots));
            System.out.println("DEBUG (TestServlet): Sent test data: " + testSlots);
            
        } catch (Exception e) {
            System.err.println("ERROR (TestServlet): " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(new Gson().toJson("Lỗi server"));
        }
    }
} 
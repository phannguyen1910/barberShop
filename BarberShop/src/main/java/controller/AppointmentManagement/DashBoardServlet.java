package controller.AppointmentManagement;

import babershopDAO.AppointmentDAO;
import babershopDAO.CustomerDAO;
import babershopDAO.InvoiceDAO;
import babershopDAO.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import com.google.gson.Gson;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/DashboardServlet"})
public class DashBoardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        CustomerDAO customerDAO = new CustomerDAO();
        ServiceDAO serviceDAO = new ServiceDAO();
        InvoiceDAO invoiceDAO = new InvoiceDAO();

        int numberOfCustomer = customerDAO.countNumberCustomer();
        int numberOfService = serviceDAO.countNumberService();
        int numberOfAppointment = appointmentDAO.countNumberOfAppointment();
        float totalRevenue = invoiceDAO.totalInvoice();
        List<Map<String, Object>> revenueCurrentYear = invoiceDAO.getRevenueCurrentYear();

        // Serialize revenueCurrentYear to JSON
        Gson gson = new Gson();
        String revenueCurrentYearJson = gson.toJson(revenueCurrentYear);

        for (Map<String, Object> revenue : revenueCurrentYear) {
            System.out.println("Revenue: " + revenue);
        }

        request.setAttribute("numberOfCustomer", numberOfCustomer);
        request.setAttribute("numberOfService", numberOfService);
        request.setAttribute("numberOfAppointment", numberOfAppointment);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("revenueCurrentYearJson", revenueCurrentYearJson);

        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Dashboard Servlet for Barbershop Admin";
    }
}
package controller;

import babershopDAO.ServiceDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Service;
import model.Voucher;

@WebServlet(name = "ConfirmationServlet", urlPatterns = {"/ConfirmationServlet"})
public class ConfirmationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int staffId = Integer.parseInt(request.getParameter("staffId"));
        String appointmentTime = request.getParameter("appointmentTime");
        int numberOfPeople = Integer.parseInt(request.getParameter("numberOfPeople"));
        String[] serviceIdParams = request.getParameterValues("serviceIds");
        List<Integer> serviceIds = new ArrayList<>();
        if (serviceIdParams != null) {
            for (String s : serviceIdParams) {
                serviceIds.add(Integer.parseInt(s));
            }
        }

        ServiceDAO serviceDAO = new ServiceDAO();
        double amount = 0;
        List<Service> listService = new ArrayList<>();
        for (int id : serviceIds) {
            amount += serviceDAO.getServicePriceById(id);
            Service service = serviceDAO.getServiceById(id);
            if (service != null) listService.add(service);
        }
        amount *= numberOfPeople;

        // Gửi dữ liệu sang JSP
        request.setAttribute("staffId", staffId);
        request.setAttribute("customerId", customerId);
        request.setAttribute("numberOfPeople", numberOfPeople);
        request.setAttribute("dateTime", appointmentTime);
        request.setAttribute("totalMoney", amount);
        request.setAttribute("listService", listService);
        request.setAttribute("serviceIds", serviceIds);
// ✅ thêm dòng này

        request.getRequestDispatcher("Payment").forward(request, response);
    }
}


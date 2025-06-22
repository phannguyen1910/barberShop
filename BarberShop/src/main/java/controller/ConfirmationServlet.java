package controller;

import babershopDAO.AppointmentDAO;
import babershopDAO.InvoiceDAO;
import babershopDAO.ServiceDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Service;
import model.Voucher;

@WebServlet(name = "ConfirmationServlet", urlPatterns = {"/ConfirmationServlet"})
public class ConfirmationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int staffId = Integer.parseInt(request.getParameter("staffId"));
        String appointmentTime = request.getParameter("appointmentTime");
        int numberOfPeople = Integer.parseInt(request.getParameter("numberOfPeople"));
        String[] serviceIdParams = request.getParameterValues("serviceIds");
        float totalAmount = Float.parseFloat(request.getParameter("totalBill"));
        String branchIdStr = (String) session.getAttribute("selectedBranchId");
        int branchId = Integer.parseInt(branchIdStr);
        List<Integer> serviceIds = new ArrayList<>();
        if (serviceIdParams != null) {
            for (String s : serviceIdParams) {
                Integer id = Integer.parseInt(s);
                serviceIds.add(id);
                System.out.println(id);
            }

        }else{
            System.out.println("Khong co list ids");
        }
        ServiceDAO serviceDAO = new ServiceDAO();
        double amount = 0;
        List<Service> listService = new ArrayList<>();
        for (int id : serviceIds) {
            amount += serviceDAO.getServicePriceById(id);
            Service service = serviceDAO.getServiceById(id);
            if (service != null) {
                listService.add(service);
            }
        }

        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        LocalDateTime dateTime = LocalDateTime.parse(appointmentTime, outputFormatter);

        amount *= numberOfPeople;
        AppointmentDAO appointmentDAO = new AppointmentDAO();

        boolean check = appointmentDAO.addAppointment(customerId, staffId, dateTime, numberOfPeople, serviceIds, totalAmount, branchId);
        if (check == true) {
            request.getRequestDispatcher("Payment").forward(request, response);
        } else {
            request.getRequestDispatcher("BookingServlet").forward(request, response);
        }

    }
}

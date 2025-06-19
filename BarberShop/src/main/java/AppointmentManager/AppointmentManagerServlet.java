/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AppointmentManager;

import babershopDAO.AccountDAO;
import babershopDAO.AppointmentDAO;
import babershopDAO.CustomerDAO;
import babershopDAO.ServiceDAO;
import babershopDAO.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Appointment;
import model.AppointmentService;
import model.Customer;
import model.Service;
import model.Staff;

/**
 *
 * @author Sekiro
 */
@WebServlet(name = "AppointmentManagerServlet", urlPatterns = {"/AppointmentManagerServlet"})
public class AppointmentManagerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AppointmentManagerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AppointmentManagerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        AccountDAO accountDAO = AccountDAO.get
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        ServiceDAO serviceDAO = new ServiceDAO();
        CustomerDAO customerDAO = new CustomerDAO();
        StaffDAO staffDAO = new StaffDAO();
        List <Appointment> appointments = appointmentDAO.getAllAppointmentsWithDetails();
        List <Service> services = serviceDAO.getAllService();
        List <Customer> customers  = customerDAO.getAllCustomer();
        List <Staff> staffs = staffDAO.getAllStaffs();
        request.setAttribute("listCustomer", customers);
        request.setAttribute("listStaff", staffs);
        request.setAttribute("listAppointment", appointments);
        request.setAttribute("listService", services);
        request.getRequestDispatcher("/views/admin/appointmentManagement.jsp").forward(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

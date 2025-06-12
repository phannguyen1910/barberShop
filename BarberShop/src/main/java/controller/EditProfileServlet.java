/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import babershopDAO.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Admin;
import model.Customer;
import model.Staff;

/**
 *
 * @author Sekiro
 */
@WebServlet(name = "EditProfileServlet", urlPatterns = {"/EditProfileServlet"})
public class EditProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet EditProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProfileServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        HttpSession session = request.getSession();
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNumber = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        AccountDAO accountDAO = new AccountDAO();
        String message = accountDAO.editProfile(3, firstName, lastName, phoneNumber);
        String role = accountDAO.checkRole(3);
        System.out.println(message);
        if (role.equals("Customer")) {
            Customer customer = new Customer(email, phoneNumber, password, "Customer", 1, firstName, lastName);
            List<Customer> customers = accountDAO.listCustomers();
            for (Customer c : customers) {
                if (c.getAccountId() == 3) {
                    c.setFirstName(firstName);
                    c.setLastName(lastName);
                    c.setPhoneNumber(phoneNumber);
                }
            }
//            session.setAttribute("firstName", customer.getFirstName());
//            session.setAttribute("lastName", customer.getLastName());
//            session.setAttribute("email", customer.getEmail());
//            session.setAttribute("phone", customer.getPhoneNumber());
//            response.sendRedirect("profile.jsp");

            request.setAttribute("firstName", customer.getFirstName());
            request.setAttribute("lastName", customer.getLastName());
            request.setAttribute("email", customer.getEmail());
            request.setAttribute("phone", customer.getPhoneNumber());
            request.setAttribute("message", message);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        } else if (role.equals("Staff")) {
            Staff staff = new Staff(firstName, lastName, email, phoneNumber, password, "Staff", 1);
            List<Staff> staffs = accountDAO.listStaffs();
            for (Staff s : staffs) {
                if (s.getAccountId() == 3) {
                    s.setFirstName(firstName);
                    s.setLastName(lastName);
                    s.setPhoneNumber(phoneNumber);
                }
            }
//            session.setAttribute("firstName", customer.getFirstName());
//            session.setAttribute("lastName", customer.getLastName());
//            session.setAttribute("email", customer.getEmail());
//            session.setAttribute("phone", customer.getPhoneNumber());
//            response.sendRedirect("profile.jsp");

            request.setAttribute("firstName", staff.getFirstName());
            request.setAttribute("lastName", staff.getLastName());
            request.setAttribute("email", staff.getEmail());
            request.setAttribute("phone", staff.getPhoneNumber());
            request.setAttribute("message", message);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        } else if (role.equals("Admin")) {
            Admin admin = new Admin(1, firstName, lastName, email, phoneNumber, password, role, 1);
            List<Admin> admins = accountDAO.listAdmins();
            for (Admin a : admins) {
                if (a.getAccountId()== 1) {
                    a.setFirstName(firstName);
                    a.setLastName(lastName);
                    a.setPhoneNumber(phoneNumber);
                }
            }
//            session.setAttribute("firstName", customer.getFirstName());
//            session.setAttribute("lastName", customer.getLastName());
//            session.setAttribute("email", customer.getEmail());
//            session.setAttribute("phone", customer.getPhoneNumber());
//            response.sendRedirect("profile.jsp");
            request.setAttribute("firstName", admin.getFirstName());
            request.setAttribute("lastName", admin.getLastName());
            request.setAttribute("email", admin.getEmail());
            request.setAttribute("phone", admin.getPhoneNumber());
            request.setAttribute("message", message);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        } else {
            System.out.println("Roi vao ngoai le");
        }

    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}


package controller.Authentication;

import babershopDAO.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Validation;

/**
 *
 * @author Sekiro
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
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
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phone");
        String message;
        CustomerDAO customerDAO = new CustomerDAO();
        Validation validation = new Validation();
        if (customerDAO.checkEmailExist(email) == true) {
            message = "This email already exist!";
            request.setAttribute("error", message);
            request.getRequestDispatcher("views/auth/register.jsp").forward(request, response);
            return;
        }
        
        message = validation.validateFirstName(firstName);
        if( message != null){
            request.setAttribute("error", message);
            System.out.println(message);
            request.getRequestDispatcher("views/auth/register.jsp").forward(request, response);
            return;
        }
        
        message = validation.validateLastName(lastName);
        if(message != null){
            request.setAttribute("error", message);
            System.out.println(message);
            request.getRequestDispatcher("views/auth/register.jsp").forward(request, response);
            return;
        }
        
        message = validation.validatePhoneNumber(phoneNumber);
        if(message != null){
            request.setAttribute("error", message);
            System.out.println(message);
            request.getRequestDispatcher("views/auth/register.jsp").forward(request, response);
            return;
        }
        
        if (customerDAO.checkPhoneExist(phoneNumber) == true) {
            message = "This phone number already exist!";
            request.setAttribute("error", message);
            System.out.println(message);
            request.getRequestDispatcher("views/auth/register.jsp").forward(request, response);
            return;
        }
        
        message = "Register successfully. Please Login!";
        customerDAO.insertCustomer(firstName, lastName, email, password, phoneNumber);
        request.setAttribute("Successfuly", message);
        System.out.println(message);
        request.getRequestDispatcher("views/auth/login.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

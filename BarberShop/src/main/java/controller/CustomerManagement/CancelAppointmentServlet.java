
package controller.CustomerManagement;

import babershopDAO.AppointmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Appointment;

/**
 *
 * @author Sekiro
 */
@WebServlet(name = "CancelAppointmentServlet", urlPatterns = {"/CancelAppointmentServlet"})
public class CancelAppointmentServlet extends HttpServlet {

    
    private static final long serialVersionUID = 1L;
    private AppointmentDAO appointmentDAO; // Declare DAO instance

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize the DAO when the servlet starts
        appointmentDAO = new AppointmentDAO(); // Make sure AppointmentDAO has a no-arg constructor or appropriate initialization
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // 1. Basic security check: Ensure a customer is logged in
        //    This check is also done on the JSP, but good to have on the server-side too.
        if (session.getAttribute("customer") == null) {
            session.setAttribute("errorMessage", "Bạn cần đăng nhập để hủy lịch hẹn.");
            response.sendRedirect(request.getContextPath() + "/login"); // Redirect to login
            return;
        }

        // 2. Get appointmentId from the request
        String appointmentIdStr = request.getParameter("appointmentId");
        int appointmentId = -1; // Default invalid ID

        try {
            appointmentId = Integer.parseInt(appointmentIdStr);
        } catch (NumberFormatException e) {
            // Handle invalid ID format
            System.err.println("Invalid appointment ID format: " + appointmentIdStr);
            session.setAttribute("error", "ID lịch hẹn không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/profile"); // Redirect back to profile
            return;
        }

        // 3. Call the DAO method to cancel the appointment
        boolean success = appointmentDAO.cancelAppointment(appointmentId);

        // 4. Set messages and redirect
        if (success) {
            session.setAttribute("message", "Lịch hẹn đã được hủy thành công.");
        } else {
            // This might mean the appointment ID was not found, or a database error occurred.
            // The DAO returns false for both cases.
            session.setAttribute("error", "Không thể hủy lịch hẹn. Vui lòng thử lại hoặc liên hệ hỗ trợ.");
        }

        // Redirect back to the profile page to show the message/error
        response.sendRedirect(request.getContextPath() + "/profile");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Optional: If you want to prevent direct GET access or inform the user
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Chỉ chấp nhận yêu cầu POST để hủy lịch hẹn.");
    }

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.StaffManagement;

import babershopDAO.AppointmentDAO;
import babershopDAO.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import model.Appointment;
import model.Staff;

/**
 *
 * @author Sekiro
 */
@WebServlet(name = "StaffAppointment", urlPatterns = {"/StaffAppointment"})
public class StaffAppointment extends HttpServlet {

 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StaffAppointment</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffAppointment at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private StaffDAO staffDAO;
     private AppointmentDAO appointmentDAO;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Không tạo session mới nếu chưa có

        if (session != null && session.getAttribute("staff") != null) {
            try {
                Staff staff = (Staff) session.getAttribute("staff");
                
                System.out.println("Staff ID từ session: " + staff.getId());

                // Lấy danh sách cuộc hẹn của nhân viên từ DAO
                List<Appointment> appointments = staffDAO.appointmentOfStaff(staff.getId());
                
                for(Appointment a : appointments){
                    System.out.println(a.getId() + " " + a.getCustomerName() + " " + a.getServices() + " " + a.getAppointmentTime());
                }
                // Đặt danh sách cuộc hẹn vào request attribute để JSP có thể truy cập
                request.setAttribute("appointments", appointments);

                // Chuyển tiếp yêu cầu đến trang JSP để hiển thị
                request.getRequestDispatcher("/views/staff/appointment.jsp").forward(request, response);

            } catch (ClassCastException e) {
                // Xử lý trường hợp staffId không phải là Integer trong session
                System.err.println("Lỗi: staffId trong session không phải là Integer. " + e.getMessage());
                response.sendRedirect("login.jsp?error=invalidStaffId"); // Chuyển hướng về trang đăng nhập hoặc lỗi
            } catch (Exception e) {
                // Xử lý các lỗi khác (ví dụ: lỗi DB)
                System.err.println("Lỗi khi lấy danh sách cuộc hẹn cho nhân viên: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect("error.jsp"); // Chuyển hướng đến trang lỗi chung
            }
        } else {
            // Nếu không có staffId trong session, chuyển hướng về trang đăng nhập
            System.out.println("Không tìm thấy staffId trong session. Chuyển hướng về trang đăng nhập.");
            response.sendRedirect("login.jsp?error=notLoggedIn");
        }
    }
    
    
    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize your AppointmentDAO when the servlet starts
        appointmentDAO = new AppointmentDAO();
        staffDAO = new StaffDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set character encoding for Vietnamese input if necessary
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 1. Get parameters from the form
        String appointmentIdStr = request.getParameter("appointmentId");
        String newStatus = request.getParameter("newStatus");

        int appointmentId = -1; // Default to an invalid ID

        try {
            // Convert appointmentId from String to int
            appointmentId = Integer.parseInt(appointmentIdStr);
        } catch (NumberFormatException e) {
            // Handle case where appointmentId is not a valid number
            System.err.println("Lỗi: ID cuộc hẹn không hợp lệ: " + appointmentIdStr);
            response.sendRedirect("StaffAppointment?error=invalidId"); // Redirect back with an error message
            return; // Stop processing
        }

        // 2. Validate inputs
        if (appointmentId > 0 && newStatus != null && !newStatus.trim().isEmpty()) {
            try {
                // 3. Call DAO to update the appointment status in the database
                boolean updated = appointmentDAO.updateAppointmentStatus(appointmentId, newStatus);

                if (updated) {
                    // Update successful
                    System.out.println("✅ Trạng thái cuộc hẹn #" + appointmentId + " đã cập nhật thành: " + newStatus);
                    response.sendRedirect("StaffAppointment?message=statusUpdated"); // Redirect with success message
                } else {
                    // Update failed (e.g., appointmentId not found in DB)
                    System.err.println("❌ Cập nhật trạng thái cuộc hẹn #" + appointmentId + " thất bại.");
                    response.sendRedirect("StaffAppointment?error=updateFailed"); // Redirect with failure message
                }
            } catch (Exception e) {
                // Catch any other unexpected exceptions (e.g., database connection issues)
                System.err.println("❌ Lỗi khi cập nhật trạng thái cuộc hẹn: " + e.getMessage());
                e.printStackTrace(); // Print full stack trace for debugging
                response.sendRedirect("StaffAppointment?error=dbError"); // Redirect with general error
            }
        } else {
            // Missing required parameters
            System.err.println("❌ Thiếu tham số cần thiết để cập nhật trạng thái.");
            response.sendRedirect("StaffAppointment?error=missingParams"); // Redirect with error
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to update appointment status via POST request.";
    }

}

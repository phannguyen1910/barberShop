/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AppointmentManager;

import babershopDAO.AppointmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Sekiro
 */
@WebServlet(name = "UpdateAppointmentStatusServlet", urlPatterns = {"/UpdateAppointmentStatusServlet"})
public class UpdateAppointmentStatusServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateAppointmentStatusServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAppointmentStatusServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");

            // Validate status
            if (status == null || !isValidStatus(status)) {
                out.print("error: Trạng thái không hợp lệ");
                return;
            }

            // Update status in database
            boolean updated = appointmentDAO.updateAppointmentStatus(id, status);
            if (updated) {
                out.print("success");
            } else {
                out.print("error: Không tìm thấy lịch hẹn hoặc lỗi cập nhật");
            }
        } catch (NumberFormatException e) {
            out.print("error: ID không hợp lệ");
        } catch (Exception e) {
            out.print("error: Lỗi server: " + e.getMessage());
            e.printStackTrace();
        } finally {
            out.flush();
        }
    }

    private boolean isValidStatus(String status) {
        return status.equals("pending") || status.equals("confirmed") || 
               status.equals("completed") || status.equals("cancelled");
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

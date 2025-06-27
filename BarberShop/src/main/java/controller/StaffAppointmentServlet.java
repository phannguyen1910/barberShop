/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://.netbeans.org/templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import babershopDAO.AppointmentDAO;
import babershopDAO.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;
import model.Appointment;

/**
 *
 * @author Sekiro
 */
@WebServlet(name = "StaffAppointmentServlet", urlPatterns = {"/StaffAppointmentServlet"})
public class StaffAppointmentServlet extends HttpServlet {

     private StaffDAO staffDAO;
    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        // Khởi tạo StaffDAO và AppointmentDAO
        staffDAO = new StaffDAO();
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy staffId từ query parameter hoặc session (giả sử từ parameter)
            int staffId = Integer.parseInt(request.getParameter("staffId"));

            // Lấy danh sách lịch hẹn từ StaffDAO
            List<Appointment> appointments = staffDAO.appointmentOfStaff(staffId);

            // Đặt danh sách lịch hẹn vào request scope
            request.setAttribute("appointments", appointments);

            // Chuyển tiếp đến JSP
            request.getRequestDispatcher("/views/staff/appointment.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Xử lý lỗi khi staffId không hợp lệ
            request.setAttribute("errorMessage", "ID nhân viên không hợp lệ.");
            request.getRequestDispatcher("/views/staff/appointment.jsp").forward(request, response);
        } catch (Exception e) {
            // Xử lý lỗi chung, log chi tiết
            e.printStackTrace(); // Log lỗi để debug
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi lấy danh sách lịch hẹn: " + e.getMessage());
            request.getRequestDispatcher("/views/staff/appointment.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra xem có phải AJAX request không
        String isAjax = request.getHeader("X-Requested-With");

        if ("XMLHttpRequest".equals(isAjax)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();

            try {
                // Lấy các tham số từ AJAX request
                String action = request.getParameter("action");
                if ("updateStatus".equals(action)) {
                    int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
                    String newStatus = request.getParameter("newStatus");

                    // Chuẩn hóa newStatus để so sánh, loại bỏ khoảng trắng và chuyển thành chữ hoa
                    // Điều này giúp loại bỏ vấn đề phân biệt chữ hoa/thường và khoảng trắng thừa
                    String normalizedNewStatus = (newStatus != null) ? newStatus.trim().toUpperCase() : "";

                    // Định nghĩa các trạng thái hợp lệ (cũng in hoa để so sánh)
                    List<String> validStatuses = Arrays.asList("PENDING", "CONFIRMED", "COMPLETED", "CANCELLED");

                    // Kiểm tra giá trị hợp lệ của newStatus
                    if (newStatus == null || newStatus.isEmpty() || !validStatuses.contains(normalizedNewStatus)) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        out.write("{\"success\": false, \"message\": \"Trạng thái không hợp lệ.\"}");
                        return;
                    }

                    // Cập nhật trạng thái trong database
                    // Sử dụng newStatus gốc nếu database lưu trữ dạng có chữ hoa/thường cụ thể
                    boolean updated = appointmentDAO.updateAppointmentStatus(appointmentId, newStatus);

                    if (updated) {
                        // Trả về thành công với newStatus để đồng bộ
                        out.write("{\"success\": true, \"message\": \"Cập nhật trạng thái thành công.\", \"newStatus\": \"" + newStatus + "\"}");
                    } else {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        out.write("{\"success\": false, \"message\": \"Không thể cập nhật trạng thái.\"}");
                    }
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.write("{\"success\": false, \"message\": \"Hành động không hợp lệ.\"}");
                }
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"success\": false, \"message\": \"ID lịch hẹn không hợp lệ.\"}");
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.write("{\"success\": false, \"message\": \"Lỗi server: " + e.getMessage() + "\"}");
                e.printStackTrace(); // Log lỗi để debug
            } finally {
                out.flush();
            }
        } else {
            // Nếu không phải AJAX, trả về lỗi 400
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Yêu cầu phải là AJAX.");
        }
    }

    @Override
    public void destroy() {
        // Giải phóng tài nguyên nếu cần (hiện tại để trống)
    }
}
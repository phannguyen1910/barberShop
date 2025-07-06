package controller.StaffManagement;

import babershopDAO.AppointmentDAO;
import com.google.gson.Gson; // Import Gson
import com.google.gson.GsonBuilder; // Import GsonBuilder nếu muốn định dạng JSON đẹp hơn
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import model.Appointment;

/**
 * Servlet này cung cấp thông tin về các khung giờ đã bị chiếm của nhân viên
 * vào một ngày cụ thể dưới dạng JSON.
 */
@WebServlet(name = "StaffAvailabilityServlet", urlPatterns = {"/StaffAvailabilityServlet"})
public class StaffAvailabilityServlet extends HttpServlet {

    // Lớp nội bộ để biểu diễn một khung giờ bị chiếm, dễ dàng chuyển đổi sang JSON
    private static class OccupiedTimeSlot {
        String startTime; // HH:mm
        String endTime;   // HH:mm

        public OccupiedTimeSlot(LocalTime startTime, LocalTime endTime) {
            // Định dạng thời gian để dễ đọc ở frontend
            this.startTime = startTime.format(java.time.format.DateTimeFormatter.ofPattern("HH:mm"));
            this.endTime = endTime.format(java.time.format.DateTimeFormatter.ofPattern("HH:mm"));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json"); // Đặt Content-Type là JSON
        response.setCharacterEncoding("UTF-8");      // Đảm bảo mã hóa UTF-8

        PrintWriter out = response.getWriter();
        Gson gson = new GsonBuilder().setPrettyPrinting().create(); // Tạo đối tượng Gson

        int staffId;
        LocalDate appointmentDate;

        try {
            staffId = Integer.parseInt(request.getParameter("staffId"));
            appointmentDate = LocalDate.parse(request.getParameter("appointmentDate"));

            AppointmentDAO appointmentDAO = new AppointmentDAO();
            List<Appointment> staffAppointments = appointmentDAO.getAppointmentsByStaffAndDate(staffId, appointmentDate);

            List<OccupiedTimeSlot> occupiedSlots = new ArrayList<>();
            for (Appointment appt : staffAppointments) {
                LocalDateTime startDateTime = appt.getAppointmentTime();
                // Thời gian kết thúc = thời gian bắt đầu + tổng thời lượng dịch vụ
                LocalDateTime endDateTime = startDateTime.plusMinutes(appt.getTotalServiceDurationMinutes());

                // Chỉ lấy phần giờ và phút
                LocalTime startTime = startDateTime.toLocalTime();
                LocalTime endTime = endDateTime.toLocalTime();

                occupiedSlots.add(new OccupiedTimeSlot(startTime, endTime));
            }

            // Chuyển đổi danh sách các khung giờ bị chiếm thành chuỗi JSON
            String jsonOutput = gson.toJson(occupiedSlots);
            out.print(jsonOutput); // Gửi JSON về client
            System.out.println("Trả về JSON cho lịch trống nhân viên: " + jsonOutput);

        } catch (NumberFormatException | DateTimeParseException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Lỗi 400
            String errorJson = gson.toJson(new ErrorResponse("Tham số không hợp lệ (staffId hoặc appointmentDate).", e.getMessage()));
            out.print(errorJson);
            System.err.println("Lỗi tham số trong StaffAvailabilityServlet: " + e.getMessage());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Lỗi 500
            String errorJson = gson.toJson(new ErrorResponse("Lỗi máy chủ nội bộ khi lấy lịch trống.", e.getMessage()));
            out.print(errorJson);
            System.err.println("Lỗi chung trong StaffAvailabilityServlet: " + e.getMessage());
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }

    // Lớp hỗ trợ để trả về thông báo lỗi dưới dạng JSON
    private static class ErrorResponse {
        String message;
        String details;

        public ErrorResponse(String message, String details) {
            this.message = message;
            this.details = details;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Có thể cấu hình để doPost cũng gọi doGet hoặc xử lý tương tự nếu cần
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Cung cấp thông tin về lịch trống của nhân viên dưới dạng JSON.";
    }
}
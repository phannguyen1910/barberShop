
package controller.StaffManagement;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import babershopDAO.AppointmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Appointment;

@WebServlet(name = "StaffAvailabilityServlet", urlPatterns = {"/StaffAvailabilityServlet"})
public class StaffAvailabilityServlet extends HttpServlet {

    // Lớp nội bộ để biểu diễn một khung giờ bị chiếm, dễ dàng chuyển đổi sang JSON
    private static class OccupiedTimeSlot {
        String startTime; // HH:mm
        String endTime;   // HH:mm

        public OccupiedTimeSlot(LocalTime startTime, LocalTime endTime) {
            // Định dạng thời gian để khớp với HH:mm ở frontend
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

        String staffIdParam = request.getParameter("staffId");
        String appointmentDateParam = request.getParameter("appointmentDate");
        
        System.out.println("staffIdParam" + staffIdParam);
        System.out.println("staffIdParam" + appointmentDateParam);
        // Kiểm tra null/rỗng trước khi parse
        if (staffIdParam == null || staffIdParam.trim().isEmpty() ||
            appointmentDateParam == null || appointmentDateParam.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            String errorJson = gson.toJson(new ErrorResponse("Thiếu staffId hoặc appointmentDate.", "staffId hoặc appointmentDate bị null/rỗng"));
            out.print(errorJson);
            System.err.println("Lỗi tham số trong StaffAvailabilityServlet: staffId hoặc appointmentDate bị null/rỗng");
            out.close();
            return;
        }

        try {
            staffId = Integer.parseInt(staffIdParam);
            appointmentDate = LocalDate.parse(appointmentDateParam);

            AppointmentDAO appointmentDAO = new AppointmentDAO();
            List<Appointment> staffAppointments = appointmentDAO.getAppointmentsByStaffAndDate(staffId, appointmentDate);

            List<OccupiedTimeSlot> occupiedSlots = new ArrayList<>();
            for (Appointment appt : staffAppointments) {
                LocalDateTime startDateTime = appt.getAppointmentTime();
                // Tính thời gian kết thúc bằng cách cộng tổng thời lượng dịch vụ
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
        doGet(request, response); // Gọi lại doGet cho POST
    }

    @Override
    public String getServletInfo() {
        return "Cung cấp thông tin về lịch trống của nhân viên dưới dạng JSON.";
    }
}

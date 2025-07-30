package controller.StaffManagement;

import babershopDAO.WorkScheduleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Staff;
import model.WorkSchedule;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/ScheduleServlet")
public class ScheduleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WorkScheduleDAO workScheduleDAO = new WorkScheduleDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null) {
            sendErrorResponse(response, "Session không tồn tại", HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        Staff staff = (Staff) session.getAttribute("staff");
        if (staff == null || staff.getId() <= 0) {
            sendErrorResponse(response, "Thông tin staff không hợp lệ trong session", HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int staffId = staff.getId();
        String action = request.getParameter("action");
        JSONObject jsonResponse = new JSONObject();

        try {
            switch (action) {
                case "getRegisteredDays":
                    String staffIdStr = request.getParameter("staffId");
                    String yearStr = request.getParameter("year");
                    String monthStr = request.getParameter("month");
                    if (staffIdStr == null || staffIdStr.isEmpty() || yearStr == null || yearStr.isEmpty() || monthStr == null || monthStr.isEmpty()) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        response.getWriter().write("{\"success\":false,\"message\":\"Thiếu tham số!\"}");
                        return;
                    }
                    int id = Integer.parseInt(staffIdStr);
                    int year = Integer.parseInt(yearStr);
                    int month = Integer.parseInt(monthStr);
                    Map<String, String> registeredDays = workScheduleDAO.getRegisteredDaysForStaff(staffId, year, month);
                    jsonResponse.put("data", new JSONObject(registeredDays));
                    break;
                case "getDisallowedDays":
                    jsonResponse.put("disallowedDays", new JSONArray(workScheduleDAO.getDisallowedDays().toArray()));
                    break;
                case "getRegistrations":
                    jsonResponse.put("registrations", new JSONObject(workScheduleDAO.getRegistrations()));
                    break;
                default:
                    sendErrorResponse(response, "Hành động không hợp lệ", HttpServletResponse.SC_BAD_REQUEST);
                    return;
            }
            response.getWriter().write(jsonResponse.toString());
        } catch (Exception e) {
            sendErrorResponse(response, "Lỗi lấy dữ liệu: " + e.getMessage(), HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null) {
            sendErrorResponse(response, "Session không tồn tại", HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        Staff staff = (Staff) session.getAttribute("staff");
        if (staff == null || staff.getId() <= 0) {
            sendErrorResponse(response, "Thông tin staff không hợp lệ trong session", HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int staffId = staff.getId();
        System.out.println("Processing schedule for staffId: " + staffId);

        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        JSONObject jsonResponse = new JSONObject();
        try {
            JSONObject jsonRequest = new JSONObject(sb.toString());
            System.out.println("Received JSON request: " + jsonRequest.toString());

            if (jsonRequest.has("staffId")) {
                int requestStaffId = jsonRequest.getInt("staffId");
                if (requestStaffId != staffId) {
                    sendErrorResponse(response, "staffId trong yêu cầu không khớp với session: " + requestStaffId + " vs " + staffId, HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
            }

            if (workScheduleDAO.getStaffName(staffId) == null) {
                sendErrorResponse(response, "staffId không hợp lệ: " + staffId, HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            JSONArray daysOffArray = jsonRequest.getJSONArray("daysOff");
            if (daysOffArray.length() == 0) {
                sendErrorResponse(response, "Chưa chọn ngày nghỉ nào!", HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            LocalDate firstDay = LocalDate.parse(daysOffArray.getString(0));
            int existingAcceptCount = workScheduleDAO.countStaffAcceptForMonth(staffId, firstDay.getYear(), firstDay.getMonthValue());
            System.out.println("Existing ACCEPT registrations for staff " + staffId + " in month " + firstDay.getMonthValue() + "/" + firstDay.getYear() + ": " + existingAcceptCount);

            int acceptCount = existingAcceptCount;
            boolean allSaved = true;
            List<LocalDate> savedDays = new ArrayList<>();
            List<String> errorMessages = new ArrayList<>();

            for (int i = 0; i < daysOffArray.length(); i++) {
                String dateStr = daysOffArray.getString(i);
                LocalDate workDate = LocalDate.parse(dateStr);

                if (workDate.isBefore(LocalDate.now())) {
                    errorMessages.add("Ngày " + dateStr + " đã qua");
                    allSaved = false;
                    continue;
                }

                if (workDate.getDayOfWeek() == DayOfWeek.SUNDAY) {
                    errorMessages.add("Ngày " + dateStr + " là Chủ nhật");
                    allSaved = false;
                    continue;
                }

                if (workScheduleDAO.getDisallowedDays().contains(workDate)) {
                    errorMessages.add("Ngày " + dateStr + " không được phép");
                    allSaved = false;
                    continue;
                }

                int count = workScheduleDAO.countRegistrationsForDay(workDate);
                if (count >= 2) {
                    errorMessages.add("Ngày " + dateStr + " đã đủ 2 người đăng ký");
                    allSaved = false;
                    continue;
                }

                if (workScheduleDAO.isDuplicateSchedule(staffId, workDate)) {
                    errorMessages.add("Ngày " + dateStr + " đã được đăng ký trước đó");
                    allSaved = false;
                    continue;
                }

                WorkSchedule schedule = new WorkSchedule();
                schedule.setStaffId(staffId);
                schedule.setWorkDate(workDate);
                // Phân loại trạng thái
                if (acceptCount < 4) {
                    schedule.setStatus("accept");
                    acceptCount++;
                } else {
                    schedule.setStatus("pending");
                }

                System.out.println("Attempting to save schedule: staffId=" + staffId + ", date=" + workDate + ", status=" + schedule.getStatus());
                if (workScheduleDAO.addWorkSchedule(schedule)) {
                    savedDays.add(workDate);
                    System.out.println("Successfully saved schedule for " + dateStr);
                } else {
                    errorMessages.add("Không thể lưu ngày " + dateStr);
                    allSaved = false;
                }
            }

            if (allSaved && !savedDays.isEmpty()) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Lịch nghỉ " + savedDays.size() + " ngày đã được lưu thành công!");
            } else if (!savedDays.isEmpty()) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Đã lưu " + savedDays.size() + " ngày thành công. Lỗi: " + String.join(", ", errorMessages));
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Không thể lưu bất kỳ ngày nào. Lỗi: " + String.join(", ", errorMessages));
            }

        } catch (JSONException e) {
            System.out.println("JSON parsing error: " + e.getMessage());
            sendErrorResponse(response, "Định dạng JSON không hợp lệ", HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            System.out.println("Unexpected error in ScheduleServlet: " + e.getMessage());
            sendErrorResponse(response, "Lỗi hệ thống: " + e.getMessage(), HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        response.getWriter().write(jsonResponse.toString());
    }

    private void sendErrorResponse(HttpServletResponse response, String message, int statusCode) throws IOException {
        response.setStatus(statusCode);
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", false);
        jsonResponse.put("message", message);
        response.getWriter().write(jsonResponse.toString());
    }
}
package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.time.LocalDate;
import java.time.DayOfWeek;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;
import babershopDAO.WorkScheduleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Staff;
import model.WorkSchedule;


@WebServlet("/ScheduleServlet")
public class ScheduleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WorkScheduleDAO workScheduleDAO;

    @Override
    public void init() throws ServletException {
        workScheduleDAO = new WorkScheduleDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        Staff staff = (Staff) session.getAttribute("staff");
        if (staff == null) {
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Unauthorized access");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(jsonResponse.toString());
            return;
        }

        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        JSONObject jsonResponse = new JSONObject();
        try {
            JSONObject jsonRequest = new JSONObject(sb.toString());
            int staffId = jsonRequest.getInt("staffId");
            if (staffId != staff.getId()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Invalid staff ID");
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                response.getWriter().write(jsonResponse.toString());
                return;
            }

            JSONArray daysOffArray = jsonRequest.getJSONArray("daysOff");
            if (daysOffArray.length() == 0) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Chưa chọn ngày nghỉ nào!");
                response.getWriter().write(jsonResponse.toString());
                return;
            }

            LocalDate firstDay = LocalDate.parse(daysOffArray.getString(0));
            int existingCount = workScheduleDAO.countStaffRegistrationsForMonth(staffId, firstDay.getYear(), firstDay.getMonthValue());
            if (existingCount + daysOffArray.length() > 4) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Vượt quá giới hạn 4 ngày nghỉ mỗi tháng!");
                response.getWriter().write(jsonResponse.toString());
                return;
            }

            boolean allSaved = true;
            List<LocalDate> savedDays = new ArrayList<>();
            for (int i = 0; i < daysOffArray.length(); i++) {
                String dateStr = daysOffArray.getString(i);
                LocalDate workDate = LocalDate.parse(dateStr);

                if (workDate.isBefore(LocalDate.now()) || workDate.getDayOfWeek() == DayOfWeek.SUNDAY || workScheduleDAO.getDisallowedDays().contains(workDate)) {
                    allSaved = false;
                    continue;
                }

                int count = workScheduleDAO.countRegistrationsForDay(workDate);
                if (count >= 2) {
                    allSaved = false;
                    continue;
                }

                String checkSql = "SELECT COUNT(*) FROM [WorkSchedule] WHERE staffId = ? AND workDate = ? AND status = 'off'";
                try (Connection conn = WorkScheduleDAO.getConnect(); PreparedStatement ps = conn.prepareStatement(checkSql)) {
                    ps.setInt(1, staffId);
                    ps.setObject(2, workDate);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next() && rs.getInt(1) > 0) {
                        allSaved = false;
                        continue;
                    }
                }

                WorkSchedule schedule = new WorkSchedule();
                schedule.setStaffId(staffId);
                schedule.setWorkDate(workDate);
                schedule.setStatus("off");
                if (workScheduleDAO.addWorkSchedule(schedule)) {
                    savedDays.add(workDate);
                } else {
                    allSaved = false;
                }
            }

            if (allSaved && !savedDays.isEmpty()) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Lịch nghỉ đã được lưu thành công!");
            } else if (!savedDays.isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Một số ngày nghỉ không thể lưu do đã đầy hoặc lỗi hệ thống!");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Không thể lưu bất kỳ ngày nghỉ nào!");
            }
        } catch (JSONException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Định dạng JSON không hợp lệ");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            System.out.println("JSON error in ScheduleServlet: " + e.getMessage());
       } catch (SQLException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Lỗi cơ sở dữ liệu");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            System.out.println("Database error in ScheduleServlet: " + e.getMessage());
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Lỗi không xác định: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            System.out.println("Unexpected error in ScheduleServlet: " + e.getMessage());
        }
        response.getWriter().write(jsonResponse.toString());
    }
}
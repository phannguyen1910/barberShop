package controller.StaffManagement;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;
import babershopDAO.WorkScheduleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.WorkSchedule;
import model.Branch; // Thêm import cho Branch

@WebServlet("/ViewScheduleServlet")
public class ViewScheduleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private WorkScheduleDAO workScheduleDAO;

    @Override
    public void init() throws ServletException {
        workScheduleDAO = new WorkScheduleDAO();
        System.out.println("ViewScheduleServlet initialized successfully");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Received request with action: " + request.getParameter("action"));
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            // Forward dữ liệu trực tiếp đến JSP
            try {
                // Lấy danh sách lịch nghỉ
                List<WorkSchedule> schedules = workScheduleDAO.getAllOffSchedules();
                System.out.println("Schedules fetched for forward: " + (schedules != null ? schedules.size() : "null"));
                request.setAttribute("schedules", schedules);

                // Lấy danh sách chi nhánh
                List<Branch> branches = workScheduleDAO.getAllBranches(); // Giả định có phương thức này
                System.out.println("Branches fetched: " + (branches != null ? branches.size() : "null"));
                request.setAttribute("branches", branches);

                request.getRequestDispatcher("/views/admin/viewSchedule.jsp").forward(request, response);
                System.out.println("Forward to JSP successful");
            } catch (Exception e) {
                System.out.println("Error forwarding to JSP: " + e.getMessage());
                response.getWriter().write("Error: Unable to forward to JSP");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
            return;
        }

        // Xử lý AJAX request
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonResponse = new JSONObject();

        try {
            if ("getRegistrations".equals(action)) {
                Map<String, Integer> registrations = workScheduleDAO.getRegistrations();
                jsonResponse.put("data", new JSONObject(registrations));
            } else if ("getDisallowedDays".equals(action)) {
                List<LocalDate> disallowedDays = workScheduleDAO.getDisallowedDays();
                JSONArray daysArray = new JSONArray();
                for (LocalDate day : disallowedDays) {
                    daysArray.put(day.toString());
                }
                jsonResponse.put("data", daysArray);
            } else if ("getRegisteredDays".equals(action)) {
                int staffId = Integer.parseInt(request.getParameter("staffId"));
                int year = Integer.parseInt(request.getParameter("year"));
                int month = Integer.parseInt(request.getParameter("month"));
                Map<String, Integer> registeredDays = workScheduleDAO.getRegisteredDaysForStaff(staffId, year, month);
                jsonResponse.put("data", new JSONObject(registeredDays));
            } else if ("getAllOffSchedules".equals(action)) {
                List<WorkSchedule> schedules = workScheduleDAO.getAllOffSchedules();
                System.out.println("Schedules fetched for AJAX: " + (schedules != null ? schedules.size() : "null"));
                JSONArray schedulesArray = new JSONArray();
                for (WorkSchedule schedule : schedules) {
                    JSONObject obj = new JSONObject();
                    obj.put("id", schedule.getId());
                    obj.put("staffId", schedule.getStaffId());
                    obj.put("workDate", schedule.getWorkDate() != null ? schedule.getWorkDate().toString() : "N/A");
                    obj.put("firstName", schedule.getFirstName() != null ? schedule.getFirstName() : "N/A");
                    obj.put("lastName", schedule.getLastName() != null ? schedule.getLastName() : "N/A");
                    obj.put("status", schedule.getStatus() != null ? schedule.getStatus() : "N/A");
                    obj.put("branch", schedule.getBranch() != null ? schedule.getBranch() : "N/A"); // Đảm bảo branch được bao gồm
                    schedulesArray.put(obj);
                }
                jsonResponse.put("data", schedulesArray);
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Invalid action");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            System.out.println("Error in ViewScheduleServlet: " + e.getMessage());
        }
        response.getWriter().write(jsonResponse.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Gộp xử lý GET và POST
    }
}
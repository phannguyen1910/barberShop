package controller.StaffManagement;

import babershopDAO.AppointmentDAO;
import babershopDAO.StaffDAO;
import model.Staff;
import model.Branch;
import babershopDAO.BranchDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/admin/view-staff")
public class StaffListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            String sort = request.getParameter("sort");
            String branchIdStr = request.getParameter("branchId");
            Integer branchId = branchIdStr != null && !branchIdStr.isEmpty() ? Integer.parseInt(branchIdStr) : null;
            
            List<Staff> staffList = StaffDAO.searchAndSortStaff(name, email, role, sort, branchId);
            AppointmentDAO appointmentDAO = new AppointmentDAO();
            Map<Integer, Integer> bookingCounts = appointmentDAO.getMonthlyCompletedBookingsByStaff ();
// Gắn số booking vào từng nhân viên
for (Staff staff : staffList) {
    int count = bookingCounts.getOrDefault(staff.getId(), 0);
    staff.setMonthlyCompletedBookings(count);
}

// Lấy danh sách chi nhánh để hiển thị trong dropdown
BranchDAO branchDAO = new BranchDAO();
List<Branch> branchList = branchDAO.getAllBranches();
request.setAttribute("branchList", branchList);

request.setAttribute("staffList", staffList);
request.setAttribute("name", name);
request.setAttribute("email", email);
request.setAttribute("role", role);
request.setAttribute("sort", sort);
request.setAttribute("branchId", branchId);

request.getRequestDispatcher("/views/admin/staffManagement.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(StaffListServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}

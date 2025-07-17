package controller.StaffManagement;

import babershopDAO.StaffDAO;
import model.Staff;
import model.Branch;
import babershopDAO.BranchDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/view-staff")
public class StaffListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        String sort = request.getParameter("sort");
        String branchIdStr = request.getParameter("branchId");
        Integer branchId = branchIdStr != null && !branchIdStr.isEmpty() ? Integer.parseInt(branchIdStr) : null;

        List<Staff> staffList = StaffDAO.searchAndSortStaff(name, email, role, sort, branchId);

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
    }
}


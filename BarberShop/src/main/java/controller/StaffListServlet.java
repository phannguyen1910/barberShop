package controller;

import babershopDAO.StaffDAO;
import model.Staff;
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

        List<Staff> staffList = StaffDAO.searchAndSortStaff(name, email, role, sort);

        request.setAttribute("staffList", staffList);
        request.setAttribute("name", name);
        request.setAttribute("email", email);
        request.setAttribute("role", role);
        request.setAttribute("sort", sort);

        request.getRequestDispatcher("/views/admin/staffManagement.jsp").forward(request, response);
    }
}

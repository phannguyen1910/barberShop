/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import babershopDAO.BranchDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Branch;

/**
 *
 * @author Sekiro
 */
@WebServlet(name = "ChooseBranchServlet", urlPatterns = {"/ChooseBranchServlet"})
public class ChooseBranchServlet extends HttpServlet {

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
            out.println("<title>Servlet ChooseBranchServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChooseBranchServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BranchDAO branchDAO = new BranchDAO();
        List<Branch> listBranch = branchDAO.getAllBranches();

        if (listBranch == null) {
            listBranch = new ArrayList<>();
        }

        request.setAttribute("listBranch", listBranch);
        request.getRequestDispatcher("/views/booking/chooseBranch.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Khi người dùng chọn chi nhánh và gửi form từ chooseBranch.jsp
        String branchId = request.getParameter("branchId");
        String branchName = request.getParameter("branchName");

        if (branchId != null && !branchId.isEmpty()) {
            // Chuyển hướng về BookingServlet, kèm theo ID và tên chi nhánh đã chọn
            // Đây là cách bạn truyền dữ liệu về trang booking
            response.sendRedirect(request.getContextPath() + "/BookingServlet?selectedBranchId=" + branchId + "&selectedBranchName=" + branchName);
        } else {
            // Xử lý trường hợp không có chi nhánh nào được chọn
            response.sendRedirect(request.getContextPath() + "/BookingServlet?error=Vui lòng chọn một chi nhánh.");
        }
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

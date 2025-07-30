package controller.CustomerManagement;

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
import java.net.URLEncoder; // Quan trọng: Thêm import này để mã hóa URL
import java.nio.charset.StandardCharsets; // Quan trọng: Thêm import này để chỉ định UTF-8

/**
 *
 * @author Sekiro
 */
@WebServlet(name = "ChooseBranchServlet", urlPatterns = {"/ChooseBranchServlet"})
public class ChooseBranchServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Đây là phần code mẫu mặc định, có thể bỏ qua hoặc giữ lại
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

        // Đảm bảo listBranch không bao giờ là null để tránh lỗi NullPointerException trên JSP
        if (listBranch == null) {
            listBranch = new ArrayList<>();
        }

        // Đặt danh sách chi nhánh vào request scope để JSP có thể truy cập
        request.setAttribute("listBranch", listBranch);
        // Chuyển tiếp yêu cầu và phản hồi đến trang JSP để hiển thị giao diện
        request.getRequestDispatcher("/views/booking/chooseBranch.jsp").forward(request, response);
    }

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String branchId = request.getParameter("branchId");
        String branchName = request.getParameter("branchName");

        // Kiểm tra xem người dùng đã chọn chi nhánh hợp lệ hay chưa
        if (branchId != null && !branchId.isEmpty()) {
            
            String encodedBranchName = URLEncoder.encode(branchName, StandardCharsets.UTF_8.toString());
          
            response.sendRedirect(request.getContextPath() + "/BookingServlet?selectedBranchId=" + branchId + "&selectedBranchName=" + encodedBranchName);
            
        } else {
            String errorMessage = URLEncoder.encode("Vui lòng chọn một chi nhánh.", StandardCharsets.UTF_8.toString());
            response.sendRedirect(request.getContextPath() + "/BookingServlet?error=" + errorMessage);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet để chọn chi nhánh cho quá trình đặt lịch";
    }// </editor-fold>

}
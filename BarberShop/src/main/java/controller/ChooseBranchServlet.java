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
import java.net.URLEncoder; // Quan trọng: Thêm import này để mã hóa URL
import java.nio.charset.StandardCharsets; // Quan trọng: Thêm import này để chỉ định UTF-8

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

    /**
     * Xử lý yêu cầu GET: Hiển thị trang chọn chi nhánh.
     * Đọc danh sách chi nhánh từ cơ sở dữ liệu và chuyển tiếp đến JSP.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException nếu có lỗi servlet cụ thể
     * @throws IOException nếu có lỗi I/O
     */
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

    /**
     * Xử lý yêu cầu POST: Nhận dữ liệu chi nhánh đã chọn từ form.
     * Mã hóa tên chi nhánh và chuyển hướng đến BookingServlet.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException nếu có lỗi servlet cụ thể
     * @throws IOException nếu có lỗi I/O
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy branchId và branchName từ các tham số của request
        // (được gửi từ các trường input hidden trong chooseBranch.jsp)
        String branchId = request.getParameter("branchId");
        String branchName = request.getParameter("branchName");

        // Kiểm tra xem người dùng đã chọn chi nhánh hợp lệ hay chưa
        if (branchId != null && !branchId.isEmpty()) {
            // Quan trọng: Mã hóa branchName trước khi thêm vào URL
            // Điều này giải quyết lỗi "Unicode character cannot be encoded"
            // và đảm bảo các ký tự tiếng Việt có dấu được truyền đúng cách
            String encodedBranchName = URLEncoder.encode(branchName, StandardCharsets.UTF_8.toString());

            // In ra console để gỡ lỗi (có thể xóa sau khi xác nhận hoạt động ổn định)
            System.out.println("Selected Branch ID: " + branchId);
            System.out.println("Original Branch Name: " + branchName);
            System.out.println("Encoded Branch Name: " + encodedBranchName);

            // Chuyển hướng trình duyệt của người dùng đến BookingServlet
            // Truyền selectedBranchId và encodedBranchName như các tham số truy vấn (query parameters)
            response.sendRedirect(request.getContextPath() + "/BookingServlet?selectedBranchId=" + branchId + "&selectedBranchName=" + encodedBranchName);
            
        } else {
            // Nếu không có chi nhánh nào được chọn, chuyển hướng về BookingServlet
            // và truyền một thông báo lỗi đã được mã hóa
            String errorMessage = URLEncoder.encode("Vui lòng chọn một chi nhánh.", StandardCharsets.UTF_8.toString());
            response.sendRedirect(request.getContextPath() + "/BookingServlet?error=" + errorMessage);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet để chọn chi nhánh cho quá trình đặt lịch";
    }// </editor-fold>

}
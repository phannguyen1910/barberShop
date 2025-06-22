package controller;

import babershopDAO.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder; // Import for URL encoding
import java.util.ArrayList;
import java.util.List;
import model.Service;


@WebServlet(name = "ChooseServiceServlet", urlPatterns = {"/ChooseServiceServlet"})
public class ChooseServiceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChooseServiceServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChooseServiceServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ServiceDAO serviceDAO = new ServiceDAO();
        List <Service> services = serviceDAO.getAllService();
        // The debug print loop is fine, but you might want to remove it in production
        for(Service s : services){
            System.out.println("Service: " + s.getName());
        }
        request.setAttribute("services", services);
        request.getRequestDispatcher("/views/service/services.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu dịch vụ đã chọn từ form (JS đã chuẩn bị sẵn)
        String serviceNames = request.getParameter("serviceNames");
        String totalPrice = request.getParameter("totalPrice");

        if (serviceNames != null && !serviceNames.isEmpty()) {
            // Chuyển hướng về BookingServlet, kèm theo danh sách dịch vụ và tổng tiền
            // Cần encode URL để đảm bảo các ký tự đặc biệt trong tên dịch vụ không gây lỗi
            response.sendRedirect(request.getContextPath() + "/BookingServlet?" +
                                  "serviceNames=" + URLEncoder.encode(serviceNames, "UTF-8") +
                                  "&totalPrice=" + URLEncoder.encode(totalPrice, "UTF-8"));
        } else {
            // Xử lý trường hợp không có dịch vụ nào được chọn
            response.sendRedirect(request.getContextPath() + "/BookingServlet?error=" + 
                                  URLEncoder.encode("Vui lòng chọn ít nhất một dịch vụ.", "UTF-8"));
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles service selection.";
    }
}
package controller.ServiceManagement;

import babershopDAO.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Import HttpSession
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays; // Import Arrays for splitting string
import java.util.List;
import model.Account;
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
        List<Service> services = serviceDAO.getAllService();
       
        request.setAttribute("services", services);
        request.getRequestDispatcher("/views/service/services.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(); // Lấy session

        String serviceNames = request.getParameter("serviceNames");
        String totalPriceStr = request.getParameter("totalPrice"); // Đổi tên biến để tránh nhầm lẫn
        String serviceIdsStr = request.getParameter("serviceIds");
        serviceIdsStr = serviceIdsStr.replace("[", "").replace("]", "");
        session.setAttribute("serviceNames", serviceNames);
// Tách chuỗi và chuyển thành mảng int
        String[] parts = serviceIdsStr.split(",");
        int[] serviceIds = new int[parts.length];

        for (int i = 0; i < parts.length; i++) {
            serviceIds[i] = Integer.parseInt(parts[i].trim());
        }
        
        ServiceDAO serviceDAO = new ServiceDAO();
        
        int totalServiceDuration = serviceDAO.calculateTotalServiceDuration(serviceIds);

        if (serviceNames != null && !serviceNames.isEmpty()) {
            // Chuyển serviceNames thành List<String> và lưu vào session
            List<String> selectedServiceNamesList = Arrays.asList(serviceNames.split(","));
            session.setAttribute("selectedServiceNames", new ArrayList<>(selectedServiceNamesList)); // Lưu bản sao

            // Chuyển totalPrice sang Double và lưu vào session
            try {
                double totalPrice = Double.parseDouble(totalPriceStr);
                session.setAttribute("selectedTotalPrice", totalPrice);
                session.setAttribute("totalServiceDuration", totalServiceDuration);
            } catch (NumberFormatException e) {
                // Xử lý lỗi nếu totalPrice không phải là số hợp lệ
                System.err.println("Error parsing totalPrice: " + totalPriceStr + ". Setting to 0.0");
                session.setAttribute("selectedTotalPrice", 0.0);
   
            }
            Account account = (Account) session.getAttribute("account");
            String email = account.getEmail();
            session.setAttribute("customerEmail", email);


            response.sendRedirect(request.getContextPath() + "/BookingServlet");
        } else {
            // Nếu không có dịch vụ nào được chọn, bạn có thể xóa các thuộc tính cũ trong session (nếu có)
            session.removeAttribute("selectedServiceNames");
            session.removeAttribute("selectedTotalPrice");
            session.removeAttribute("totalServiceDuration");
            response.sendRedirect(request.getContextPath() + "/BookingServlet?error="
                    + URLEncoder.encode("Vui lòng chọn ít nhất một dịch vụ.", "UTF-8"));
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles service selection.";
    }
}

package controller;

import babershopDAO.AppointmentDAO;
import babershopDAO.CustomerDAO;
import babershopDAO.HolidayDAO;
import babershopDAO.ServiceDAO;
import babershopDAO.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Service;
import model.Staff;
import model.Voucher;

@WebServlet(name = "BookingServlet", urlPatterns = {"/BookingServlet"})
public class BookingServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BookingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve serviceNames and totalPrice from request parameters

        String error = request.getParameter("error");
        if (error != null) {
            request.setAttribute("error", error);
        }

        String serviceNames = request.getParameter("serviceNames");
        String totalPriceStr = request.getParameter("totalPrice");

        // Validate and parse totalPrice
        double totalPrice = 0;
        try {
            totalPrice = totalPriceStr != null ? Double.parseDouble(totalPriceStr) : 0;
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Tổng giá không hợp lệ.");
            totalPrice = 0;
        }

        // Fetch staff data
        List<Staff> staffs = StaffDAO.getAllStaffs();
        if (staffs == null) {
            staffs = new ArrayList<>();
        }

        // Sanitize staff data to prevent JavaScript errors in booking.jsp
        List<Staff> listOfStaff = new ArrayList<>();
        for (Staff staff : staffs) {
            Staff sanitized = new Staff();
            sanitized.setId(staff.getId());
            sanitized.setAccountId(staff.getAccountId());
            sanitized.setFirstName(escapeJavaScript(staff.getFirstName()));
            sanitized.setLastName(escapeJavaScript(staff.getLastName()));
            sanitized.setImg(escapeJavaScript(staff.getImg() != null ? staff.getImg() : ""));
            listOfStaff.add(sanitized);
        }

        // Set request attributes
        request.setAttribute("listOfStaff", listOfStaff);
        request.setAttribute("serviceNames", serviceNames);
        request.setAttribute("totalPrice", totalPrice);

        // Forward to booking.jsp
        request.getRequestDispatcher("/views/booking/booking.jsp").forward(request, response);
    }

    private String escapeJavaScript(String input) {
        if (input == null) {
            return "";
        }
        return input.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\'", "\\\'")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve form parameters from session and request
            HttpSession session = request.getSession();
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                request.setAttribute("error", "Vui lòng đăng nhập trước khi đặt lịch!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            CustomerDAO customerDAO = new CustomerDAO();
            int customerId = customerDAO.getCustomerIdByAccountId(account.getId());

            // Get form parameters
            int numberOfPeople = Integer.parseInt(request.getParameter("numberOfPeople"));
            String appointmentDateStr = request.getParameter("appointmentDate"); // e.g., "2025-06-08"
            String appointmentTimeStr = request.getParameter("appointmentTime"); // e.g., "11:30"
            int staffId = Integer.parseInt(request.getParameter("staffId"));
            String[] serviceNames = request.getParameterValues("serviceName");
            double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));

            // Validate parameters
            if (serviceNames == null || serviceNames.length == 0) {
                throw new IllegalArgumentException("Vui lòng chọn ít nhất một dịch vụ!");
            }
            if (numberOfPeople <= 0) {
                throw new IllegalArgumentException("Số người phải lớn hơn 0!");
            }
            if (staffId <= 0) {
                throw new IllegalArgumentException("Vui lòng chọn nhân viên!");
            }

            System.out.println(staffId);

            // Initialize DAOs
            ServiceDAO serviceDAO = new ServiceDAO();
            StaffDAO staffDAO = new StaffDAO();
            AppointmentDAO appointmentDAO = new AppointmentDAO();

            // Validate staff
            Staff staff = staffDAO.getStaffById(staffId);
            if (staff == null) {
                throw new IllegalArgumentException("Nhân viên không tồn tại!");
            }
            String staffFullName = staff.getFirstName() + " " + staff.getLastName();

            // Parse date and time
            LocalDate appointmentDate = LocalDate.parse(appointmentDateStr);
            // 🔹 Kiểm tra ngày nghỉ lễ
            HolidayDAO holidayDAO = new HolidayDAO();
          

            LocalTime appointmentTime = LocalTime.parse(appointmentTimeStr);
            LocalDateTime appointmentDateTime = LocalDateTime.of(appointmentDate, appointmentTime);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String dateTime = appointmentDateTime.format(formatter);

            // Get service IDs from names
            List<Integer> serviceIds = new ArrayList<>();
            for (String serviceName : serviceNames) {
                int serviceId = serviceDAO.getServiceIdByName(serviceName.trim());
                if (serviceId == -1) {
                    throw new IllegalArgumentException("Dịch vụ không tồn tại: " + serviceName);
                }
                serviceIds.add(serviceId);
            }

            // Validate total price (optional, for consistency)
            double calculatedTotalPrice = 0;
            for (String serviceName : serviceNames) {
                double feeOfService = serviceDAO.getFeeService(serviceName.trim());
                calculatedTotalPrice += feeOfService * numberOfPeople;
            }
            if (Math.abs(calculatedTotalPrice - totalPrice) < 0.00) { // Allow small floating-point differences
                throw new IllegalArgumentException("Tổng tiền không khớp với dịch vụ và số người!");
            }
            List<Voucher> vouchers = appointmentDAO.showVoucher();
            for (Voucher v : vouchers) {
                System.out.println(v.getCode());
            }

            List<Service> services = serviceDAO.getChoosedService(serviceNames);
            for (Service s : services) {
                System.out.println(s.getId() + " " + s.getName());
            }
            request.setAttribute("customerId", customerId);
            request.setAttribute("staffId", staffId);
            request.setAttribute("dateTime", dateTime);
            request.setAttribute("staffName", staffFullName);
            request.setAttribute("numberOfPeople", numberOfPeople);
            request.setAttribute("listService", services);
            request.setAttribute("totalMoney", calculatedTotalPrice);
            request.setAttribute("vouchers", vouchers);
            request.getRequestDispatcher("/views/booking/confirmation.jsp").forward(request, response);
        } catch (Exception e) {
            String error = URLEncoder.encode(e.getMessage(), "UTF-8");
            response.sendRedirect(request.getContextPath() + "/booking.jsp?error=" + error);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

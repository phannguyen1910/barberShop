package controller.CustomerManagement;

import babershopDAO.AppointmentDAO;
import babershopDAO.BranchDAO;
import babershopDAO.CustomerDAO;
import babershopDAO.HolidayDAO;
import babershopDAO.ServiceDAO;
import babershopDAO.StaffDAO;
import babershopDAO.VoucherDAO;
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
import java.util.Arrays;
import java.util.List;
import model.Account;
import model.Branch;
import model.Service;
import model.Staff;
import model.Voucher;

@WebServlet(name = "BookingServlet", urlPatterns = {"/BookingServlet"})
public class BookingServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Đảm bảo response cũng sử dụng UTF-8
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
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
        // Rất quan trọng: Thiết lập mã hóa UTF-8 cho request và response
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();

        // 1. Xử lý thông báo lỗi
        String error = request.getParameter("error");
        if (error != null) {
            request.setAttribute("error", error);
        }

        // 2. Xử lý Chi nhánh đã chọn
        String selectedBranchIdParam = request.getParameter("selectedBranchId");
        String selectedBranchNameParam = request.getParameter("selectedBranchName");

        String sessionBranchId = (String) session.getAttribute("selectedBranchId");
        String sessionBranchName = (String) session.getAttribute("selectedBranchName");

        if (selectedBranchIdParam != null && !selectedBranchIdParam.isEmpty()) {
            session.setAttribute("selectedBranchId", selectedBranchIdParam);
            session.setAttribute("selectedBranchName", selectedBranchNameParam);
            request.setAttribute("preSelectedBranchId", selectedBranchIdParam);
            request.setAttribute("preSelectedBranchName", selectedBranchNameParam);
            System.out.println("Session updated with new branch: " + selectedBranchNameParam + " (ID: " + selectedBranchIdParam + ")");
        } else {
            request.setAttribute("preSelectedBranchId", sessionBranchId);
            request.setAttribute("preSelectedBranchName", sessionBranchName);
            System.out.println("Retrieved from session: " + sessionBranchName + " (ID: " + sessionBranchId + ")");
        }

        // 3. Xử lý Dịch vụ đã chọn
        String serviceNamesParam = request.getParameter("serviceNames");
        String totalPriceStrParam = request.getParameter("totalPrice");

        List<String> sessionServiceNames = (List<String>) session.getAttribute("selectedServiceNames");
        Double sessionTotalPriceObj = (Double) session.getAttribute("selectedTotalPrice");

        List<String> currentServiceNamesList = (sessionServiceNames != null) ? new ArrayList<>(sessionServiceNames) : new ArrayList<>();
        double currentTotalPrice = (sessionTotalPriceObj != null) ? sessionTotalPriceObj.doubleValue() : 0.0;

        if (serviceNamesParam != null) { 
            if (!serviceNamesParam.isEmpty()) {
                currentServiceNamesList = Arrays.asList(serviceNamesParam.split(","));
            } else {
                currentServiceNamesList = new ArrayList<>(); 
            }
            session.setAttribute("selectedServiceNames", new ArrayList<>(currentServiceNamesList));

            try {
                currentTotalPrice = Double.parseDouble(totalPriceStrParam);
                session.setAttribute("selectedTotalPrice", currentTotalPrice);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Tổng giá dịch vụ không hợp lệ. Đã đặt lại về 0.");
                currentTotalPrice = 0.0;
                session.setAttribute("selectedTotalPrice", 0.0);
          
            }
            System.out.println("Session updated with new services from Request: " + currentServiceNamesList + " (Total: " + currentTotalPrice + ")");
        } else {
            System.out.println("No new services from Request. Using session data: " + currentServiceNamesList + " (Total: " + currentTotalPrice + ")");
        }

        request.setAttribute("serviceNames", String.join(",", currentServiceNamesList));
        request.setAttribute("totalPrice", currentTotalPrice);

        // 4. Lấy danh sách nhân viên
        StaffDAO staffDAO = new StaffDAO();
        List<Staff> staffs = staffDAO.getAllStaffs();
        if (staffs == null) {
            staffs = new ArrayList<>();
        }

        List<Staff> listOfStaff = new ArrayList<>();
        for (Staff staff : staffs) {
            Staff sanitized = new Staff();
            sanitized.setId(staff.getId());
            sanitized.setAccountId(staff.getAccountId());
            sanitized.setFirstName(escapeJavaScript(staff.getFirstName()));
            sanitized.setLastName(escapeJavaScript(staff.getLastName()));
            sanitized.setImg(escapeJavaScript(staff.getImg() != null ? staff.getImg() : ""));
            sanitized.setBranchId(staff.getBranchId());
            listOfStaff.add(sanitized);
        }

        request.setAttribute("listOfStaff", listOfStaff);
        request.getRequestDispatcher("/views/booking/booking.jsp").forward(request, response);
    }

    private String escapeJavaScript(String text) {
        if (text == null) {
            return "";
        }
        return text.replace("\\", "\\\\")
                .replace("'", "\\'")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Rất quan trọng: Thiết lập mã hóa UTF-8 cho request và response
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        try {
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                String error = URLEncoder.encode("Vui lòng đăng nhập trước khi đặt lịch!", "UTF-8");
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=" + error);
                return;
            }
            CustomerDAO customerDAO = new CustomerDAO();
            int customerId = customerDAO.getCustomerIdByAccountId(account.getId());

            String appointmentDateStr = request.getParameter("appointmentDate");
            String appointmentTimeStr = request.getParameter("appointmentTime");
            int staffId = Integer.parseInt(request.getParameter("staffId"));

            List<String> serviceNamesList = (List<String>) session.getAttribute("selectedServiceNames");
            if (serviceNamesList == null || serviceNamesList.isEmpty()) {
                throw new IllegalArgumentException("Vui lòng chọn ít nhất một dịch vụ!");
            }
            String[] serviceNames = serviceNamesList.toArray(new String[0]);

            double totalPrice = (Double) session.getAttribute("selectedTotalPrice") != null ? (Double) session.getAttribute("selectedTotalPrice") : 0;
            if (totalPrice <= 0) {
                throw new IllegalArgumentException("Tổng giá tiền không hợp lệ.");
            }

            if (staffId <= 0) {
                throw new IllegalArgumentException("Vui lòng chọn nhân viên!");
            }

            System.out.println("Booking POST received - Staff ID: " + staffId);

            ServiceDAO serviceDAO = new ServiceDAO();
            StaffDAO staffDAO = new StaffDAO();
            AppointmentDAO appointmentDAO = new AppointmentDAO();

            Staff staff = staffDAO.getStaffById(staffId);
            if (staff == null) {
                throw new IllegalArgumentException("Nhân viên không tồn tại!");
            }
            String staffFullName = staff.getFirstName() + " " + staff.getLastName();

            LocalDate appointmentDate = LocalDate.parse(appointmentDateStr);
            // THÊM LOGIC KIỂM TRA NGÀY NGHỈ LỄ TẠI ĐÂY (NẾU CÓ)
            HolidayDAO holidayDAO = new HolidayDAO(); 
            // if (holidayDAO.isHoliday(appointmentDate)) {
            //     throw new IllegalArgumentException("Ngày " + appointmentDateStr + " là ngày nghỉ lễ. Vui lòng chọn ngày khác!");
            // }


            LocalTime appointmentTime = LocalTime.parse(appointmentTimeStr);
            LocalDateTime appointmentDateTime = LocalDateTime.of(appointmentDate, appointmentTime);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String dateTime = appointmentDateTime.format(formatter);

            List<Service> services = serviceDAO.getChoosedService(serviceNames);
            if (services.isEmpty()) {
                throw new IllegalArgumentException("Dịch vụ đã chọn không hợp lệ hoặc không tồn tại.");
            }

            VoucherDAO voucherDAO = new VoucherDAO();
            List<Voucher> vouchers = voucherDAO.showVoucher();

            request.setAttribute("customerId", customerId);
            request.setAttribute("staffId", staffId);
            request.setAttribute("dateTime", dateTime);
            request.setAttribute("staffName", staffFullName);
            request.setAttribute("listService", services);
            request.setAttribute("totalMoney", totalPrice);
            request.setAttribute("vouchers", vouchers);

        
            session.removeAttribute("selectedBranchName");
            session.removeAttribute("selectedServiceNames");
            session.removeAttribute("selectedTotalPrice");

            request.getRequestDispatcher("/views/booking/confirmation.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            String error = URLEncoder.encode(e.getMessage(), "UTF-8");
            response.sendRedirect(request.getContextPath() + "/BookingServlet?error=" + error);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles barbershop booking process.";
    }
}
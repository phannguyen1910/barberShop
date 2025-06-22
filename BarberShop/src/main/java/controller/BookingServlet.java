package controller;

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
import java.util.Arrays; // Import this
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
    HttpSession session = request.getSession();

    // 1. Xử lý thông báo lỗi
    String error = request.getParameter("error");
    if (error != null) {
        request.setAttribute("error", error);
    }

    // 2. Xử lý Chi nhánh đã chọn
    String selectedBranchIdParam = request.getParameter("selectedBranchId");
    String selectedBranchNameParam = request.getParameter("selectedBranchName");

    // Lấy giá trị chi nhánh từ session trước
    String sessionBranchId = (String) session.getAttribute("selectedBranchId");
    String sessionBranchName = (String) session.getAttribute("selectedBranchName");

    // Nếu có tham số chi nhánh mới từ request, ưu tiên nó và lưu vào session
    if (selectedBranchIdParam != null && !selectedBranchIdParam.isEmpty()) {
        session.setAttribute("selectedBranchId", selectedBranchIdParam);
        session.setAttribute("selectedBranchName", selectedBranchNameParam);
        // Cập nhật giá trị sẽ dùng trong request attribute
        request.setAttribute("preSelectedBranchId", selectedBranchIdParam);
        request.setAttribute("preSelectedBranchName", selectedBranchNameParam);
        System.out.println("Session updated with new branch: " + selectedBranchNameParam + " (ID: " + selectedBranchIdParam + ")");
    } else {
        // Nếu không có tham số mới, sử dụng giá trị từ session
        request.setAttribute("preSelectedBranchId", sessionBranchId);
        request.setAttribute("preSelectedBranchName", sessionBranchName);
        System.out.println("Retrieved from session: " + sessionBranchName + " (ID: " + sessionBranchId + ")");
    }

    // 3. Xử lý Dịch vụ đã chọn
    String serviceNamesParam = request.getParameter("serviceNames"); // e.g., "ServiceA,ServiceB"
    String totalPriceStrParam = request.getParameter("totalPrice");   // e.g., "150000.0"

    // Lấy giá trị dịch vụ từ session trước
    List<String> sessionServiceNames = (List<String>) session.getAttribute("selectedServiceNames");
    Double sessionTotalPriceObj = (Double) session.getAttribute("selectedTotalPrice");
    
    // Khởi tạo giá trị mặc định nếu chưa có trong session
    List<String> currentServiceNamesList = (sessionServiceNames != null) ? new ArrayList<>(sessionServiceNames) : new ArrayList<>();
    double currentTotalPrice = (sessionTotalPriceObj != null) ? sessionTotalPriceObj.doubleValue() : 0.0;

    // Nếu có tham số dịch vụ mới từ request, ưu tiên nó và lưu vào session
    if (serviceNamesParam != null && !serviceNamesParam.isEmpty()) {
        currentServiceNamesList = Arrays.asList(serviceNamesParam.split(","));
        session.setAttribute("selectedServiceNames", new ArrayList<>(currentServiceNamesList)); // Lưu bản sao
        
        try {
            currentTotalPrice = Double.parseDouble(totalPriceStrParam);
            session.setAttribute("selectedTotalPrice", currentTotalPrice);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Tổng giá dịch vụ không hợp lệ. Đã đặt lại về 0.");
            currentTotalPrice = 0.0;
            session.setAttribute("selectedTotalPrice", 0.0);
        }
        System.out.println("Session updated with new services from Request: " + currentServiceNamesList + " (Total: " + currentTotalPrice + ")");
    } else if (serviceNamesParam != null && serviceNamesParam.isEmpty()) {
        // Trường hợp người dùng gửi params rỗng, tức là họ bỏ chọn hết dịch vụ
        currentServiceNamesList = new ArrayList<>(); // Đặt lại là rỗng
        currentTotalPrice = 0.0; // Đặt lại tổng tiền về 0
        session.setAttribute("selectedServiceNames", currentServiceNamesList);
        session.setAttribute("selectedTotalPrice", currentTotalPrice);
        System.out.println("Session updated: All services removed. (Total: " + currentTotalPrice + ")");
    } else {
        // Nếu không có tham số dịch vụ mới từ request, và cũng không có trong session, dùng giá trị mặc định (list rỗng, 0.0)
        // Các biến currentServiceNamesList và currentTotalPrice đã được khởi tạo từ session hoặc mặc định ở trên
        System.out.println("No new services from Request. Using session data: " + currentServiceNamesList + " (Total: " + currentTotalPrice + ")");
    }

    // Đặt các thuộc tính vào request để JSP hiển thị
    request.setAttribute("serviceNames", String.join(",", currentServiceNamesList)); // Convert list back to comma-separated string
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
        HttpSession session = request.getSession();
        try {
            // Lấy thông tin tài khoản từ session
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                request.setAttribute("error", "Vui lòng đăng nhập trước khi đặt lịch!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            CustomerDAO customerDAO = new CustomerDAO();
            int customerId = customerDAO.getCustomerIdByAccountId(account.getId());

            // Lấy các thông số từ form
            int numberOfPeople = Integer.parseInt(request.getParameter("numberOfPeople"));
            String appointmentDateStr = request.getParameter("appointmentDate");
            String appointmentTimeStr = request.getParameter("appointmentTime");
            int staffId = Integer.parseInt(request.getParameter("staffId"));
            
            // Lấy serviceNames và totalPrice từ session, không phải từ request nữa
            List<String> serviceNamesList = (List<String>) session.getAttribute("selectedServiceNames");
            if (serviceNamesList == null || serviceNamesList.isEmpty()) {
                throw new IllegalArgumentException("Vui lòng chọn ít nhất một dịch vụ!");
            }
            String[] serviceNames = serviceNamesList.toArray(new String[0]);
            
            double totalPrice = (Double) session.getAttribute("selectedTotalPrice") != null ? (Double) session.getAttribute("selectedTotalPrice") : 0;
            if (totalPrice <= 0) { // Should not be 0 unless no services selected
                throw new IllegalArgumentException("Tổng giá tiền không hợp lệ.");
            }

            // Validate parameters
            if (numberOfPeople <= 0) {
                throw new IllegalArgumentException("Số người phải lớn hơn 0!");
            }
            if (staffId <= 0) {
                throw new IllegalArgumentException("Vui lòng chọn nhân viên!");
            }

            System.out.println("Booking POST received - Staff ID: " + staffId);

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
            // 🔹 Kiểm tra ngày nghỉ lễ (holiday check remains here, potentially using HolidayDAO)
            HolidayDAO holidayDAO = new HolidayDAO(); // Added this line for clarity if you implement the check

            LocalTime appointmentTime = LocalTime.parse(appointmentTimeStr);
            LocalDateTime appointmentDateTime = LocalDateTime.of(appointmentDate, appointmentTime);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String dateTime = appointmentDateTime.format(formatter);

            // Get service objects from names (using the list from session)
            List<Service> services = serviceDAO.getChoosedService(serviceNames);
            if (services.isEmpty()) {
                 throw new IllegalArgumentException("Dịch vụ đã chọn không hợp lệ hoặc không tồn tại.");
            }

            // Validate total price (optional, for consistency) - already taken from session
            // Recalculate to double-check (good practice)
            double recalculatedTotalPrice = 0;
            for (Service s : services) {
                recalculatedTotalPrice += s.getPrice() * numberOfPeople;
            }
            // Use a small epsilon for floating point comparison
            if (Math.abs(recalculatedTotalPrice - totalPrice) > 0.01) { 
                System.err.println("Price mismatch: Recalculated=" + recalculatedTotalPrice + ", Session=" + totalPrice);
                throw new IllegalArgumentException("Tổng tiền không khớp với dịch vụ và số người! Vui lòng chọn lại dịch vụ.");
            }
            
            // Lấy thông tin voucher
            VoucherDAO voucherDAO = new VoucherDAO();
            List<Voucher> vouchers = voucherDAO.showVoucher();

            // Đặt các thuộc tính vào request để chuyển tiếp tới confirmation.jsp
            request.setAttribute("customerId", customerId);
            request.setAttribute("staffId", staffId);
            request.setAttribute("dateTime", dateTime);
            request.setAttribute("staffName", staffFullName);
            request.setAttribute("numberOfPeople", numberOfPeople);
            request.setAttribute("listService", services);
            request.setAttribute("totalMoney", recalculatedTotalPrice); // Use recalculated total
            request.setAttribute("vouchers", vouchers);
            
            // Xóa các thuộc tính session liên quan đến booking để chuẩn bị cho lần đặt mới
   
            session.removeAttribute("selectedBranchName");
            session.removeAttribute("selectedServiceNames");
            session.removeAttribute("selectedTotalPrice");

            request.getRequestDispatcher("/views/booking/confirmation.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // For debugging
            String error = URLEncoder.encode(e.getMessage(), "UTF-8");
            // Redirect back to BookingServlet, which will now display the error and try to retrieve previous choices from session
            response.sendRedirect(request.getContextPath() + "/BookingServlet?error=" + error);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles barbershop booking process.";
    }
}
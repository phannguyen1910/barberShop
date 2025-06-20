package AppointmentManager;

import babershopDAO.AppointmentDAO; // Thay thế bằng đường dẫn tới AppointmentDAO của bạn
import babershopDAO.CustomerDAO;   // Thay thế bằng đường dẫn tới CustomerDAO của bạn
import babershopDAO.ServiceDAO;    // Thay thế bằng đường dẫn tới ServiceDAO của bạn
import babershopDAO.StaffDAO;      // Thay thế bằng đường dẫn tới StaffDAO của bạn

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException; // Để xử lý lỗi JSON parse

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader; // Để đọc request body
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException; // Để xử lý lỗi parse ngày giờ
import java.util.ArrayList; // Để khởi tạo List rỗng nếu cần
import java.util.List;
import java.util.stream.Collectors; // Cần thiết cho Java 8+ Stream API (khi dùng asList().stream())

import model.Appointment; // Thay thế bằng đường dẫn tới Model Appointment của bạn
import model.Customer;    // Thay thế bằng đường dẫn tới Model Customer của bạn
import model.Service;     // Thay thế bằng đường dẫn tới Model Service của bạn
import model.Staff;       // Thay thế bằng đường dẫn tới Model Staff của bạn

@WebServlet(name = "AddAppointmentServlet", urlPatterns = {"/AddAppointmentServlet"}) // Đặt tên và URL pattern nhất quán
public class AddAppointmentServlet extends HttpServlet {

    private Gson gson = new Gson(); // Khởi tạo Gson một lần duy nhất
    private AppointmentDAO appointmentDAO;
    private CustomerDAO customerDAO;
    private StaffDAO staffDAO;
    private ServiceDAO serviceDAO;

    // Phương thức init() được gọi một lần khi Servlet được khởi tạo
    @Override
    public void init() throws ServletException {
        super.init();
        appointmentDAO = new AppointmentDAO();
        customerDAO = new CustomerDAO();
        staffDAO = new StaffDAO();
        serviceDAO = new ServiceDAO();
    }

    // Phương thức doGet() để chuẩn bị dữ liệu và forward đến JSP
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu từ các DAO để gửi sang JSP
        List<Appointment> appointments = appointmentDAO.getAllAppointmentsWithDetails(); // Lấy tất cả lịch hẹn với chi tiết
        List<Service> services = serviceDAO.getAllService(); // Lấy tất cả dịch vụ
        List<Customer> customers = customerDAO.getAllCustomerInformation(); // Lấy tất cả thông tin khách hàng (bao gồm SĐT, email từ Account)
        List<Staff> staffs = staffDAO.getAllStaffs(); // Lấy tất cả thông tin nhân viên

        // Đặt dữ liệu vào request attribute để JSP có thể truy cập
        request.setAttribute("listCustomer", customers);
        request.setAttribute("listStaff", staffs);
        request.setAttribute("listAppointment", appointments);
        request.setAttribute("listService", services);

        // Forward request đến trang JSP để hiển thị giao diện
        request.getRequestDispatcher("/views/admin/appointmentManagement.jsp").forward(request, response);
    }

    // Phương thức doPost() để nhận dữ liệu từ form thêm lịch hẹn và xử lý lưu vào DB
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Cấu hình phản hồi HTTP là JSON và UTF-8
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter(); // Lấy PrintWriter để ghi phản hồi JSON
        JsonObject jsonResponse = new JsonObject(); // Đối tượng JSON để xây dựng phản hồi

        // Log cho mục đích debug trên server console
        System.out.println("\n--- AddAppointmentServlet: Starting POST Request ---");

        try {
            // 1. Đọc toàn bộ JSON body từ request
            StringBuilder sb = new StringBuilder();
            try (BufferedReader reader = request.getReader()) { // Sử dụng try-with-resources cho BufferedReader
                String line;
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }
            String jsonBody = sb.toString();

            // Log JSON body nhận được để kiểm tra
            System.out.println("Received JSON body: " + jsonBody);

            // 2. Kiểm tra nếu JSON body rỗng hoặc không hợp lệ (trước khi parse)
            if (jsonBody == null || jsonBody.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "JSON body rỗng hoặc không hợp lệ. Vui lòng kiểm tra dữ liệu gửi đi.");
                System.err.println("Error: JSON body is empty or invalid.");
                return; // Thoát sớm nếu dữ liệu đầu vào không hợp lệ
            }

            // 3. Parse JSON string thành JsonObject
            JsonObject receivedData = null;
            try {
                receivedData = gson.fromJson(jsonBody, JsonObject.class);
            } catch (JsonSyntaxException e) {
                // Xử lý lỗi cú pháp JSON
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Lỗi cú pháp JSON: Dữ liệu gửi lên không đúng định dạng JSON.");
                System.err.println("JSON Parsing Error: " + e.getMessage());
                e.printStackTrace();
                return; // Thoát sớm
            }

            // 4. Trích xuất và chuyển đổi dữ liệu từ JsonObject
            int customerId;
            int staffId;
            String appointmentTimeStr;
            LocalDateTime appointmentDateTime;
            int numberOfPeople;
            List<Integer> serviceIds = new ArrayList<>(); // Khởi tạo List rỗng để tránh NullPointerException

            try {
                // Lấy customerId (kiểm tra sự tồn tại và kiểu dữ liệu)
                if (receivedData.has("customerId") && receivedData.get("customerId").isJsonPrimitive()) {
                    customerId = receivedData.get("customerId").getAsInt();
                } else {
                    throw new IllegalArgumentException("Trường 'customerId' bị thiếu hoặc sai định dạng.");
                }

                // Lấy staffId
                if (receivedData.has("staffId") && receivedData.get("staffId").isJsonPrimitive()) {
                    staffId = receivedData.get("staffId").getAsInt();
                } else {
                    throw new IllegalArgumentException("Trường 'staffId' bị thiếu hoặc sai định dạng.");
                }

                // Lấy appointmentTime (String) và chuyển đổi sang LocalDateTime
                if (receivedData.has("appointmentTime") && receivedData.get("appointmentTime").isJsonPrimitive()) {
                    appointmentTimeStr = receivedData.get("appointmentTime").getAsString();
                    try {
                        appointmentDateTime = LocalDateTime.parse(appointmentTimeStr);
                    } catch (DateTimeParseException e) {
                        throw new IllegalArgumentException("Định dạng 'appointmentTime' không hợp lệ. Vui lòng sử dụng định dạng YYYY-MM-DDTHH:MM.");
                    }
                } else {
                    throw new IllegalArgumentException("Trường 'appointmentTime' bị thiếu hoặc sai định dạng.");
                }

                // Lấy numberOfPeople
                if (receivedData.has("numberOfPeople") && receivedData.get("numberOfPeople").isJsonPrimitive()) {
                    numberOfPeople = receivedData.get("numberOfPeople").getAsInt();
                } else {
                    throw new IllegalArgumentException("Trường 'numberOfPeople' bị thiếu hoặc sai định dạng.");
                }

                // Lấy serviceIds (là một mảng JSON)
                if (receivedData.has("serviceIds") && receivedData.get("serviceIds").isJsonArray()) {
                    // Chuyển đổi JsonArray sang List<Integer> an toàn bằng Stream API
                    serviceIds = receivedData.getAsJsonArray("serviceIds").asList().stream()
                            .map(jsonElement -> jsonElement.getAsInt())
                            .collect(Collectors.toList());
                } else {
                    throw new IllegalArgumentException("Trường 'serviceIds' bị thiếu hoặc sai định dạng.");
                }

                // Log các giá trị đã parse được
                System.out.println("Parsed data: CustomerID=" + customerId + ", StaffID=" + staffId
                        + ", ApptTime=" + appointmentDateTime + ", NumPeople=" + numberOfPeople
                        + ", ServiceIDs=" + serviceIds);

                System.out.println("--- AddAppointmentServlet: doPost started ---"); // DEBUG này
                // ... các dòng parse JSON ...
                System.out.println("DEBUG: All JSON data parsed successfully. Calling DAO..."); // DEBUG này
                boolean success = appointmentDAO.addAppointmentByAdmin(customerId, staffId, appointmentDateTime, numberOfPeople, serviceIds);
                System.out.println("DEBUG: DAO addAppointment returned: " + success); // DEBUG này

                // 6. Chuẩn bị phản hồi JSON dựa trên kết quả DAO
                if (success) {
                    jsonResponse.addProperty("success", true);
                    jsonResponse.addProperty("message", "Thêm lịch hẹn thành công!");
                    System.out.println("✅ Add Appointment successful for customerId: " + customerId);
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Có lỗi xảy ra khi thêm lịch hẹn vào cơ sở dữ liệu. Vui lòng kiểm tra log server.");
                    System.err.println("❌ Add Appointment failed for customerId: " + customerId + ". DAO returned false.");
                }

            } catch (IllegalArgumentException e) {
                // Xử lý lỗi validation dữ liệu (thiếu trường, sai định dạng)
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Dữ liệu đầu vào không hợp lệ: " + e.getMessage());
                System.err.println("Input Data Validation Error: " + e.getMessage());
                e.printStackTrace();
            } catch (Exception e) {
                // Xử lý các lỗi chung khác (ví dụ: lỗi từ DAO như SQLException)
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Lỗi server nội bộ: " + e.getMessage());
                System.err.println("Server Internal Error (during DAO call or other processing): " + e.getMessage());
                e.printStackTrace(); // In ra full stack trace để debug
            }

        } finally {
            // Luôn trả về phản hồi JSON cuối cùng
            out.print(gson.toJson(jsonResponse));
            out.flush(); // Đẩy dữ liệu ra ngay lập tức
            out.close(); // Đóng PrintWriter
            System.out.println("--- AddAppointmentServlet: Finished POST Request ---\n");
        }
    }

    // Các phương thức life-cycle khác của Servlet (không cần thay đổi)
    @Override
    public String getServletInfo() {
        return "Servlet for adding new appointments";
    }

    // Ghi chú: Phương thức processRequest() mặc định của NetBeans không được gọi
    // nếu bạn override doGet/doPost. Nó có thể được xóa hoặc giữ nguyên.
    // protected void processRequest(...) {}
}

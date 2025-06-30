package controller.AppointmentManagement;

import babershopDAO.AppointmentDAO;
import babershopDAO.CustomerDAO;
import babershopDAO.ServiceDAO;
import babershopDAO.StaffDAO;
import babershopDAO.BranchDAO; // Import BranchDAO

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import model.Appointment;
import model.Customer;
import model.Service;
import model.Staff;
import model.Branch; // Import Branch model

@WebServlet(name = "AddAppointmentServlet", urlPatterns = {"/AddAppointmentServlet"})
public class AddAppointmentServlet extends HttpServlet {

    private Gson gson = new Gson();
    private AppointmentDAO appointmentDAO;
    private CustomerDAO customerDAO;
    private StaffDAO staffDAO;
    private ServiceDAO serviceDAO;
    private BranchDAO branchDAO; // Declare BranchDAO

    @Override
    public void init() throws ServletException {
        super.init();
        appointmentDAO = new AppointmentDAO();
        customerDAO = new CustomerDAO();
        staffDAO = new StaffDAO();
        serviceDAO = new ServiceDAO();
        branchDAO = new BranchDAO(); // Initialize BranchDAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Appointment> appointments = appointmentDAO.getAllAppointmentsWithDetails();
        List<Service> services = serviceDAO.getAllService();
        List<Customer> customers = customerDAO.getAllCustomerInformation();
        List<Staff> staffs = staffDAO.getAllStaffs();
        List<Branch> branches = branchDAO.getAllBranches(); // Get all branches

        request.setAttribute("listCustomer", customers);
        request.setAttribute("listStaff", staffs);
        request.setAttribute("listAppointment", appointments);
        request.setAttribute("listService", services);
        request.setAttribute("branchList", branches); // Add branchList to request scope

        request.getRequestDispatcher("/views/admin/appointmentManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();

        System.out.println("\n--- AddAppointmentServlet: Starting POST Request ---");

        try {
            StringBuilder sb = new StringBuilder();
            try (BufferedReader reader = request.getReader()) {
                String line;
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }
            String jsonBody = sb.toString();

            System.out.println("Received JSON body: " + jsonBody);

            if (jsonBody == null || jsonBody.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "JSON body rỗng hoặc không hợp lệ. Vui lòng kiểm tra dữ liệu gửi đi.");
                System.err.println("Error: JSON body is empty or invalid.");
                out.print(gson.toJson(jsonResponse));
                out.flush();
                out.close();
                return;
            }

            JsonObject receivedData = null;
            try {
                receivedData = gson.fromJson(jsonBody, JsonObject.class);
            } catch (JsonSyntaxException e) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Lỗi cú pháp JSON: Dữ liệu gửi lên không đúng định dạng JSON.");
                System.err.println("JSON Parsing Error: " + e.getMessage());
                e.printStackTrace();
                out.print(gson.toJson(jsonResponse));
                out.flush();
                out.close();
                return;
            }

            int customerId;
            int staffId;
            String appointmentTimeStr;
            LocalDateTime appointmentDateTime;
 
            int branchId; // Added
            List<Integer> serviceIds = new ArrayList<>();

            try {
                if (receivedData.has("customerId") && receivedData.get("customerId").isJsonPrimitive()) {
                    customerId = receivedData.get("customerId").getAsInt();
                } else {
                    throw new IllegalArgumentException("Trường 'customerId' bị thiếu hoặc sai định dạng.");
                }

                if (receivedData.has("staffId") && receivedData.get("staffId").isJsonPrimitive()) {
                    staffId = receivedData.get("staffId").getAsInt();
                } else {
                    throw new IllegalArgumentException("Trường 'staffId' bị thiếu hoặc sai định dạng.");
                }

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

    
             

                // Added parsing for branchId
                if (receivedData.has("branchId") && receivedData.get("branchId").isJsonPrimitive()) {
                    branchId = receivedData.get("branchId").getAsInt();
                } else {
                    throw new IllegalArgumentException("Trường 'branchId' bị thiếu hoặc sai định dạng.");
                }


                if (receivedData.has("serviceIds") && receivedData.get("serviceIds").isJsonArray()) {
                    serviceIds = receivedData.getAsJsonArray("serviceIds").asList().stream()
                            .map(jsonElement -> jsonElement.getAsInt())
                            .collect(Collectors.toList());
                } else {
                    throw new IllegalArgumentException("Trường 'serviceIds' bị thiếu hoặc sai định dạng.");
                }

                System.out.println("Parsed data: CustomerID=" + customerId + ", StaffID=" + staffId
                        + ", ApptTime=" + appointmentDateTime + ", BranchID=" + branchId // Updated log
                        + ", ServiceIDs=" + serviceIds);

                boolean success = appointmentDAO.addAppointmentByAdmin(customerId, staffId, appointmentDateTime, branchId, serviceIds);

                System.out.println("DEBUG: DAO addAppointment returned: " + success);

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
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Dữ liệu đầu vào không hợp lệ: " + e.getMessage());
                System.err.println("Input Data Validation Error: " + e.getMessage());
                e.printStackTrace();
            } catch (Exception e) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Lỗi server nội bộ: " + e.getMessage());
                System.err.println("Server Internal Error (during DAO call or other processing): " + e.getMessage());
                e.printStackTrace();
            }

        } finally {
            out.print(gson.toJson(jsonResponse));
            out.flush();
            out.close();
            System.out.println("--- AddAppointmentServlet: Finished POST Request ---\n");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for adding new appointments";
    }
}
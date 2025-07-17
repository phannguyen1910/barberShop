package controller.CustomerManagement;

import babershopDAO.AppointmentDAO;
import babershopDAO.FeedbackDAO;
import babershopDAO.StaffDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.lang.reflect.Type;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.Appointment;
import model.Customer;
import model.Staff;

@WebServlet("/HistoryAppointmentServlet")
public class HistoryAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private AppointmentDAO appointmentDAO;
    private StaffDAO staffDAO;

    
    @Override
    public void init() throws ServletException {
        super.init();
        appointmentDAO = new AppointmentDAO();
        staffDAO = new StaffDAO();
       
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Thiết lập response header cho JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        PrintWriter out = response.getWriter();

        try {
            // Kiểm tra xem user đã đăng nhập chưa
            if (customer == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{\"error\": \"Bạn cần đăng nhập để xem lịch sử đặt lịch.\"}");
                return;
            }

            // Lấy customerId từ session
            int customerId = customer.getId(); // Giả định Customer có phương thức getId()

            // Gọi DAO để lấy lịch sử booking
            List<Appointment> appointments = appointmentDAO.historyBooking(customerId);
        
            
            
     
            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(LocalDateTime.class, new JsonSerializer<LocalDateTime>() {
                        @Override
                        public JsonElement serialize(LocalDateTime src, Type typeOfSrc, JsonSerializationContext context) {
                            return new JsonPrimitive(src.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
                        }
                    })
                    .create();

            String jsonResponse = gson.toJson(appointments);
            
            // Trả về JSON response
            response.setStatus(HttpServletResponse.SC_OK);
            out.print(jsonResponse);

        } catch (Exception e) {
            // Log lỗi
            e.printStackTrace();

            // Trả về lỗi server
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"Lỗi server khi lấy lịch sử đặt lịch: " + e.getMessage() + "\"}");

        } finally {
            out.flush();
            out.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng POST request sang GET
        doGet(request, response);
    }
}

package payment;

import babershopDAO.AppointmentDAO;
import babershopDAO.InvoiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "VnpayReturnServlet", urlPatterns = {"/vnpay_return"})
public class VnpayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        String vnp_ResponseCode = req.getParameter("vnp_ResponseCode");
        String txnRef = (String) session.getAttribute("txnRef");

        if ("00".equals(vnp_ResponseCode)) {
            // Lấy dữ liệu booking từ session
            int customerId = (int) session.getAttribute("customerId");
            int staffId = (int) session.getAttribute("staffId");
            String appointmentTime = (String) session.getAttribute("appointmentTime");
            int numberOfPeople = (int) session.getAttribute("numberOfPeople");
            List<Integer> serviceIds = (List<Integer>) session.getAttribute("serviceIds");
            double amount = (double) session.getAttribute("amount");

            // Tạo booking trong DB
            AppointmentDAO appointmentDAO = new AppointmentDAO();
            String result = appointmentDAO.Booking(customerId, staffId, appointmentTime, numberOfPeople, serviceIds);

            // Nếu booking thành công, tạo hóa đơn (invoice/payment)
            if (result.equals("Booking successful")) {
                InvoiceDAO invoiceDAO = new InvoiceDAO();
                LocalDateTime payTime = LocalDateTime.now();
                invoiceDAO.insertInvoice(
                    appointmentDAO.getLastInsertedAppointmentId(),
                    txnRef,
                    amount,
                    "VNPAY",
                    "PAID",
                    payTime
                );
                
                
            }
            req.setAttribute("message", "Thanh toán thành công! Lịch hẹn của bạn đã được xác nhận.");
        } else {
            req.setAttribute("message", "Thanh toán thất bại hoặc bị hủy.");
        }

        req.getRequestDispatcher("views/payment/payment-success.jsp").forward(req, resp);
    }
}

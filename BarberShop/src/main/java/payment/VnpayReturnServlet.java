package payment;

import babershopDAO.AppointmentDAO;
import babershopDAO.PaymentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Payment;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "VnpayReturnServlet", urlPatterns = {"/vnpay_return"})
public class VnpayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        String vnp_ResponseCode = req.getParameter("vnp_ResponseCode");
        String vnp_TxnRef = req.getParameter("vnp_TxnRef");
        String vnp_TransactionNo = req.getParameter("vnp_TransactionNo");
        String vnp_PayDate = req.getParameter("vnp_PayDate");

        if ("00".equals(vnp_ResponseCode)) {
            try {
                int appointmentId = Integer.parseInt(vnp_TxnRef.replaceAll("[^0-9]", ""));


                float amount = 50000f;

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
                LocalDateTime payTime = LocalDateTime.parse(vnp_PayDate, formatter);

                // Save to Payment table
                Payment payment = new Payment();
                payment.setAppointmentId(appointmentId);
                payment.setTransactionNo(vnp_TransactionNo);
                payment.setMethod("VNPAY");
                payment.setAmount(amount);
                payment.setReceivedDate(Timestamp.valueOf(payTime));

                PaymentDAO paymentDAO = new PaymentDAO();
                paymentDAO.insertPayment(payment);
                
                // ✅ Update Appointment status to "confirmed"
                AppointmentDAO appointmentDAO = new AppointmentDAO();
                appointmentDAO.updateAppointmentStatusAfterPayment(appointmentId, "Confirmed");


                req.setAttribute("transResult", true);

            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("transResult", false);
            }
        } else {
            req.setAttribute("transResult", false);
        }

        req.getRequestDispatcher("/views/payment/payment-success.jsp").forward(req, resp);
    }
}

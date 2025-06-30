package controller.Payment;

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
        String paymentType = req.getParameter("type"); // "deposit" or "final"

        if ("00".equals(vnp_ResponseCode)) {
            try {
                // Extract appointmentId from vnp_TxnRef (e.g., APPT1751185196724 -> 73)
                String idOnly = vnp_TxnRef.replaceAll("[^0-9]", "");
                int appointmentId = Integer.parseInt(idOnly);

                float amount;
                AppointmentDAO appointmentDAO = new AppointmentDAO();

                if ("final".equalsIgnoreCase(paymentType)) {
                    float totalAmount = appointmentDAO.getTotalAmount(appointmentId);
                    amount = totalAmount - 50000f;
                } else {
                    amount = 50000f; // Default deposit
                }

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

                // ✅ Update Appointment status
                if ("final".equalsIgnoreCase(paymentType)) {
                    appointmentDAO.updateAppointmentStatusAfterPayment(appointmentId, "completed");
                } else {
                    appointmentDAO.updateAppointmentStatusAfterPayment(appointmentId, "confirmed");
                }

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

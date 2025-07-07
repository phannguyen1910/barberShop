package controller.Payment;

import babershopDAO.AppointmentDAO;
import babershopDAO.InvoiceDAO;
import babershopDAO.PaymentDAO;
import babershopDAO.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Appointment;
import model.Payment;
import model.Service;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "VnpayReturnServlet", urlPatterns = {"/vnpay_return"})
public class VnpayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        try {
            String vnp_ResponseCode = req.getParameter("vnp_ResponseCode");
            String vnp_TxnRef = req.getParameter("vnp_TxnRef");
            String vnp_TransactionNo = req.getParameter("vnp_TransactionNo");
            String vnp_PayDate = req.getParameter("vnp_PayDate");
            String paymentType = req.getParameter("type"); // "deposit" or "final"

            // Lấy appointmentId từ vnp_TxnRef
            int appointmentId;
            try {
                if (vnp_TxnRef.contains("_")) {
                    String rawId = vnp_TxnRef.substring(4, vnp_TxnRef.indexOf("_"));
                    appointmentId = Integer.parseInt(rawId);
                } else {
                    appointmentId = Integer.parseInt(vnp_TxnRef.substring(4));
                }
            } catch (NumberFormatException e) {
                req.setAttribute("transResult", false);
                req.setAttribute("error", "Mã giao dịch không hợp lệ.");
                req.getRequestDispatcher("/views/payment/payment-success.jsp").forward(req, resp);
                return;
            }

            AppointmentDAO appointmentDAO = new AppointmentDAO();

            String serviceNamesList = (String) session.getAttribute("serviceNames");
            String staffFullName = (String) session.getAttribute("staffFullName");
            String appointmentTime = (String) session.getAttribute("appointmentTime");
            Integer totalServiceDuration = (Integer) session.getAttribute("totalServiceDuration");
            String branchName = (String) session.getAttribute("selectedBranchName");
            String email = (String) session.getAttribute("customerEmail");
            if ("00".equals(vnp_ResponseCode)) {
                // Thanh toán thành công
                try {
                    // Tính số tiền
                    float amount;
                    InvoiceDAO invoiceDAO = new InvoiceDAO();
                    if ("final".equalsIgnoreCase(paymentType)) {
                        Double totalAmount = (Double) session.getAttribute("selectedTotalPrice");
                        amount = (float) (totalAmount - 50000f); // Trừ tiền đặt cọc
                    } else {
                        amount = 50000f; // Tiền đặt cọc
                    }

                    // Cập nhật trạng thái hóa đơn
                    if ("final".equalsIgnoreCase(paymentType)) {
                        invoiceDAO.updateInvoiceStatus(appointmentId, "Paid");
                    } else {
                        invoiceDAO.updateInvoiceStatus(appointmentId, "Paid Deposit");
                    }

                    // Parse thời gian thanh toán
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
                    LocalDateTime payTime = LocalDateTime.parse(vnp_PayDate, formatter);

                    // Cập nhật trạng thái lịch hẹn
                    if ("final".equalsIgnoreCase(paymentType)) {
                        appointmentDAO.updateAppointmentStatusAfterPayment(appointmentId, "Completed");
                    } else {
                        appointmentDAO.updateAppointmentStatusAfterPayment(appointmentId, "Confirmed");
                    }

                    // Lưu thông tin lịch hẹn vào request để hiển thị
                    req.setAttribute("transResult", true);
                    req.setAttribute("serviceNamesList", serviceNamesList);
                    req.setAttribute("staffFullName", staffFullName);
                    req.setAttribute("appointmentTime", appointmentTime);
                    req.setAttribute("totalServiceDuration", totalServiceDuration);
                    req.setAttribute("staffFullName", staffFullName);
                    req.setAttribute("selectedBranchName", branchName);
                    req.setAttribute("customerEmail", email);

                    System.out.println("transResult: " + true);
                    System.out.println("serviceNamesList: " + serviceNamesList);
                    System.out.println("staffFullName: " + staffFullName);
                    System.out.println("appointmentTime: " + appointmentTime);
                    System.out.println("totalServiceDuration: " + totalServiceDuration);
                    System.out.println("selectedBranchName: " + branchName);
                    System.out.println("customerEmail: " + email);

                } catch (Exception e) {
                    e.printStackTrace();
                    req.setAttribute("transResult", false);
                    req.setAttribute("error", "Lỗi xử lý thanh toán: " + e.getMessage());
                }
            } else {
                req.setAttribute("transResult", false);
                req.setAttribute("error", "Thanh toán thất bại: Mã lỗi " + vnp_ResponseCode);
            }

            req.getRequestDispatcher("/views/payment/payment-success.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("transResult", false);
            req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/views/payment/payment-success.jsp").forward(req, resp);
        }
    }
}

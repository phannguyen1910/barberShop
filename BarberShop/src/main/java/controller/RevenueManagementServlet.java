package controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import babershopDAO.InvoiceDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Invoice;

@WebServlet("/RevenueManagementServlet")
public class RevenueManagementServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private InvoiceDAO invoiceDAO;

    @Override
    public void init() throws ServletException {
        invoiceDAO = new InvoiceDAO();
        System.out.println("RevenueManagementServlet initialized successfully");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String viewType = request.getParameter("viewType");
        String periodValue = request.getParameter("periodValue");
        String year = request.getParameter("year");

        List<Invoice> invoices = new ArrayList<>();

        try {
            if (viewType == null || viewType.isEmpty()) {
                invoices = invoiceDAO.getAllInvoice();
            } else {
                // Fetch only Paid and Paid Deposit invoices
                invoices = invoiceDAO.getInvoicesByPeriod(viewType, periodValue, year);
                List<Invoice> depositInvoices = invoiceDAO.getDepositInvoicesByPeriod(viewType, periodValue, year);
                invoices.addAll(depositInvoices);
            }

            // Ensure groupedInvoices is always initialized
            Map<String, Map<String, Object>> groupedInvoices = new HashMap<>();
            if (!invoices.isEmpty()) {
                groupedInvoices = groupInvoices(invoices, viewType != null ? viewType : "day");
            }

            // Set attribute even if empty
            request.setAttribute("groupedInvoices", groupedInvoices);

            // Forward to JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/revenueManagement.jsp");
            if (dispatcher != null) {
                dispatcher.forward(request, response);
            } else {
                System.err.println("Dispatcher is null for /views/admin/revenueManagement.jsp");
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "JSP file not found");
            }
        } catch (Exception e) {
            System.err.println("Error in RevenueManagementServlet: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("Lỗi khi tải dữ liệu: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private Map<String, Map<String, Object>> groupInvoices(List<Invoice> invoices, String viewType) {
        Map<String, Map<String, Object>> grouped = new HashMap<>();
        DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE;

        for (Invoice invoice : invoices) {
            if (invoice != null) {
                LocalDateTime receivedDate = invoice.getReceivedDate();
                if (receivedDate == null) {
                    System.err.println("ReceivedDate is null for invoice: " + invoice);
                    continue;
                }

                // Adjust totalAmount based on status
                double adjustedAmount = invoice.getTotalAmount();
                if ("Paid Deposit".equals(invoice.getStatus())) {
                    adjustedAmount = 50000.0; // Set to 50,000 VND for Paid Deposit
                } else if (!"Paid".equals(invoice.getStatus())) {
                    continue; // Skip invoices with other statuses
                }

                String key = getKey(receivedDate, viewType);
                if (key != null) {
                    grouped.computeIfAbsent(key, k -> new HashMap<>());
                    Map<String, Object> data = grouped.get(key);
                    data.put("revenue", (data.get("revenue") != null ? (Double) data.get("revenue") : 0.0) + adjustedAmount);
                    data.put("count", (data.get("count") != null ? (Integer) data.get("count") : 0) + 1);
                }
            }
        }

        return grouped;
    }

    private String getKey(LocalDateTime date, String viewType) {
        if (date == null) {
            return null;
        }
        switch (viewType) {
            case "day":
                return date.format(DateTimeFormatter.ISO_LOCAL_DATE);
            case "month":
                return date.format(DateTimeFormatter.ofPattern("MM/yyyy"));
            case "year":
                return date.format(DateTimeFormatter.ofPattern("yyyy"));
            case "quarter":
                int month = date.getMonthValue();
                String quarter = (month <= 3 ? "Q1" : month <= 6 ? "Q2" : month <= 9 ? "Q3" : "Q4");
                return quarter + " " + date.format(DateTimeFormatter.ofPattern("yyyy"));
            default:
                return date.format(DateTimeFormatter.ISO_LOCAL_DATE);
        }
    }
}
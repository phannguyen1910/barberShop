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

        System.out.println("Received parameters - viewType: " + viewType + ", periodValue: " + periodValue + ", year: " + year);

        List<Invoice> invoices = new ArrayList<>();

        try {
            if (viewType == null || viewType.isEmpty() || "all".equalsIgnoreCase(viewType)) {
                // Fetch all invoices if no filter or "all" is specified
                invoices = invoiceDAO.getAllInvoice();
                System.out.println("Fetching all invoices. Count: " + invoices.size());
            } else {
                // Validate and parse parameters
                int yearInt = year != null && !year.isEmpty() ? Integer.parseInt(year) : LocalDateTime.now().getYear();
                switch (viewType.toLowerCase()) {
                    case "day":
                        if (periodValue != null && !periodValue.isEmpty()) {
                            invoices = invoiceDAO.getInvoicesByPeriod("day", periodValue, String.valueOf(yearInt));
                            System.out.println("Fetching invoices by day: " + periodValue + ", year: " + yearInt);
                        }
                        break;
                    case "month":
                        if (periodValue != null && !periodValue.isEmpty()) {
                            invoices = invoiceDAO.getInvoicesByPeriod("month", periodValue, String.valueOf(yearInt));
                            System.out.println("Fetching invoices by month: " + periodValue + ", year: " + yearInt);
                        }
                        break;
                    case "year":
                        invoices = invoiceDAO.getInvoicesByPeriod("year", year, null);
                        System.out.println("Fetching invoices by year: " + year);
                        break;
                    case "quarter":
                        if (periodValue != null && !periodValue.isEmpty()) {
                            invoices = invoiceDAO.getInvoicesByPeriod("quarter", periodValue, String.valueOf(yearInt));
                            System.out.println("Fetching invoices by quarter: " + periodValue + ", year: " + yearInt);
                        }
                        break;
                    default:
                        invoices = invoiceDAO.getAllInvoice();
                        System.out.println("Default case: Fetching all invoices.");
                        break;
                }

                // Fetch deposit invoices with the same filter
                List<Invoice> depositInvoices = new ArrayList<>();
                if (!invoices.isEmpty() || viewType != null) {
                    depositInvoices = invoiceDAO.getDepositInvoicesByPeriod(viewType, periodValue, String.valueOf(yearInt));
                    System.out.println("Fetching deposit invoices. Count: " + depositInvoices.size());
                }
                invoices.addAll(depositInvoices);
            }

            // Group invoices
            Map<String, Map<String, Object>> groupedInvoices = new HashMap<>();
            if (!invoices.isEmpty()) {
                groupedInvoices = groupInvoices(invoices, viewType != null && !viewType.isEmpty() ? viewType : "day");
                System.out.println("Grouped invoices count: " + groupedInvoices.size());
            }
            request.setAttribute("groupedInvoices", groupedInvoices);

            // Forward to JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/revenueManagement.jsp");
            if (dispatcher != null) {
                dispatcher.forward(request, response);
            } else {
                System.err.println("Dispatcher is null for /views/admin/revenueManagement.jsp");
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "JSP file not found");
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid year format: " + e.getMessage());
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("Lỗi: Năm không hợp lệ.");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
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
        switch (viewType.toLowerCase()) {
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
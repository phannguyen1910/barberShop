package controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import model.Branch;
import com.google.gson.Gson;

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
        String ajax = request.getParameter("ajax");
        if ("true".equals(ajax)) {
            processAjaxRequest(request, response);
            return;
        }

        String branchId = request.getParameter("branchId");
        System.out.println("Received parameters - branchId: " + branchId);

        List<Invoice> invoices = new ArrayList<>();
        try {
            branchId = branchId == null ? "" : branchId.trim();

            if (!branchId.isEmpty()) {
                invoices = invoiceDAO.getAllInvoiceByBranch(branchId);
                System.out.println("Fetched invoices by branchId: " + branchId + ", count: " + invoices.size());
            } else {
                invoices = invoiceDAO.getAllInvoiceByBranch(null);
                System.out.println("Fetched all invoices, count: " + invoices.size());
            }

            List<Invoice> depositInvoices = invoiceDAO.getDepositInvoicesByPeriodAndBranch("", "", "", branchId.isEmpty() ? null : branchId);
            invoices.addAll(depositInvoices);
            System.out.println("Fetched deposit invoices, count: " + depositInvoices.size());

            Map<String, Map<String, Object>> groupedInvoices = new HashMap<>();
            if (!invoices.isEmpty()) {
                groupedInvoices = groupInvoices(invoices, "day");
                System.out.println("Grouped invoices count: " + groupedInvoices.size());
            } else {
                System.out.println("No invoices found for the given filter.");
            }
            request.setAttribute("groupedInvoices", groupedInvoices);
            request.setAttribute("periodColumn", "Ngày");

            List<Branch> branches = invoiceDAO.getAllBranches();
            request.setAttribute("branches", branches);

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

    protected void processAjaxRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String branchId = request.getParameter("branchId");
        System.out.println("AJAX Received parameters - branchId: " + branchId);

        List<Invoice> invoices = new ArrayList<>();
        try {
            branchId = branchId == null ? "" : branchId.trim();

            if (!branchId.isEmpty()) {
                invoices = invoiceDAO.getAllInvoiceByBranch(branchId);
            } else {
                invoices = invoiceDAO.getAllInvoiceByBranch(null);
            }

            List<Invoice> depositInvoices = invoiceDAO.getDepositInvoicesByPeriodAndBranch("", "", "", branchId.isEmpty() ? null : branchId);
            invoices.addAll(depositInvoices);

            Map<String, Map<String, Object>> groupedInvoices = new HashMap<>();
            if (!invoices.isEmpty()) {
                groupedInvoices = groupInvoices(invoices, "day");
            }

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("groupedInvoices", groupedInvoices);
            responseData.put("periodColumn", "Ngày");
            responseData.put("totalRevenue", calculateTotalRevenue(groupedInvoices));

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            Gson gson = new Gson();
            if (responseData == null) {
                responseData = new HashMap<>();
                responseData.put("error", "No data available");
            }
            out.print(gson.toJson(responseData));
            out.flush();
        } catch (Exception e) {
            System.err.println("Error in AJAX request: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            Map<String, String> error = new HashMap<>();
            error.put("error", "Lỗi khi tải dữ liệu: " + e.getMessage());
            PrintWriter out = response.getWriter();
            out.print(new Gson().toJson(error));
            out.flush();
        }
    }

    private double calculateTotalRevenue(Map<String, Map<String, Object>> groupedInvoices) {
        double total = 0;
        for (Map<String, Object> data : groupedInvoices.values()) {
            total += (double) data.getOrDefault("revenue", 0.0);
        }
        return total;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private Map<String, Map<String, Object>> groupInvoices(List<Invoice> invoices, String viewType) {
        Map<String, Map<String, Object>> grouped = new HashMap<>();
        DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE;

        for (Invoice invoice : invoices) {
            if (invoice != null && invoice.getReceivedDate() != null) {
                LocalDateTime receivedDate = invoice.getReceivedDate();
                double adjustedAmount = invoice.getTotalAmount();
                if ("Paid Deposit".equals(invoice.getStatus())) {
                    adjustedAmount = 50000.0;
                } else if (!"Paid".equals(invoice.getStatus())) {
                    continue;
                }

                String key = getKey(receivedDate, viewType);
                if (key != null) {
                    grouped.computeIfAbsent(key, k -> new HashMap<>());
                    Map<String, Object> data = grouped.get(key);
                    data.put("revenue", (data.get("revenue") != null ? (Double) data.get("revenue") : 0.0) + adjustedAmount);
                    data.put("count", (data.get("count") != null ? (Integer) data.get("count") : 0) + 1);
                }
            } else {
                System.err.println("Skipping invalid invoice: " + invoice);
            }
        }
        return grouped;
    }

    private String getKey(LocalDateTime date, String viewType) {
        if (date == null) {
            return null;
        }
        viewType = viewType == null ? "day" : viewType.toLowerCase();
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
                return quarter + "/" + date.format(DateTimeFormatter.ofPattern("yyyy"));
            default:
                return date.format(DateTimeFormatter.ISO_LOCAL_DATE);
        }
    }

    private String getPeriodColumnLabel(String viewType) {
        switch (viewType) {
            case "day":
                return "Ngày";
            case "month":
                return "Tháng/Năm";
            case "year":
                return "Năm";
            case "quarter":
                return "Quý/Năm";
            default:
                return "Thời gian";
        }
    }
}

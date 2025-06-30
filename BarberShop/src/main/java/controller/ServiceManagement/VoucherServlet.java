package controller.ServiceManagement;

import babershopDAO.VoucherDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Voucher;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonParser;
import com.google.gson.JsonSerializer;
import java.lang.reflect.Type;

@WebServlet(name = "VoucherServlet", urlPatterns = {"/VoucherServlet"})
public class VoucherServlet extends HttpServlet {

    private VoucherDAO voucherDAO = new VoucherDAO();
    private static final int PAGE_SIZE = 10;

    // Custom Gson with LocalDate serializer/deserializer
    private Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDate.class, new JsonSerializer<LocalDate>() {
                @Override
                public JsonElement serialize(LocalDate date, Type typeOfSrc, JsonSerializationContext context) {
                    return new JsonPrimitive(date.format(DateTimeFormatter.ISO_LOCAL_DATE));
                }
            })
            .registerTypeAdapter(LocalDate.class, new JsonDeserializer<LocalDate>() {
                @Override
                public LocalDate deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) {
                    return LocalDate.parse(json.getAsJsonPrimitive().getAsString(), DateTimeFormatter.ISO_LOCAL_DATE);
                }
            })
            .create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            List<Voucher> vouchers = voucherDAO.getAllVouchers(1, PAGE_SIZE);
            if (vouchers == null) vouchers = new ArrayList<>();
            int totalRecords = voucherDAO.getTotalVouchers();
            request.setAttribute("vouchers", vouchers);
            request.setAttribute("totalRecords", totalRecords);
            request.getRequestDispatcher("/views/admin/voucherManagement.jsp").forward(request, response);
            return;
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        try {
            System.out.println("doGet action: " + action); // Debug log
            if ("list".equals(action)) {
                int page = 1;
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    System.out.println("Invalid page parameter, defaulting to 1"); // Debug log
                }
                List<Voucher> vouchers = voucherDAO.getAllVouchers(page, PAGE_SIZE);
                if (vouchers == null) vouchers = new ArrayList<>(); // Tránh null
                int totalRecords = voucherDAO.getTotalVouchers();
                String json = gson.toJson(new ResponseWrapper(true, vouchers, totalRecords));
                System.out.println("JSON response: " + json); // Debug log
                out.print(json);
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Voucher voucher = voucherDAO.getVoucher(id);
                if (voucher != null) {
                    String json = gson.toJson(new ResponseWrapper(true, voucher, 0));
                    out.print(json);
                } else {
                    out.print("{\"success\": false, \"message\": \"Voucher not found\"}");
                }
            } else {
                out.print("{\"success\": false, \"message\": \"Invalid action\"}");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (Exception e) {
            String errorMsg = "Error: " + e.getMessage();
            System.out.println("Exception in doGet: " + errorMsg); // Debug log
            out.print("{\"success\": false, \"message\": \"" + errorMsg + "\"}");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            out.flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");

        try {
            System.out.println("doPost action: " + action); // Debug log
            switch (action) {
                case "add":
                    addVoucher(request, response, out);
                    break;
                case "update":
                    updateVoucher(request, response, out);
                    break;
                case "toggle":
                    toggleVoucher(request, response, out);
                    break;
                case "delete":
                    deleteVoucher(request, response, out);
                    break;
                default:
                    listVouchers(request, response, out);
                    break;
            }
        } catch (Exception e) {
            String errorMsg = "Lỗi hệ thống: " + e.getMessage();
            System.out.println("Exception in doPost: " + errorMsg); // Debug log
            out.print("{\"success\": false, \"message\": \"" + errorMsg + "\"}");
        } finally {
            out.flush();
        }
    }

    private void listVouchers(HttpServletRequest request, HttpServletResponse response, PrintWriter out)
            throws ServletException, IOException {
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            System.out.println("Invalid page parameter in listVouchers, defaulting to 1"); // Debug log
        }
        List<Voucher> vouchers = voucherDAO.getAllVouchers(page, PAGE_SIZE);
        if (vouchers == null) vouchers = new ArrayList<>(); // Tránh null
        int totalRecords = voucherDAO.getTotalVouchers();
        String json = gson.toJson(new ResponseWrapper(true, vouchers, totalRecords));
        System.out.println("JSON response: " + json); // Debug log
        out.print(json);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response, PrintWriter out)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Voucher voucher = voucherDAO.getVoucher(id);
            if (voucher != null) {
                String json = gson.toJson(new ResponseWrapper(true, voucher, 0));
                out.print(json);
            } else {
                out.print("{\"success\": false, \"message\": \"Không tìm thấy voucher.\"}");
            }
        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"ID voucher không hợp lệ.\"}");
        }
    }

    private void addVoucher(HttpServletRequest request, HttpServletResponse response, PrintWriter out)
            throws ServletException, IOException {
        try {
            String voucherName = request.getParameter("voucherName").trim(); // Thêm voucherName
            String code = request.getParameter("code").trim();
            String expiryDateStr = request.getParameter("expiryDate");
            String valueStr = request.getParameter("value");

            if (code == null || code.trim().isEmpty()) {
                throw new IllegalArgumentException("Mã voucher không được để trống.");
            }
            if (code.length() > 50) {
                throw new IllegalArgumentException("Mã voucher không được vượt quá 50 ký tự.");
            }
            if (!code.matches("[a-zA-Z0-9_-]+")) {
                throw new IllegalArgumentException("Mã voucher chỉ được chứa chữ cái, số, dấu gạch dưới hoặc gạch ngang.");
            }
            if (voucherName == null || voucherName.trim().isEmpty()) {
                throw new IllegalArgumentException("Tên voucher không được để trống.");
            }
            if (voucherName.length() > 100) {
                throw new IllegalArgumentException("Tên voucher không được vượt quá 100 ký tự.");
            }
            float value = Float.parseFloat(valueStr);
            if (value <= 0 || value > 100) {
                throw new IllegalArgumentException("Phần trăm giảm giá phải từ 1 - 100");
            }

            LocalDate expiryDate = LocalDate.parse(expiryDateStr, DateTimeFormatter.ISO_LOCAL_DATE);
            if (expiryDate.isBefore(LocalDate.now())) {
                throw new IllegalArgumentException("Ngày hết hạn phải từ hôm nay trở đi.");
            }

            Voucher voucher = new Voucher(code, voucherName, value, expiryDate, 1); // Sử dụng constructor mới
            boolean success = voucherDAO.insertVoucher(voucher);
            out.print("{\"success\": " + success + ", \"message\": \"" + (success ? "Thêm voucher thành công!" : "Thêm voucher thất bại.") + "\"}");
        } catch (IllegalArgumentException e) {
            out.print("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        } catch (Exception e) {
            out.print("{\"success\": false, \"message\": \"Lỗi hệ thống: " + e.getMessage() + "\"}");
        }
    }

    private void updateVoucher(HttpServletRequest request, HttpServletResponse response, PrintWriter out)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String voucherName = request.getParameter("voucherName").trim(); // Thêm voucherName
            String code = request.getParameter("code").trim();
            String expiryDateStr = request.getParameter("expiryDate");
            String valueStr = request.getParameter("value");

            if (code == null || code.trim().isEmpty()) {
                throw new IllegalArgumentException("Mã voucher không được để trống.");
            }
            if (code.length() > 50) {
                throw new IllegalArgumentException("Mã voucher không được vượt quá 50 ký tự.");
            }
            if (!code.matches("[a-zA-Z0-9_-]+")) {
                throw new IllegalArgumentException("Mã voucher chỉ được chứa chữ cái, số, dấu gạch dưới hoặc gạch ngang.");
            }
            if (voucherName == null || voucherName.trim().isEmpty()) {
                throw new IllegalArgumentException("Tên voucher không được để trống.");
            }
            if (voucherName.length() > 100) {
                throw new IllegalArgumentException("Tên voucher không được vượt quá 100 ký tự.");
            }
            float value = Float.parseFloat(valueStr);
            if (value <= 0 || value > 100) {
                throw new IllegalArgumentException("Phần trăm giảm giá phải từ 1 - 100");
            }

            LocalDate expiryDate = LocalDate.parse(expiryDateStr, DateTimeFormatter.ISO_LOCAL_DATE);
            if (expiryDate.isBefore(LocalDate.now())) {
                throw new IllegalArgumentException("Ngày hết hạn phải từ hôm nay trở đi.");
            }

            Voucher voucher = new Voucher(id, code, voucherName, value, expiryDate, 1); // Sử dụng constructor mới
            boolean success = voucherDAO.updateVoucher(voucher);
            out.print("{\"success\": " + success + ", \"message\": \"" + (success ? "Cập nhật thành công" : "Cập nhật thất bại") + "\"}");
        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"ID voucher không hợp lệ.\"}");
        } catch (IllegalArgumentException e) {
            out.print("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        } catch (Exception e) {
            out.print("{\"success\": false, \"message\": \"Lỗi hệ thống: " + e.getMessage() + "\"}");
        }
    }

    private void toggleVoucher(HttpServletRequest request, HttpServletResponse response, PrintWriter out)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int status = Integer.parseInt(request.getParameter("status"));
            boolean success = voucherDAO.toggleVoucherStatus(id, status);
            out.print("{\"success\": " + success + ", \"message\": \"" + (success ? "Cập nhật thành công" : "Cập nhật thất bại") + "\"}");
        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"ID hoặc trạng thái voucher không hợp lệ.\"}");
        } catch (Exception e) {
            out.print("{\"success\": false, \"message\": \"Lỗi hệ thống: " + e.getMessage() + "\"}");
        }
    }

    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response, PrintWriter out)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = voucherDAO.deleteVoucher(id);
            out.print("{\"success\": " + success + ", \"message\": \"" + (success ? "Xóa thành công" : "Xóa thất bại") + "\"}");
        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"ID voucher không hợp lệ.\"}");
        } catch (Exception e) {
            out.print("{\"success\": false, \"message\": \"Lỗi hệ thống: " + e.getMessage() + "\"}");
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles voucher management operations: add, edit, delete, and toggle.";
    }

    private static class ResponseWrapper {
        private boolean success;
        private Object data;
        private int totalRecords;

        public ResponseWrapper(boolean success, Object data, int totalRecords) {
            this.success = success;
            this.data = data;
            this.totalRecords = totalRecords;
        }
    }
}
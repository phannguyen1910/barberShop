package babershopDAO;

import static babershopDatabase.databaseInfo.DBURL;
import static babershopDatabase.databaseInfo.DRIVERNAME;
import static babershopDatabase.databaseInfo.PASSDB;
import static babershopDatabase.databaseInfo.USERDB;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.Branch;
import model.Invoice;

public class InvoiceDAO {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver: " + e);
        }
        try {
            Connection con = DriverManager.getConnection(DBURL, USERDB, PASSDB);
            return con;
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public static Invoice getInvoice(int appointmentId) {
        String sql = "SELECT totalAmount, status, receivedDate FROM Invoice WHERE appointmentId=?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                float totalAmount = rs.getFloat("totalAmount");
                String status = rs.getString("status");
                Timestamp timestamp = rs.getTimestamp("receivedDate");
                LocalDateTime receivedDate = timestamp != null ? timestamp.toLocalDateTime() : null;
                return new Invoice(appointmentId, totalAmount, receivedDate, appointmentId, status);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static List<Invoice> getAllInvoice() {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "SELECT totalAmount, status, receivedDate, appointmentId FROM Invoice";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                float totalAmount = rs.getFloat("totalAmount");
                String status = rs.getString("status");
                Timestamp timestamp = rs.getTimestamp("receivedDate");
                LocalDateTime receivedDate = timestamp != null ? timestamp.toLocalDateTime() : null;
                int appointmentId = rs.getInt("appointmentId");
                invoices.add(new Invoice(totalAmount, status, receivedDate, appointmentId));
            }
            System.out.println("Fetched all invoices: " + (invoices != null ? invoices.size() : 0));
            return invoices;
        } catch (Exception e) {
            System.out.println("Error fetching all invoices: " + e.getMessage());
        }
        return invoices;
    }

    public boolean insertInvoice(Connection con, float totalAmount, LocalDateTime receivedDate, int appointmentId) throws SQLException {

        String sql = "INSERT INTO Invoice (totalAmount, receivedDate, appointmentId) VALUES (?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setFloat(1, totalAmount);
            ps.setTimestamp(2, Timestamp.valueOf(receivedDate));
            ps.setInt(3, appointmentId);
            return ps.executeUpdate() > 0;
        }

    }

    public boolean insertInvoice(int appointmentId, String transactionNo, double amount, String method, String status, LocalDateTime payTime) {
        String sql = "INSERT INTO Payment (booking_id, transaction_no, amount, method, status, pay_time) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, appointmentId);
            ps.setString(2, transactionNo);
            ps.setDouble(3, amount);
            ps.setString(4, method);
            ps.setString(5, status);
            ps.setTimestamp(6, Timestamp.valueOf(payTime));
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static List<Invoice> getInvoicesByPeriodAndBranch(String periodType, String periodValue, String year, String branchId) {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "SELECT i.totalAmount, i.status, i.receivedDate, i.appointmentId "
                + "FROM Invoice i "
                + "JOIN Appointment a ON i.appointmentId = a.id "
                + "JOIN Branch b ON a.branchId = b.id "
                + "WHERE i.status = 'Paid' "
                + (branchId != null && !branchId.isEmpty() ? "AND a.branchId = ?" : "");

        boolean hasTimeFilter = false;

        if (periodType != null && !periodType.trim().isEmpty()) {
            if ("day".equalsIgnoreCase(periodType) && periodValue != null && !periodValue.trim().isEmpty() && periodValue.matches("\\d{4}-\\d{2}-\\d{2}")) {
                sql += " AND CONVERT(date, i.receivedDate) = ?";
                hasTimeFilter = true;
            } else if ("month".equalsIgnoreCase(periodType) && periodValue != null && periodValue.matches("\\d{4}-\\d{2}")) {
                String[] parts = periodValue.split("-");
                year = parts[0];
                String month = parts[1];
                sql += " AND MONTH(i.receivedDate) = ? AND YEAR(i.receivedDate) = ?";
                hasTimeFilter = true;
            } else if ("year".equalsIgnoreCase(periodType) && year != null && !year.trim().isEmpty()) {
                sql += " AND YEAR(i.receivedDate) = ?";
                hasTimeFilter = true;
            }
        }

        if (!hasTimeFilter && (branchId == null || branchId.isEmpty())) {
            System.out.println("No valid filter, returning all paid invoices.");
            return getAllInvoice();
        }

        System.out.println("Executing SQL: " + sql + " with periodType: " + periodType + ", periodValue: " + periodValue + ", year: " + year + ", branchId: " + branchId);
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            int paramIndex = 1;
            if (branchId != null && !branchId.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(branchId));
            }
            if (hasTimeFilter) {
                if ("day".equalsIgnoreCase(periodType)) {
                    String dateParam = normalizeDate(periodValue);
                    System.out.println("[DEBUG] Search by day, param: " + dateParam);
                    ps.setString(paramIndex++, dateParam);
                } else if ("month".equalsIgnoreCase(periodType)) {
                    String[] parts = periodValue.split("-");
                    ps.setInt(paramIndex++, Integer.parseInt(parts[1])); // Tháng
                    ps.setInt(paramIndex++, Integer.parseInt(parts[0])); // Năm
                } else if ("year".equalsIgnoreCase(periodType)) {
                    ps.setInt(paramIndex++, Integer.parseInt(year));
                }
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    float totalAmount = rs.getFloat("totalAmount");
                    String status = rs.getString("status");
                    Timestamp timestamp = rs.getTimestamp("receivedDate");
                    LocalDateTime receivedDate = timestamp != null ? timestamp.toLocalDateTime() : null;
                    int appointmentId = rs.getInt("appointmentId");
                    invoices.add(new Invoice(totalAmount, status, receivedDate, appointmentId));
                }
                System.out.println("Fetched invoices count: " + invoices.size());
            }
        } catch (Exception e) {
            System.out.println("Error fetching invoices: " + e.getMessage());
        }
        return invoices;
    }

    public static List<Invoice> getDepositInvoicesByPeriodAndBranch(String periodType, String periodValue, String year, String branchId) {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "SELECT i.totalAmount, i.status, i.receivedDate, i.appointmentId "
                + "FROM Invoice i "
                + "JOIN Appointment a ON i.appointmentId = a.id "
                + "JOIN Branch b ON a.branchId = b.id "
                + "WHERE i.status = 'Paid Deposit' "
                + (branchId != null && !branchId.isEmpty() ? "AND a.branchId = ?" : "");

        boolean hasTimeFilter = false;

        if (periodType != null && !periodType.trim().isEmpty()) {
            if ("day".equalsIgnoreCase(periodType) && periodValue != null && !periodValue.trim().isEmpty() && periodValue.matches("\\d{4}-\\d{2}-\\d{2}")) {
                sql += " AND CONVERT(date, i.receivedDate) = ?";
                hasTimeFilter = true;
            } else if ("month".equalsIgnoreCase(periodType) && periodValue != null && periodValue.matches("\\d{4}-\\d{2}")) {
                String[] parts = periodValue.split("-");
                year = parts[0];
                String month = parts[1];
                sql += " AND MONTH(i.receivedDate) = ? AND YEAR(i.receivedDate) = ?";
                hasTimeFilter = true;
            } else if ("year".equalsIgnoreCase(periodType) && year != null && !year.trim().isEmpty()) {
                sql += " AND YEAR(i.receivedDate) = ?";
                hasTimeFilter = true;
            }
        }

        if (!hasTimeFilter && (branchId == null || branchId.isEmpty())) {
            System.out.println("No valid filter, returning all paid deposit invoices.");
            sql = "SELECT i.totalAmount, i.status, i.receivedDate, i.appointmentId FROM Invoice i WHERE i.status = 'Paid Deposit'";
        }

        System.out.println("Executing SQL for deposit: " + sql + " with periodValue: " + periodValue + ", year: " + year + ", branchId: " + branchId);
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            int paramIndex = 1;
            if (branchId != null && !branchId.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(branchId));
            }
            if (hasTimeFilter) {
                if ("day".equalsIgnoreCase(periodType)) {
                    ps.setString(paramIndex++, periodValue);
                } else if ("month".equalsIgnoreCase(periodType)) {
                    String[] parts = periodValue.split("-");
                    ps.setInt(paramIndex++, Integer.parseInt(parts[1])); // Tháng
                    ps.setInt(paramIndex++, Integer.parseInt(parts[0])); // Năm
                } else if ("year".equalsIgnoreCase(periodType)) {
                    ps.setInt(paramIndex++, Integer.parseInt(year));
                }
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                     float totalAmount = rs.getFloat("totalAmount");
                    String status = rs.getString("status");
                    Timestamp timestamp = rs.getTimestamp("receivedDate");
                    LocalDateTime receivedDate = timestamp != null ? timestamp.toLocalDateTime() : null;
                    int appointmentId = rs.getInt("appointmentId");
                    invoices.add(new Invoice(totalAmount, status, receivedDate, appointmentId));
                }
                System.out.println("Fetched deposit invoices count: " + invoices.size());
            }
        } catch (Exception e) {
            System.out.println("Error fetching deposit invoices: " + e.getMessage());
        }
        return invoices;
    }

    public static List<Invoice> getAllInvoiceByBranch(String branchId) {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "SELECT i.totalAmount, i.status, i.receivedDate, i.appointmentId "
                + "FROM Invoice i "
                + "JOIN Appointment a ON i.appointmentId = a.id "
                + "JOIN Branch b ON a.branchId = b.id "
                + (branchId != null && !branchId.isEmpty() ? "WHERE a.branchId = ?" : "");

        System.out.println("Executing SQL for all invoices: " + sql + " with branchId: " + branchId);
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            if (branchId != null && !branchId.isEmpty()) {
                ps.setInt(1, Integer.parseInt(branchId));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                     float totalAmount = rs.getFloat("totalAmount");
                    String status = rs.getString("status");
                    Timestamp timestamp = rs.getTimestamp("receivedDate");
                    LocalDateTime receivedDate = timestamp != null ? timestamp.toLocalDateTime() : null;
                    int appointmentId = rs.getInt("appointmentId");
                    invoices.add(new Invoice(totalAmount, status, receivedDate, appointmentId));
                }
                System.out.println("Fetched all invoices count: " + invoices.size());
            }
        } catch (Exception e) {
            System.out.println("Error fetching all invoices: " + e.getMessage());
        }
        return invoices;
    }

    public static List<Branch> getAllBranches() {
        List<Branch> branches = new ArrayList<>();
        String sql = "SELECT id, name, address, status, city FROM Branch WHERE status = 1"; // Chỉ lấy chi nhánh đang hoạt động
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String address = rs.getString("address");
                    boolean status = rs.getBoolean("status");
                    String city = rs.getString("city");
                    branches.add(new Branch(id, name, address, status, city));
                }
                System.out.println("Fetched branches count: " + branches.size());
            }
        } catch (Exception e) {
            System.out.println("Error fetching branches: " + e.getMessage());
        }
        return branches;
    }

    private static int getQuarterNumber(String quarter) {
        switch (quarter.toUpperCase()) {
            case "Q1":
                return 1;
            case "Q2":
                return 2;
            case "Q3":
                return 3;
            case "Q4":
                return 4;
            default:
                return 1;
        }
    }
    public float getTotalAmountByAppointmentId(int appointmentId) throws SQLException {
    String sql = "SELECT totalAmount FROM Invoice WHERE appointmentId = ?";
    try (Connection con = getConnect();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, appointmentId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getFloat("totalAmount");
            }
        }
    }
    return 0f; // hoặc throw lỗi nếu muốn bắt buộc có invoice
}
public boolean updateInvoiceStatus(int appointmentId, String status) {
    String sql = "UPDATE Invoice SET status = ? WHERE appointmentId = ?";
    try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, status);
        ps.setInt(2, appointmentId);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

private static String normalizeDate(String input) {
    // Nếu input là dd/MM/yyyy thì chuyển về yyyy-MM-dd
    if (input != null && input.matches("\\d{2}/\\d{2}/\\d{4}")) {
        String[] parts = input.split("/");
        return parts[2] + "-" + parts[1] + "-" + parts[0];
    }
    return input;
}
}

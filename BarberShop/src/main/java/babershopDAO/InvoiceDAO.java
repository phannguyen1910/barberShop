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
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
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
                double totalAmount = rs.getDouble("totalAmount");
                String status = rs.getString("status");
                Timestamp timestamp = rs.getTimestamp("receivedDate");
                LocalDateTime receivedDate = timestamp != null ? timestamp.toLocalDateTime() : null;
                return new Invoice(totalAmount, status, receivedDate, appointmentId);
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
                double totalAmount = rs.getDouble("totalAmount");
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

    public static List<Invoice> getInvoicesByPeriod(String periodType, String periodValue, String year) {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "SELECT totalAmount, status, receivedDate, appointmentId FROM Invoice WHERE status = 'Paid'";
        boolean hasFilter = false;

        if ("day".equalsIgnoreCase(periodType)) {
            sql += " AND DATE(receivedDate) = ?";
            hasFilter = true;
        } else if ("month".equalsIgnoreCase(periodType)) {
            if (periodValue != null && year != null) {
                sql += " AND MONTH(receivedDate) = ? AND YEAR(receivedDate) = ?";
                hasFilter = true;
            }
        } else if ("year".equalsIgnoreCase(periodType)) {
            if (year != null) {
                sql += " AND YEAR(receivedDate) = ?";
                hasFilter = true;
            }
        } else if ("quarter".equalsIgnoreCase(periodType)) {
            if (periodValue != null && year != null) {
                int quarter = getQuarterNumber(periodValue);
                int startMonth = (quarter - 1) * 3 + 1;
                int endMonth = startMonth + 2;
                sql += " AND MONTH(receivedDate) BETWEEN ? AND ? AND YEAR(receivedDate) = ?";
                hasFilter = true;
            }
        }

        if (!hasFilter) {
            System.out.println("No valid filter, returning all invoices.");
            return getAllInvoice();
        }

        System.out.println("Executing SQL: " + sql + " with periodValue: " + periodValue + ", year: " + year);
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            if ("day".equalsIgnoreCase(periodType)) {
                ps.setString(1, periodValue);
            } else if ("month".equalsIgnoreCase(periodType)) {
                ps.setInt(1, Integer.parseInt(periodValue));
                ps.setInt(2, Integer.parseInt(year));
            } else if ("year".equalsIgnoreCase(periodType)) {
                ps.setInt(1, Integer.parseInt(year));
            } else if ("quarter".equalsIgnoreCase(periodType)) {
                int quarter = getQuarterNumber(periodValue);
                int startMonth = (quarter - 1) * 3 + 1;
                int endMonth = startMonth + 2;
                ps.setInt(1, startMonth);
                ps.setInt(2, endMonth);
                ps.setInt(3, Integer.parseInt(year));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    double totalAmount = rs.getDouble("totalAmount");
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

    public static List<Invoice> getDepositInvoicesByPeriod(String periodType, String periodValue, String year) {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "SELECT totalAmount, status, receivedDate, appointmentId FROM Invoice WHERE status = 'Paid Deposit'";
        boolean hasFilter = false;

        if ("day".equalsIgnoreCase(periodType)) {
            sql += " AND DATE(receivedDate) = ?";
            hasFilter = true;
        } else if ("month".equalsIgnoreCase(periodType)) {
            if (periodValue != null && year != null) {
                sql += " AND MONTH(receivedDate) = ? AND YEAR(receivedDate) = ?";
                hasFilter = true;
            }
        } else if ("year".equalsIgnoreCase(periodType)) {
            if (year != null) {
                sql += " AND YEAR(receivedDate) = ?";
                hasFilter = true;
            }
        } else if ("quarter".equalsIgnoreCase(periodType)) {
            if (periodValue != null && year != null) {
                int quarter = getQuarterNumber(periodValue);
                int startMonth = (quarter - 1) * 3 + 1;
                int endMonth = startMonth + 2;
                sql += " AND MONTH(receivedDate) BETWEEN ? AND ? AND YEAR(receivedDate) = ?";
                hasFilter = true;
            }
        }

        if (!hasFilter) {
            System.out.println("No valid filter for deposit invoices, returning empty list.");
            return new ArrayList<>();
        }

        System.out.println("Executing SQL for deposit: " + sql + " with periodValue: " + periodValue + ", year: " + year);
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            if ("day".equalsIgnoreCase(periodType)) {
                ps.setString(1, periodValue);
            } else if ("month".equalsIgnoreCase(periodType)) {
                ps.setInt(1, Integer.parseInt(periodValue));
                ps.setInt(2, Integer.parseInt(year));
            } else if ("year".equalsIgnoreCase(periodType)) {
                ps.setInt(1, Integer.parseInt(year));
            } else if ("quarter".equalsIgnoreCase(periodType)) {
                int quarter = getQuarterNumber(periodValue);
                int startMonth = (quarter - 1) * 3 + 1;
                int endMonth = startMonth + 2;
                ps.setInt(1, startMonth);
                ps.setInt(2, endMonth);
                ps.setInt(3, Integer.parseInt(year));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    double totalAmount = rs.getDouble("totalAmount");
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

    private static int getQuarterNumber(String quarter) {
        switch (quarter.toUpperCase()) {
            case "Q1": return 1;
            case "Q2": return 2;
            case "Q3": return 3;
            case "Q4": return 4;
            default: return 1;
        }
    }
}
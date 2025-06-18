package babershopDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Voucher;
import static babershopDatabase.databaseInfo.DBURL;
import static babershopDatabase.databaseInfo.DRIVERNAME;
import static babershopDatabase.databaseInfo.PASSDB;
import static babershopDatabase.databaseInfo.USERDB;

public class VoucherDAO {

    private static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.err.println("Error loading driver: " + e.getMessage());
            return null;
        }
        try {
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (SQLException e) {
            System.err.println("Error connecting to database: " + e.getMessage());
            return null;
        }
    }

    public List<Voucher> getAllVouchers(int page, int pageSize) {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT id, code, value, expirydate, status FROM Voucher"; // Lấy tất cả dữ liệu
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            int startIndex = (page - 1) * pageSize;
            int count = 0;
            while (rs.next() && count < pageSize) {
                if (count >= startIndex) {
                    Voucher v = new Voucher(
                            rs.getInt("id"),
                            rs.getString("code"),
                            rs.getFloat("value"),
                            rs.getObject("expirydate", LocalDate.class), // Sử dụng getObject cho LocalDate
                            rs.getInt("status")
                    );
                    list.add(v);
                }
                count++;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL Error in getAllVouchers: " + e.getMessage());
        }
        return list;
    }

    public int getTotalVouchers() {
        String sql = "SELECT COUNT(*) AS total FROM Voucher";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            System.err.println("Error counting vouchers: " + e.getMessage());
        }
        return 0;
    }

    public Voucher getVoucher(int id) {
        String sql = "SELECT code, expirydate, status FROM Voucher WHERE id = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String code = rs.getString("code");
                    LocalDate expiryDate = rs.getObject("expirydate", LocalDate.class); // Sử dụng getObject
                    int status = rs.getInt("status");
                    return new Voucher(id, code, expiryDate, status);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving voucher: " + e.getMessage());
        }
        return null;
    }

    public boolean insertVoucher(Voucher voucher) {
        String sql = "INSERT INTO Voucher (code, value, expirydate, status) VALUES (?, ?, ?, ?)";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, voucher.getCode());
            ps.setFloat(2, voucher.getValue());
            ps.setObject(3, voucher.getExpiryDate()); // Sử dụng setObject cho LocalDate
            ps.setInt(4, voucher.getStatus());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error inserting voucher: " + e.getMessage());
            return false;
        }
    }

    public boolean updateVoucher(Voucher voucher) {
        String sql = "UPDATE Voucher SET code = ?, value = ?, expirydate = ?, status = ? WHERE id = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, voucher.getCode());
            ps.setFloat(2, voucher.getValue());
            ps.setObject(3, voucher.getExpiryDate()); // Sử dụng setObject
            ps.setInt(4, voucher.getStatus());
            ps.setInt(5, voucher.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating voucher: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteVoucher(int id) {
        String sql = "DELETE FROM Voucher WHERE id = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting voucher: " + e.getMessage());
            return false;
        }
    }

    public boolean toggleVoucherStatus(int id, int status) {
        String sql = "UPDATE Voucher SET status = ? WHERE id = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error toggling voucher status: " + e.getMessage());
            return false;
        }
    }
}
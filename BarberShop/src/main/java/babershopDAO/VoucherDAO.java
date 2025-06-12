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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Service;
import model.Voucher;

public class VoucherDAO {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver" + e);
        }
        try {
            Connection con = DriverManager.getConnection(DBURL, USERDB, PASSDB);
            return con;
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public static Voucher getVoucher(int id) {
        String sql = "Select code, value, expiry_date, status from Voucher where id= ?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String code = rs.getString(1);
                double value = rs.getDouble(2);
                String date = rs.getString(3);
                LocalDate expiryDate = LocalDate.parse(date, DateTimeFormatter.ISO_DATE);
                String status = rs.getString(4);
                Voucher voucher = new Voucher(code, (float) value, expiryDate, status);
                return voucher;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static List<Voucher> getAllVoucers() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "Select code, value, expiry_date, status from Voucher";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String code = rs.getString(1);
                double value = rs.getDouble(2);
                String date = rs.getString(3);
                LocalDate expiryDate = LocalDate.parse(date, DateTimeFormatter.ISO_DATE);
                String status = rs.getString(4);
                Voucher voucher = new Voucher(code, (float) value, expiryDate, status);

                vouchers.add(voucher);
            }
            return vouchers;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static void insertVouher (String name, double price, int duration, String description) {
        String sql = "INSERT INTO Service (name, price, duration, description) VALUES (?,?,?,?)";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setInt(3, duration);
            ps.setString(4, description);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void deleteVoucher(int id) {
        String sql = "delete from Voucher where id=?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}

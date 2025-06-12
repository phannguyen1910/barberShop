
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
import model.Invoice;
import model.Service;

public class InvoiceDAO {
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

    public static Invoice getInvoice(int appointmentId) {
        String sql = "Select amount, paymentStatus, receivedDate, voucherId from Invoice where appointmentId=?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                double amount = rs.getDouble(1);
                String paymentStatus = rs.getString(2);
                String date = rs.getString(3);
                LocalDate receivedDate = LocalDate.parse(date, DateTimeFormatter.ISO_DATE);
                Integer voucherId = rs.getInt(4);
                Invoice invoice = new Invoice(amount, paymentStatus, receivedDate, appointmentId, voucherId);
                return invoice;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static List<Invoice> getAllInvoice() {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "Select amount, paymentStatus, receivedDate,appointmentId, voucherId from Invoice";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                double amount = rs.getDouble(1);
                String paymentStatus = rs.getString(2);
                String date = rs.getString(3);
                LocalDate receivedDate = LocalDate.parse(date, DateTimeFormatter.ISO_DATE);
                int appointmentId = rs.getInt(4);
                Integer voucherId = rs.getInt(5);
                Invoice invoice = new Invoice(amount, paymentStatus, receivedDate, appointmentId, voucherId);
                invoices.add(invoice);
            }
            return invoices;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static void insertInvoice(double amount, String paymentStatus, LocalDate receivedDate, int appointmentId, Integer voucherId) {
        String sql = "INSERT INTO Invloice (amount, paymentStatus, receivedDate, appointmentId, voucherId) VALUES (?,?,?,?,?)";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDouble(1, amount);
            ps.setString(2,paymentStatus );
            String formattedDate = receivedDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
            ps.setString(3, formattedDate);
            ps.setInt(4, appointmentId);
            ps.setInt(4, voucherId);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

}

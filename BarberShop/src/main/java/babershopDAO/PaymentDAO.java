/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package babershopDAO;

import static babershopDatabase.databaseInfo.DBURL;
import static babershopDatabase.databaseInfo.DRIVERNAME;
import static babershopDatabase.databaseInfo.PASSDB;
import static babershopDatabase.databaseInfo.USERDB;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import model.Payment;

/**
 *
 * @author Admin
 */
public class PaymentDAO {
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

    public boolean insertPayment(Payment payment) {
    String sql = "INSERT INTO Payment (appointmentId, transactionNo, amount, receivedDate, method) VALUES (?, ?, ?, ?, ?)";
    try (Connection con = getConnect();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, payment.getAppointmentId());
        ps.setString(2, payment.getTransactionNo());
        ps.setFloat(3, (float) payment.getAmount());  // dùng float
        ps.setTimestamp(4, payment.getReceivedDate());
        ps.setString(5, payment.getMethod());

        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
}




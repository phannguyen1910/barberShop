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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;
import model.Service;

/**
 *
 * @author Sekiro
 */
public class FeedbackDAO {

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

    public static List<Feedback> getAllFeedback() {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "Select  customer_id, staff_id, appointment_id, comment, rate, feedback_time";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int customerID = rs.getInt(1);
                int staff = rs.getInt(2);
                int appointmentId = rs.getInt(3);
                String comment = rs.getString(4);
                int rate = rs.getInt(5);
                String date = rs.getString(6);
                LocalDateTime feedbackTime = LocalDateTime.parse(date, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                Feedback feedback = new Feedback(customerID, staff, appointmentId, comment, rate, feedbackTime);
                feedbacks.add(feedback);
            }
            return feedbacks;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static void updateFeedback(int id, String newCommet, int newRate, String newFeedbackTime) {

        String sql = "UPDATE Service SET  comment = ?, rate = ?, feedback_time = ? WHERE id = ?";

        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, newCommet);
            ps.setInt(2, newRate);
            ps.setString(3, newFeedbackTime);
            ps.setInt(4, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void deleteFeedback(int id) {
        String sql = "delete from Feedback where id=?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}

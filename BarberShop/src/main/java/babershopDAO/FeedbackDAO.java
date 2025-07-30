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
        String sql = "SELECT customer_id, staff_id, appointment_id, comment, rate, feedback_time FROM Feedback";
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

    // Phương pháp nâng cao để nhận phản hồi với tên khách hàng và nhân viên
    public static List<Feedback> getAllFeedbackWithNames() {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.customerId, f.staffId, f.appointmentId, f.comment, f.rating, f.feedbackTime, "
                + "c.firstName as customerFirstName, c.lastName as customerLastName, "
                + "s.firstName as staffFirstName, s.lastName as staffLastName "
                + "FROM Feedback f "
                + "LEFT JOIN Customer c ON f.customerId = c.id "
                + "LEFT JOIN Staff s ON f.staffId = s.id "
                + "ORDER BY f.feedbackTime DESC";

        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int customerID = rs.getInt("customerId");
                int staffID = rs.getInt("staffId");
                int appointmentId = rs.getInt("appointmentId");
                String comment = rs.getString("comment");
                int rate = rs.getInt("rating");
                String date = rs.getString("feedbackTime");

                LocalDateTime feedbackTime = null;
                if (date != null) {
                    date = date.trim();
                }
                try {
                    feedbackTime = LocalDateTime.parse(date, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                } catch (Exception e1) {
                    try {
                        feedbackTime = LocalDateTime.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS"));
                    } catch (Exception e2) {
                        try {
                            feedbackTime = LocalDateTime.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                        } catch (Exception e3) {
                            try {
                                feedbackTime = LocalDateTime.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss"));
                            } catch (Exception e4) {
                                System.out.println("Lỗi parse feedbackTime: [" + date + "]");
                                feedbackTime = null;
                            }
                        }
                    }
                }

                Feedback feedback = new Feedback(customerID, staffID, appointmentId, comment, rate, feedbackTime);

                // Đặt tên khách hàng
                String customerFirstName = rs.getString("customerFirstName");
                String customerLastName = rs.getString("customerLastName");
                if (customerFirstName != null && customerLastName != null) {
                    feedback.setCustomerName(customerLastName + " " + customerFirstName);
                } else {
                    feedback.setCustomerName("Khách hàng #" + customerID);
                }

                // Đặt tên nhân viên
                String staffFirstName = rs.getString("staffFirstName");
                String staffLastName = rs.getString("staffLastName");
                if (staffFirstName != null && staffLastName != null) {
                    feedback.setStaffName(staffLastName + " " + staffFirstName);
                } else {
                    feedback.setStaffName("Nhân viên #" + staffID);
                }

                feedbacks.add(feedback);
            }
            return feedbacks;
        } catch (Exception e) {
            System.out.println("Error in getAllFeedbackWithNames: " + e);
        }
        return null;
    }

    // Phương pháp lấy phản hồi theo tên khách hàng
    public static List<Feedback> getFeedbackByCustomerName(String customerName) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.customerId, f.staffId, f.appointmentId, f.comment, f.rating, f.feedbackTime, "
                + "c.firstName as customerFirstName, c.lastName as customerLastName, "
                + "s.firstName as staffFirstName, s.lastName as staffLastName "
                + "FROM Feedback f "
                + "LEFT JOIN Customer c ON f.customerId = c.id "
                + "LEFT JOIN Staff s ON f.staffId = s.id "
                + "WHERE c.firstName LIKE ? OR c.lastName LIKE ? OR CONCAT(c.lastName, ' ', c.firstName) LIKE ? "
                + "ORDER BY f.feedbackTime DESC";

        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            String searchPattern = "%" + customerName + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int customerID = rs.getInt("customerId");
                int staffID = rs.getInt("staffId");
                int appointmentId = rs.getInt("appointmentId");
                String comment = rs.getString("comment");
                int rate = rs.getInt("rating");
                String date = rs.getString("feedbackTime");

                LocalDateTime feedbackTime = null;
                try {
                    feedbackTime = LocalDateTime.parse(date, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                } catch (Exception e) {
                    feedbackTime = LocalDateTime.now();
                }

                Feedback feedback = new Feedback(customerID, staffID, appointmentId, comment, rate, feedbackTime);

                String customerFirstName = rs.getString("customerFirstName");
                String customerLastName = rs.getString("customerLastName");
                if (customerFirstName != null && customerLastName != null) {
                    feedback.setCustomerName(customerLastName + " " + customerFirstName);
                } else {
                    feedback.setCustomerName("Khách hàng #" + customerID);
                }

                String staffFirstName = rs.getString("staffFirstName");
                String staffLastName = rs.getString("staffLastName");
                if (staffFirstName != null && staffLastName != null) {
                    feedback.setStaffName(staffLastName + " " + staffFirstName);
                } else {
                    feedback.setStaffName("Nhân viên #" + staffID);
                }

                feedbacks.add(feedback);
            }
            return feedbacks;
        } catch (Exception e) {
            System.out.println("Error in getFeedbackByCustomerName: " + e);
        }
        return null;
    }

    // Phương pháp nhận phản hồi theo xếp hạng
    public static List<Feedback> getFeedbackByRating(int rating) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.customerId, f.staffId, f.appointmentId, f.comment, f.rating, f.feedbackTime, "
                + "c.firstName as customerFirstName, c.lastName as customerLastName, "
                + "s.firstName as staffFirstName, s.lastName as staffLastName "
                + "FROM Feedback f "
                + "LEFT JOIN Customer c ON f.customerId = c.id "
                + "LEFT JOIN Staff s ON f.staffId = s.id "
                + "WHERE f.rating = ? "
                + "ORDER BY f.feedbackTime DESC";

        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, rating);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int customerID = rs.getInt("customerId");
                int staffID = rs.getInt("staffId");
                int appointmentId = rs.getInt("appointmentId");
                String comment = rs.getString("comment");
                int rate = rs.getInt("rating");
                String date = rs.getString("feedbackTime");

                LocalDateTime feedbackTime = LocalDateTime.parse(date, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                try {
                    feedbackTime = LocalDateTime.parse(date, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                } catch (Exception e) {
                    feedbackTime = LocalDateTime.now();
                }

                Feedback feedback = new Feedback(customerID, staffID, appointmentId, comment, rate, feedbackTime);

                String customerFirstName = rs.getString("customerFirstName");
                String customerLastName = rs.getString("customerLastName");
                if (customerFirstName != null && customerLastName != null) {
                    feedback.setCustomerName(customerLastName + " " + customerFirstName);
                } else {
                    feedback.setCustomerName("Khách hàng #" + customerID);
                }

                String staffFirstName = rs.getString("staffFirstName");
                String staffLastName = rs.getString("staffLastName");
                if (staffFirstName != null && staffLastName != null) {
                    feedback.setStaffName(staffLastName + " " + staffFirstName);
                } else {
                    feedback.setStaffName("Nhân viên #" + staffID);
                }

                feedbacks.add(feedback);
            }
            return feedbacks;
        } catch (Exception e) {
            System.out.println("Error in getFeedbackByRating: " + e);
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

    public static void insertFeedback(Feedback feedback) {
        String sql = "INSERT INTO Feedback (customerId, staffId, appointmentId, serviceId, rating, comment, feedbackTime) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, feedback.getCustomerId());
            ps.setInt(2, feedback.getStaffId());
            ps.setInt(3, feedback.getAppointmentId());
            ps.setInt(4, feedback.getServiceId());
            ps.setInt(5, feedback.getRating());
            ps.setString(6, feedback.getComment());
            ps.setObject(7, feedback.getFeedbackTime());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}

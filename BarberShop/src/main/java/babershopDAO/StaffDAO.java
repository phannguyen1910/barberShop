package babershopDAO;

import static babershopDAO.CustomerDAO.getConnect;
import static babershopDatabase.databaseInfo.DBURL;
import static babershopDatabase.databaseInfo.DRIVERNAME;
import static babershopDatabase.databaseInfo.PASSDB;
import static babershopDatabase.databaseInfo.USERDB;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Appointment;
import model.Customer;
import model.Staff;

public class StaffDAO {

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

    public static Staff getStaffByAccountId(int accountId) {
        String sql = "SELECT * FROM [Staff] WHERE accountId = ?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, accountId);  // Chỉ sử dụng accountId để tìm kiếm
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");  // id là khóa chính của [Staff], có thể khác accountId
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String img = rs.getString("img");
                Staff staff = new Staff(id, firstName, lastName, img);
                System.out.println("Found staff for accountId " + accountId + ": " + staff);
                return staff;
            } else {
                System.out.println("No staff found for accountId: " + accountId);
            }
        } catch (Exception e) {
            System.out.println("Error fetching staff: " + e);
        }
        return null;
    }

    public List<Staff> getAllStaffs() {
        List<Staff> staffs = new ArrayList<>();
        String sql = "SELECT DISTINCT s.id, s.accountId, s.firstName, s.lastName, s.img, "
                + "a.email, a.phoneNumber, a.password, a.role, a.status, "
                + "b.id AS branchId "
                + "FROM Staff s "
                + "JOIN Account a ON s.accountId = a.id "
                + "JOIN Branch b ON s.branchId = b.id";

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                staffs.add(new Staff(
                        rs.getInt("id"),
                        rs.getInt("accountId"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("img"),
                        rs.getString("email"),
                        rs.getString("phoneNumber"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getInt("status"),
                        rs.getInt("branchId")
                ));
            }
        } catch (Exception e) {
            System.out.println("🔥 ERROR in getAllStaffs(): " + e);
        }
        return staffs;
    }

    public static void addStaff(String firstName, String lastName, String email, String phoneNumber, String role, String img, int branchId) {
        Connection con = null;
        PreparedStatement psAccount = null;
        PreparedStatement psStaff = null;
        try {
            con = getConnect();
            if (con != null) {
                con.setAutoCommit(false); // Bắt đầu giao dịch

                // Chèn vào bảng Account
                String sqlAccount = "INSERT INTO Account (email, phoneNumber, password, role, status) VALUES (?, ?, ?, ?, ?)";
                psAccount = con.prepareStatement(sqlAccount, PreparedStatement.RETURN_GENERATED_KEYS);
                psAccount.setString(1, email);
                psAccount.setString(2, phoneNumber != null ? phoneNumber : "");
                psAccount.setString(3, "default123");
                psAccount.setString(4, role);
                psAccount.setInt(5, 1);
                psAccount.executeUpdate();

                int accountId = -1;
                try (ResultSet generatedKeys = psAccount.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        accountId = generatedKeys.getInt(1);
                    } else {
                        throw new SQLException("Failed to retrieve accountId.");
                    }
                }

                // Chèn vào bảng Staff (có branchId)
                String sqlStaff = "INSERT INTO Staff (accountId, firstName, lastName, img, branchId) VALUES (?, ?, ?, ?, ?)";
                psStaff = con.prepareStatement(sqlStaff);
                psStaff.setInt(1, accountId);
                psStaff.setString(2, firstName);
                psStaff.setString(3, lastName);
                psStaff.setString(4, img != null && !img.isEmpty() ? img : null);
                psStaff.setInt(5, branchId);
                psStaff.executeUpdate();

                con.commit();
            }
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    System.out.println("Rollback error: " + ex);
                }
            }
            System.out.println("Error: " + e);
        } finally {
            try {
                if (psAccount != null) {
                    psAccount.close();
                }
                if (psStaff != null) {
                    psStaff.close();
                }
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch (SQLException e) {
                System.out.println("Close error: " + e);
            }
        }
    }

    // Other existing methods in StaffDAO remain unchanged
    public static boolean banStaff(int accountId, int newStatus) {
        String sql = "UPDATE Account SET status = ? WHERE id = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newStatus);
            ps.setInt(2, accountId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deleteStaff(int id) {
        String sql = "UPDATE Staff SET status = 0 WHERE id=?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }

    public Staff getStaffById(int staffId) {
        Staff staff = null;
        String sql = "SELECT firstName, lastName FROM Staff WHERE id = ?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, staffId); // SET GIÁ TRỊ CHO ?
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                staff = new Staff(staffId, firstName, lastName);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Đừng để trống
        }
        return staff;
    }

    public List<Staff> getStaffByBranchId(int branchId) {
        List<Staff> staffs = new ArrayList<>();
        String sql = "SELECT id, firstName, lastName FROM Staff WHERE branchId = ?";

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, branchId); // Gán giá trị branchId vào dấu ?

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int staffId = rs.getInt("id");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");

                Staff staff = new Staff(staffId, firstName, lastName);
                staffs.add(staff);
            }

            if (staffs.isEmpty()) {
                System.out.println("⚠️ Không có nhân viên nào thuộc chi nhánh có ID: " + branchId);
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy danh sách nhân viên theo chi nhánh: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("❌ Lỗi không xác định: " + e.getMessage());
            e.printStackTrace();
        }

        return staffs;
    }

    public static List<Staff> searchAndSortStaff(String name, String email, String role, String sort, Integer branchId) {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT s.id, s.accountId, s.firstName, s.lastName, s.img, "
                + "a.email, a.phoneNumber, a.password, a.role, a.status, "
                + "b.id AS branchId "
                + "FROM Staff s "
                + "JOIN Account a ON s.accountId = a.id "
                + "JOIN Branch b ON s.branchId = b.id "
                + "WHERE 1=1 ";

        if (name != null && !name.trim().isEmpty()) {
            sql += "AND (s.firstName LIKE ? OR s.lastName LIKE ?) ";
        }
        if (email != null && !email.trim().isEmpty()) {
            sql += "AND a.email LIKE ? ";
        }
        if (role != null && !role.trim().isEmpty()) {
            sql += "AND a.role = ? ";
        }
        if (branchId != null) {
            sql += "AND s.branchId = ? ";
        }

        if (sort != null) {
            switch (sort) {
                case "id":
                    sql += "ORDER BY s.id ASC ";
                    break;
                case "name":
                    sql += "ORDER BY s.lastName ASC, s.firstName ASC ";
                    break;
                case "email":
                    sql += "ORDER BY a.email ASC ";
                    break;
                case "role":
                    sql += "ORDER BY a.role ASC ";
                    break;
            }
        }

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            int i = 1;
            if (name != null && !name.trim().isEmpty()) {
                ps.setString(i++, "%" + name + "%");
                ps.setString(i++, "%" + name + "%");
            }
            if (email != null && !email.trim().isEmpty()) {
                ps.setString(i++, "%" + email + "%");
            }
            if (role != null && !role.trim().isEmpty()) {
                ps.setString(i++, role);
            }
            if (branchId != null) {
                ps.setInt(i++, branchId);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Staff(
                        rs.getInt("id"),
                        rs.getInt("accountId"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("img"),
                        rs.getString("email"),
                        rs.getString("phoneNumber"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getInt("status"),
                        rs.getInt("branchId")
                ));
            }
        } catch (Exception e) {
            System.out.println("❌ Error in searchAndSortStaff(): " + e);
        }
        return list;
    }

    public List<Appointment> appointmentOfStaff(int staffId) {
        String sql = "SELECT id, customerId, appointmentTime, status FROM Appointment WHERE staffId = ?";
        String sq2 = "SELECT s.name FROM Appointment_Service as inner join Service s on as.serviceId = s.id WHERE as.apppointmentId = ?";
        List<Appointment> appointments = new ArrayList<>();
        String serviceName = null;

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, staffId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int appointmentId = rs.getInt("id");
                int customerId = rs.getInt("customerId");
                String appointmentTime = rs.getString("appointmentTime");
                LocalDateTime appointment_time = LocalDateTime.parse(appointmentTime, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                String status = rs.getString("status");
                PreparedStatement ps2 = con.prepareStatement(sq2);
                ps2.setInt(1, appointmentId);
                ResultSet rs2 = ps2.executeQuery();
                while (rs2.next()) {
                    serviceName += rs.getString("s.name") + ", ";
                }
                Appointment appointment = new Appointment(staffId, customerId, staffId, appointment_time, status);
                appointments.add(appointment);
            }
            return appointments;

        } catch (Exception e) {
            System.err.println("❌ Lỗi không xác định: " + e.getMessage());
            e.printStackTrace();
        }
        return appointments;
    }

}

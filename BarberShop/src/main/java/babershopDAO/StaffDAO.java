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
import java.time.format.DateTimeParseException;
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
        String sql = "SELECT s.id, s.accountId, s.firstName, s.lastName, s.img, s.branchId, a.email, a.phoneNumber, a.password, a.role, a.status " +
                     "FROM Staff s JOIN Account a ON s.accountId = a.id WHERE s.accountId = ?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                int accId = rs.getInt("accountId");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String img = rs.getString("img");
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phoneNumber");
                String password = rs.getString("password");
                String role = rs.getString("role");
                int status = rs.getInt("status");
                int branchId = rs.getInt("branchId");
                Staff staff = new Staff(id, accId, firstName, lastName, img, email, phoneNumber, password, role, status, branchId);
                System.out.println("Found staff for accountId " + accountId + ": " + staff);
                return staff;
            } else   {
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

        String sql
                = "SELECT a.id, a.customerId, a.appointmentTime, a.status, a.branchId, "
                + "       c.firstName, c.lastName "
                + "FROM Appointment a "
                + "INNER JOIN Customer c ON a.customerId = c.id "
                + "WHERE a.staffId = ? "
                + "  AND a.status = 'Confirmed' "
                + "  AND a.appointmentTime >= CAST(GETDATE() AS DATE) "
                + "  AND a.appointmentTime < DATEADD(DAY, 1, CAST(GETDATE() AS DATE));";

        String sq2 = " SELECT s.name FROM Appointment_Service aps INNER JOIN Service s ON aps.ServiceId = s.idWHERE aps.AppointmentId = ?";

        String sq3 = "SELECT totalAmount FROM Invoice WHERE appointmentId = ?";

        

        List<Appointment> appointments = new ArrayList<>();

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {

            System.out.println("🔍 Truy vấn các cuộc hẹn hôm nay của staffId = " + staffId);
            ps.setInt(1, staffId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment appointment = new Appointment();
                int appointmentId = rs.getInt("id");

                appointment.setId(appointmentId);
                appointment.setCustomerId(rs.getInt("customerId"));
                appointment.setCustomerName(rs.getString("lastName") + " " + rs.getString("firstName"));
                appointment.setStatus(rs.getString("status"));

                LocalDateTime apptTime = rs.getObject("appointmentTime", LocalDateTime.class);
                appointment.setAppointmentTime(apptTime);

                // Lấy danh sách dịch vụ
                StringBuilder serviceName = new StringBuilder();
                try (PreparedStatement ps2 = con.prepareStatement(sq2)) {
                    ps2.setInt(1, appointmentId);
                    try (ResultSet rs2 = ps2.executeQuery()) {
                        while (rs2.next()) {
                            String sname = rs2.getString("name");
                            serviceName.append(sname).append(", ");
                            System.out.println("  ➕ Dịch vụ: " + sname);
                        }
                    }
                } catch (SQLException ex2) {
                    System.err.println("❌ Lỗi dịch vụ appointmentId = " + appointmentId + ": " + ex2.getMessage());

                }

                String services = serviceName.length() > 0
                        ? serviceName.substring(0, serviceName.length() - 2)
                        : "";
                appointment.setServices(services);

                // Lấy totalAmount từ hóa đơn
                float totalAmount = 0;
                try (PreparedStatement ps3 = con.prepareStatement(sq3)) {
                    ps3.setInt(1, appointmentId);
                    try (ResultSet rs3 = ps3.executeQuery()) {
                        if (rs3.next()) {
                            totalAmount = rs3.getFloat("totalAmount");
                            System.out.println("  💵 Tổng tiền: " + totalAmount);
                        }
                    }
                    appointment.setTotalAmount(totalAmount);
                } catch (SQLException ex3) {
                    System.err.println("❌ Lỗi hóa đơn appointmentId = " + appointmentId + ": " + ex3.getMessage());
                }

                appointments.add(appointment);
            }

            System.out.println("✅ Tổng số cuộc hẹn tìm thấy: " + appointments.size());

        } catch (SQLException e) {
            System.err.println("❌ Lỗi SQL trong appointmentOfStaff: " + e.getMessage());
            e.printStackTrace();

        } catch (Exception e) {
            System.err.println("❌ Lỗi không xác định trong appointmentOfStaff: " + e.getMessage());
            e.printStackTrace();
        }

        return appointments;
    }

}

package babershopDAO;

import static babershopDAO.CustomerDAO.getConnect;
import babershopDatabase.databaseInfo;
import static babershopDatabase.databaseInfo.DBURL;
import static babershopDatabase.databaseInfo.DRIVERNAME;
import static babershopDatabase.databaseInfo.PASSDB;
import static babershopDatabase.databaseInfo.USERDB;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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

    public static Staff getStaffByAccountId(int staffId) {
        String sql = "SELECT * FROM [Staff] WHERE id = ?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String img = rs.getString("img");
                Staff staff = new Staff(firstName, lastName, img);
                System.out.println(staff);
                return staff;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
//da sua chu y xem lai
    public static List<Staff> getAllStaffs() {

        List<Staff> staffs = new ArrayList<>();
        String sql = "SELECT id, firstName, lastName, img FROM [Staff]";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int staffId = rs.getInt("id");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String img = rs.getString("img");
                Staff staff = new Staff(staffId, firstName, lastName, img);

                staffs.add(staff);
            }
            return staffs;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
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



    public static void updateStaff(int id, String firstName, String lastName, String email, String password, String phoneNumber) {

        String sql = "UPDATE Staff SET first_name = ?, last_name = ?, email = ?, password = ?, phone_number = ? WHERE id = ?";

        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.setString(5, phoneNumber);
            ps.setInt(6, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void addStaff(String firstName, String lastName, String email, String phoneNumber, String role, String img) {
        Connection con = null;
        PreparedStatement psAccount = null;
        PreparedStatement psStaff = null;
        try {
            con = getConnect();
            if (con != null) {
                con.setAutoCommit(false); // Bắt đầu giao dịch

                // Bước 1: Chèn vào bảng Account
                String sqlAccount = "INSERT INTO Account (email, phoneNumber, password, role, status) VALUES (?, ?, ?, ?, ?)";
                psAccount = con.prepareStatement(sqlAccount, PreparedStatement.RETURN_GENERATED_KEYS);
                psAccount.setString(1, email);
                psAccount.setString(2, phoneNumber != null ? phoneNumber : "");
                psAccount.setString(3, "default123"); // Mật khẩu mặc định (nên mã hóa trong thực tế)
                psAccount.setString(4, role);
                psAccount.setInt(5, 1); // Trạng thái mặc định là 1 (hoạt động)
                psAccount.executeUpdate();

                // Lấy accountId vừa tạo
                int accountId = -1;
                try (ResultSet generatedKeys = psAccount.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        accountId = generatedKeys.getInt(1);
                    } else {
                        throw new SQLException("Failed to retrieve accountId.");
                    }
                }

                // Bước 2: Chèn vào bảng Staff
                String sqlStaff = "INSERT INTO Staff (accountId, firstName, lastName, img) VALUES (?, ?, ?, ?)";
                psStaff = con.prepareStatement(sqlStaff);
                psStaff.setInt(1, accountId);
                psStaff.setString(2, firstName);
                psStaff.setString(3, lastName);
                psStaff.setString(4, img != null && !img.isEmpty() ? img : null); // Cho phép NULL nếu không có ảnh
                psStaff.executeUpdate();

                con.commit(); // Hoàn tất giao dịch
            }
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback(); // Rollback nếu có lỗi
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

    public static void main(String[] args) {
        System.out.println("1");
    }

    public static List<Staff> searchAndSortStaff(String name, String email, String role, String sort) {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT s.id, s.accountId, s.firstName, s.lastName, s.img, "
                + "a.email, a.phoneNumber, a.password, a.role, a.status "
                + "FROM Staff s JOIN Account a ON s.accountId = a.id WHERE 1=1 ";

        if (name != null && !name.isEmpty()) {
            sql += "AND (s.firstName LIKE ? OR s.lastName LIKE ?) ";
        }
        if (email != null && !email.isEmpty()) {
            sql += "AND a.email LIKE ? ";
        }
        if (role != null && !role.isEmpty()) {
            sql += "AND a.role = ? ";
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
            if (name != null && !name.isEmpty()) {
                ps.setString(i++, "%" + name + "%");
                ps.setString(i++, "%" + name + "%");
            }
            if (email != null && !email.isEmpty()) {
                ps.setString(i++, "%" + email + "%");
            }
            if (role != null && !role.isEmpty()) {
                ps.setString(i++, role);
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
                        rs.getInt("status")
                ));
            }
        } catch (Exception e) {
            System.out.println("❌ Lỗi ở searchAndSortStaff(): " + e);
        }

        return list;
    }

}

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
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Admin;
import model.Customer;
import model.Staff;

public class AccountDAO {

    private static String password; 

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver" + e);
        }
        try {
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public static Account checkAccount(String email, String password) {
        String sql = "SELECT * FROM dbo.Account WHERE email = ? AND password = ? AND status = 1";
        try (Connection con = getConnect()) {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String phoneNumber = rs.getString("phoneNumber");
                String role = rs.getString("role");
                Account account = new Account(id, email, password, role, 1, phoneNumber) {
                };
                return account;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public static boolean updateEmail(int accountId, String newEmail) {
        String sql = "UPDATE Account SET email = ? WHERE id = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newEmail);
            ps.setInt(2, accountId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean checkExistedEmail(String email) {
        String sql = "Select * FROM Account WHERE email = ?";
        try (Connection conn = getConnect(); PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, email);
            return st.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean updatePassByEmail(String password, String email) {
        String sql = "Update [Account] set [password] = ? FROM [Account] WHERE email =?";
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, password);
            stmt.setString(2, email);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static int addAccount(String email, String phoneNumber) {
        String sql = "INSERT INTO [dbo].[Account] (email, phoneNumber, password, role, status) VALUES (?,?, ?, 'Customer', 1); SELECT SCOPE_IDENTITY()";
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, phoneNumber != null ? phoneNumber : "");
            stmt.setString(3, "google-auth"); // Gán giá trị mặc đinhj cho password khi đăng nhập = gg
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static Account getAccountByEmail(String email) {
        String sql = "SELECT * FROM [dbo].[Account] WHERE email = ? AND status = 1";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String phoneNumber = rs.getString("phoneNumber");
                String role = rs.getString("role");
                return new Account(id, email, null, role, 1, phoneNumber) {
                };
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public static Account getAccountById(int id) {
        String sql = "SELECT id, email, phoneNumber, password, role FROM [Account] WHERE id = ?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phoneNumber");
                String password = rs.getString("password");
                String role = rs.getString("role");
                return new Account(id, email, password, role, 1, phoneNumber) {
                };
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static Account getAllAccount() {
        String sql = "SELECT email, phoneNumber, status FROM [Account] WHERE phoneNumber = ? and status = 1 and role = 'Customer'";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phoneNumber");
                int status = rs.getInt("status");
                return new Account(email, phoneNumber, status) {
                };
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public String changePassword(String email, String currentPassword, String newPassword) {
        String sql1 = "SELECT password FROM Account WHERE email = ?";
        String sql2 = "UPDATE Account SET password = ? WHERE email = ?";

        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql1);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Kiểm tra nếu mật khẩu cũ không đúng
                if (rs.getString(1).equals(currentPassword)) {
                    System.out.println(currentPassword);
                    // Kiểm tra mật khẩu mới khác với mật khẩu cũ
                    if (currentPassword.equals(newPassword)) {
                        return "Mật khẩu mới cần khác với mật khẩu hiện tại";
                    } else {
                        // Cập nhật mật khẩu mới
                        try (PreparedStatement ps2 = con.prepareStatement(sql2)) {
                            ps2.setString(1, newPassword); // Thay đổi mật khẩu
                            ps2.setString(2, email); // Điều kiện cập nhật
                            if (ps2.executeUpdate() > 0) {
                                return null; // Cập nhật thành công
                            } else {
                                return "Lỗi khi cập nhật mật khẩu";
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            return "Lỗi khi cập nhật mật khẩu";
                        }
                    }
                } else {
                    return "Mật khẩu hiện tại không đúng";
                }
            } else {
                return "Tài khoản không tồn tại";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Lỗi kết nối cơ sở dữ liệu";
        }
    }

    public String editProfile(int idAcount, String firstName, String lastName, String phoneNumber) {
        String sqlGetRole = "SELECT role FROM Account WHERE id=?";
        String sqlUpdatePhone = "UPDATE Account SET phoneNumber=? WHERE id=?";
        String sqlUpdateCustomer = "UPDATE Customer SET firstName=?, lastName=? WHERE accountID=?";
        String sqlUpdateStaff = "UPDATE Staff SET firstName=?, lastName=? WHERE accountID=?";
        String sqlUpdateAdmin = "UPDATE Admin SET firstName=?, lastName=? WHERE accountID=?";

        try (Connection con = getConnect(); PreparedStatement psGetRole = con.prepareStatement(sqlGetRole)) {

            psGetRole.setInt(1, idAcount);
            try (ResultSet rs = psGetRole.executeQuery()) {
                if (rs.next()) {
                    String role = rs.getString("role");

                    try (PreparedStatement psUpdatePhone = con.prepareStatement(sqlUpdatePhone)) {
                        psUpdatePhone.setString(1, phoneNumber);
                        psUpdatePhone.setInt(2, idAcount);
                        psUpdatePhone.executeUpdate();
                    }

                    String updateSQL = null;
                    switch (role) {
                        case "Customer":
                            updateSQL = sqlUpdateCustomer;
                            break;
                        case "Staff":
                            updateSQL = sqlUpdateStaff;
                            break;
                        case "Admin":
                            updateSQL = sqlUpdateAdmin;
                            break;
                    }

                    if (updateSQL != null) {
                        try (PreparedStatement psUpdate = con.prepareStatement(updateSQL)) {
                            psUpdate.setString(1, firstName);
                            psUpdate.setString(2, lastName);
                            psUpdate.setInt(3, idAcount);
                            int check = psUpdate.executeUpdate();
                            return (check > 0) ? "Change profile successful" : "Không thể edit profile";
                        }
                    } else {
                        return "Không xác định được role";
                    }
                } else {
                    return "Không tìm thấy tài khoản";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Lỗi khi cập nhật thông tin";
        }
    }

    public String checkRole(int accountId) {
        String sql = "Select role from Account where id=?";
        try (Connection con = getConnect()) {

            PreparedStatement ps1 = con.prepareStatement(sql);
            ps1.setInt(1, accountId);
            ResultSet rs = ps1.executeQuery();
            if (rs.next()) {
                String role = rs.getString("role");
                return role;
            }
        } catch (Exception e) {

        }
        return "Khong tim thay role";
    }

    public List<Customer> listCustomers() {
        String selectCustomer = "SELECT * FROM Customer c INNER JOIN Account a ON c.accountId = a.id;";
        try (Connection con = getConnect()) {
            PreparedStatement ps1 = con.prepareStatement(selectCustomer);
            List<Customer> customers = new ArrayList<>();
            ResultSet rs = ps1.executeQuery();
            while (rs.next()) {
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String phoneNumber = rs.getString("phoneNUmber");
                Customer customer = new Customer(email, phoneNumber, password, "Customer", 1, firstName, lastName);
                customers.add(customer);
            }
            return customers;
        } catch (Exception e) {

        }
        return null;
    }

    public List<Staff> listStaffs() {
        String selectStaff = "SELECT * FROM Staff s INNER JOIN Account a ON s.accountId = a.id;";
        try (Connection con = getConnect()) {
            PreparedStatement ps1 = con.prepareStatement(selectStaff);
            List<Staff> staffs = new ArrayList<>();
            ResultSet rs = ps1.executeQuery();
            while (rs.next()) {
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String phoneNumber = rs.getString("phoneNUmber");
                Staff staff = new Staff(firstName, lastName, email, phoneNumber, password, email, 1);
                staffs.add(staff);
            }
            return staffs;
        } catch (Exception e) {

        }
        return null;
    }

    public List<Admin> listAdmins() {
        String selectAdmin = "SELECT * FROM Admin admin INNER JOIN Account a ON admin.accountId = a.id;";
        try (Connection con = getConnect()) {
            PreparedStatement ps1 = con.prepareStatement(selectAdmin);
            List<Admin> admins = new ArrayList<>();
            ResultSet rs = ps1.executeQuery();
            while (rs.next()) {
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String phoneNumber = rs.getString("phoneNUmber");
                Admin admin = new Admin(email, phoneNumber, password, email, 1, firstName, lastName);
                admins.add(admin);
            }
            return admins;
        } catch (Exception e) {

        }
        return null;
    }

}

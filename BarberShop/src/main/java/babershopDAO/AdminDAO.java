package babershopDAO;

import static babershopDAO.StaffDAO.getConnect;
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
import model.Admin;
import model.Customer;
import model.Staff;

public class AdminDAO {

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
    
  public Admin checkAdmin(String username, String password) {
        String sql = "SELECT first_name, last_name, email, phone_number FROM Admin WHERE email = ? and password = ?";
        try (Connection con = getConnect()) {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Admin admin = new Admin(rs.getString("first_name"), rs.getString("last_name"), rs.getString("email"), rs.getString("phone_number"));
                return admin;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public static Admin getAdminByAccountId(int accountId) {
        String sql = "SELECT * FROM [Admin] WHERE accountId = ?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                Admin cs = new Admin(firstName, lastName);
                System.out.println(cs);
                return cs;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static List<Admin> getAllAdmin() {
        List<Admin> admins = new ArrayList<>();
        String sql = "SELECT first_name, last_name, email, phone_number FROM [Admin]";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String firstName = rs.getString(1);
                String lastName = rs.getString(2);
                String email = rs.getString(3);
                String phoneNumber = rs.getString(4);
                Admin admin = new Admin(firstName, lastName, email, phoneNumber);
                admins.add(admin);
            }
            return admins;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static void insertAdmin(String firstName, String lastName, String email, String password, String phoneNumber) {
        String sql = "INSERT INTO Admin (first_name, last_name, email, password, phone_number) VALUES (?,?,?,?,?)";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.setString(5, phoneNumber);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void updateAdmin(int id, String firstName, String lastName, String email, String password, String phoneNumber) {

        String sql = "UPDATE Admin SET first_name = ?, last_name = ?, email = ?, password = ?, phone_number = ? WHERE id = ?";

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
}

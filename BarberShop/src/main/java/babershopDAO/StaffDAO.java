/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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

    public static void insertStaff(String firstName, String lastName, String email, String password, String phoneNumber) {
        String sql = "INSERT INTO Staff (first_name, last_name, email, password, phone_number) VALUES (?,?,?,?,?)";
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

    public static void main(String[] args) {
        System.out.println("1");
    }
}

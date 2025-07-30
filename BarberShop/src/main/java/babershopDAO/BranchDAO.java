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
import java.util.ArrayList;
import java.util.List;
import model.Branch;

public class BranchDAO {

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
    
    
    public String getBranchNameById (int branchId) {
        String sql = "SELECT name FROM Branch WHERE id = ?";

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, branchId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                return name;
            } else {
                System.out.println("⚠️ Không tìm thấy chi nhánh với ID: " + branchId);
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi truy vấn tên chi nhánh theo ID: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("❌ Lỗi không xác định khi tìm chi nhánh: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }
    

    public List<Branch> getAllBranches() {
        List<Branch> branches = new ArrayList<>();
        String sql = "SELECT id, name, address, status , city FROM Branch";

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String address = rs.getString("address");
                boolean status = rs.getBoolean("status");
                String city = rs.getString("city");
                Branch branch = new Branch(id, name, address, status, city);
                branches.add(branch);
            }
            return branches;
        } catch (Exception e) {
            System.out.println("❌ Lỗi khi lấy danh sách chi nhánh: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    public Branch getBranchById(int branchId) {
        String sql = "SELECT * FROM Branch WHERE id = ?";

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, branchId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String address = rs.getString("address");
                boolean status = rs.getBoolean("status");
                String city = rs.getString("city");
                Branch branch = new Branch(branchId, name, address, status, city);
                System.out.println("✅ Tìm thấy chi nhánh có ID " + branchId + ": " + branch.getName());
                return branch;
            } else {
                System.out.println("⚠️ Không tìm thấy chi nhánh với ID: " + branchId);
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi truy vấn chi nhánh theo ID: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("❌ Lỗi không xác định khi tìm chi nhánh: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

}

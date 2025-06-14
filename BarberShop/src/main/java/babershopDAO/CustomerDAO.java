package babershopDAO;

import static babershopDatabase.databaseInfo.*;
import java.sql.*;
import java.util.*;
import model.Customer;

public class CustomerDAO {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (Exception e) {
            System.out.println("🔥 ERROR in getConnect(): " + e);
        }
        return null;
    }

    public static Customer getCustomer(int id) {
        String sql = "SELECT c.id, c.accountId, c.firstName, c.lastName, a.email, a.phoneNumber, a.password, a.role, a.status " +
                     "FROM Customer c JOIN Account a ON c.accountId = a.id WHERE c.id = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Customer(
                    rs.getInt("id"),
                    rs.getInt("accountId"),
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("email"),
                    rs.getString("phoneNumber"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getInt("status")
                );
            }
        } catch (Exception e) {
            System.out.println("🔥 ERROR in getCustomer(): " + e);
        }
        return null;
    }

    public static Customer getCustomerByAccountId(int accountId) {
        String sql = "SELECT c.id, c.accountId, c.firstName, c.lastName, a.email, a.phoneNumber, a.password, a.role, a.status " +
                     "FROM Customer c JOIN Account a ON c.accountId = a.id WHERE c.accountId = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Customer(
                    rs.getInt("id"),
                    rs.getInt("accountId"),
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("email"),
                    rs.getString("phoneNumber"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getInt("status")
                );
            }
        } catch (Exception e) {
            System.out.println("🔥 ERROR in getCustomerByAccountId(): " + e);
        }
        return null;
    }
    public static int getCustomerIdByAccountId(int accountId) {
        String sql = "SELECT id FROM [Customer] WHERE accountId = ?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int customerId = rs.getInt("id");
                return customerId;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }
    public static Customer getCustomerById(int id) {
        String sql = "SELECT * FROM [Customer] WHERE id = ?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                int accountId = rs.getInt("accountId");
                Customer cs = new Customer(id, accountId, firstName, lastName);
                System.out.println(cs);
                return cs;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static String getCustomerFullName(int customerId) {
        Customer c = getCustomer(customerId);
        return c != null ? c.getLastName() + " " + c.getFirstName() : "Unknown";
    }

    public static List<Customer> getAllCustomer() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT DISTINCT c.id, c.accountId, c.firstName, c.lastName, a.email, a.phoneNumber, a.password, a.role, a.status " +
                     "FROM Customer c JOIN Account a ON c.accountId = a.id";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                customers.add(new Customer(
                    rs.getInt("id"),
                    rs.getInt("accountId"),
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("email"),
                    rs.getString("phoneNumber"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getInt("status")
                ));
            }
        } catch (Exception e) {
            System.out.println("🔥 ERROR in getAllCustomer(): " + e);
        }
        return customers;
    }
    public static boolean checkEmailExist(String email) {
        String sql = "Select id from Account where email=?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {

        }
        return false;
    }
    public static boolean checkPhoneExist(String phoneNummber) {
        String sql = "Select id from Account where phoneNumber=?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, phoneNummber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {

        }
        return false;

  
}
    

    public static void insertCustomer(Customer customer) {
    String sqlAccount = "INSERT INTO Account (email, phoneNumber, password, role, status) VALUES (?, ?, ?, ?, ?)";
    String sqlCustomer = "INSERT INTO Customer (accountId, firstName, lastName) VALUES (?, ?, ?)";

    try (Connection con = getConnect()) {
        con.setAutoCommit(false);

        // 1. Thêm vào Account
        PreparedStatement psAcc = con.prepareStatement(sqlAccount, Statement.RETURN_GENERATED_KEYS);
        psAcc.setString(1, customer.getEmail());
        psAcc.setString(2, customer.getPhoneNumber());
        psAcc.setString(3, customer.getPassword());
        psAcc.setString(4, customer.getRole());
        psAcc.setInt(5, customer.getStatus());
        psAcc.executeUpdate();

        // 2. Lấy accountId mới sinh
        ResultSet rs = psAcc.getGeneratedKeys();
        int accountId = -1;
        if (rs.next()) {
            accountId = rs.getInt(1);
        }

        // 3. Thêm vào Customer
        PreparedStatement psCus = con.prepareStatement(sqlCustomer);
        psCus.setInt(1, accountId);
        psCus.setString(2, customer.getFirstName());
        psCus.setString(3, customer.getLastName());
        psCus.executeUpdate();

        con.commit();
        System.out.println("✅ Thêm khách hàng thành công vào cả Account và Customer!");
    } catch (Exception e) {
        System.out.println("🔥 ERROR in insertCustomer(Customer): " + e);
    }
}


    public static void updateCustomer(int id, String firstName, String lastName, String email, String password, String phoneNumber) {
        String sqlCustomer = "UPDATE Customer SET firstName = ?, lastName = ? WHERE id = ?";
        String sqlAccount = "UPDATE Account SET email = ?, password = ?, phoneNumber = ? WHERE id = (SELECT accountId FROM Customer WHERE id = ?)";
        try (Connection con = getConnect()) {
            con.setAutoCommit(false);

            PreparedStatement ps1 = con.prepareStatement(sqlCustomer);
            ps1.setString(1, firstName);
            ps1.setString(2, lastName);
            ps1.setInt(3, id);
            ps1.executeUpdate();

            PreparedStatement ps2 = con.prepareStatement(sqlAccount);
            ps2.setString(1, email);
            ps2.setString(2, password);
            ps2.setString(3, phoneNumber);
            ps2.setInt(4, id);
            ps2.executeUpdate();

            con.commit();
            System.out.println("✅ Updated customer with ID: " + id);
        } catch (Exception e) {
            System.out.println("🔥 ERROR in updateCustomer(): " + e);
        }
    }

    public static boolean deleteCustomer(int id) {
        String sql = "UPDATE Customer SET status = 0 WHERE id = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("🔥 ERROR in deleteCustomer(): " + e);
        }
        return false;
    }
     // ✅ BAN/UNBAN CUSTOMER
    public static boolean banCustomer(int accountId, boolean ban) {
        String sql = "UPDATE Account SET status = ? WHERE id = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, ban ? 0 : 1);
            ps.setInt(2, accountId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("🔥 ERROR in banCustomer(): " + e);
            return false;
        }
    }
     public static void insertCustomer(String firstName, String lastName, String email, String password, String phoneNumber) {
        String sql1 = "INSERT INTO Account (email, phoneNumber, password , role) VALUES (?,?,?,?)";
        String sql2 = "INSERT INTO Customer (accountId, firstName, lastName) VALUES (?,?,?)";
        try (Connection con = getConnect()) {
            PreparedStatement accountStmt = con.prepareStatement(sql1, PreparedStatement.RETURN_GENERATED_KEYS);
            accountStmt.setString(1, email);
            accountStmt.setString(2, phoneNumber);
            accountStmt.setString(3, password);
            accountStmt.setString(4, "Customer");
            int affectedRows = accountStmt.executeUpdate();
            if (affectedRows == 0) {
                con.rollback();
            }
            ResultSet rs = accountStmt.getGeneratedKeys();
            int accountID = 0;
            if (rs.next()) {
                accountID = rs.getInt(1);
            }

            PreparedStatement customerStmt = con.prepareStatement(sql2);
            customerStmt.setInt(1, accountID);
            customerStmt.setString(2, firstName);
            customerStmt.setString(3, lastName);
            affectedRows = customerStmt.executeUpdate();
            if (affectedRows > 0) {
                // neu commit thanh cong
                con.commit();
            } else {
                con.rollback();

            }
        } catch (SQLException e) {
            try (Connection con = getConnect()) {
                con.rollback();  // Rollback nếu có lỗi
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try (Connection con = getConnect();) {
                con.setAutoCommit(true);  // Đặt lại chế độ commit tự động
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }




    public static List<Customer> searchAndSortCustomers(String name, String email, String phone, String sort) {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT c.id, c.accountId, c.firstName, c.lastName, a.email, a.phoneNumber, a.password, a.role, a.status " +
                     "FROM Customer c JOIN Account a ON c.accountId = a.id WHERE 1=1 ";

        if (name != null && !name.isEmpty()) {
            sql += "AND (c.firstName LIKE ? OR c.lastName LIKE ?) ";
        }
        if (email != null && !email.isEmpty()) {
            sql += "AND a.email LIKE ? ";
        }
        if (phone != null && !phone.isEmpty()) {
            sql += "AND a.phoneNumber LIKE ? ";
        }

        if (sort != null) {
            switch (sort) {
                case "id": sql += "ORDER BY c.id ASC"; break;
                case "name": sql += "ORDER BY c.lastName ASC, c.firstName ASC"; break;
                case "email": sql += "ORDER BY a.email ASC"; break;
                case "phone": sql += "ORDER BY a.phoneNumber ASC"; break;
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
            if (phone != null && !phone.isEmpty()) {
                ps.setString(i++, "%" + phone + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Customer(
                    rs.getInt("id"),
                    rs.getInt("accountId"),
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("email"),
                    rs.getString("phoneNumber"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getInt("status")
                ));
            }
        } catch (Exception e) {
            System.out.println("🔥 ERROR in searchAndSortCustomers(): " + e);
        }
        return list;
    }
    public static void insertCustomer(int accountId, String firstName, String lastName) {
        String sql = "INSERT INTO Customer (accountId, firstName, lastName) VALUES (?, ?, ?)";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, accountId);
            ps.setString(2, firstName);
            ps.setString(3, lastName);
            ps.executeUpdate();
            System.out.println("Đã thêm customer với accountId: " + accountId);
        } catch (Exception e) {
            System.out.println("Lỗi khi thêm customer: " + e);
            e.printStackTrace();
        }
    }

    
} 

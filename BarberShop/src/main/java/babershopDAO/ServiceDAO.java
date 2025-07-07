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
import model.Service;
import model.Staff;

public class ServiceDAO {

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

    public Service getService(int id) {
        String sql = "Select name ,price ,duration ,description from Service where id= ?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String name = rs.getString(1);
                double price = rs.getDouble(2);
                int duration = rs.getInt(3);
                String description = rs.getString(4);
                Service service = new Service(name, price, duration, description);
                return service;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    
    public int calculateTotalServiceDuration(int[] serviceIds) {
        if (serviceIds == null || serviceIds.length == 0) {
            return 0; // Không có dịch vụ nào, tổng thời lượng là 0
        }

        int totalDuration = 0;
        // Xây dựng mệnh đề IN cho truy vấn SQL
        StringBuilder sql = new StringBuilder("SELECT duration FROM Service WHERE id IN (");
        for (int i = 0; i < serviceIds.length; i++) {
            sql.append("?");
            if (i < serviceIds.length - 1) {
                sql.append(", ");
            }
        }
        sql.append(")");

        try (Connection con = getConnect(); // Sử dụng phương thức getConnect() của ServiceDAO
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            // Đặt các tham số cho mệnh đề IN
            for (int i = 0; i < serviceIds.length; i++) {
                ps.setInt(i + 1, serviceIds[i]);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                totalDuration += rs.getInt("duration");
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL khi tính tổng thời lượng dịch vụ: " + e.getMessage());
            e.printStackTrace();
            // Tùy chọn: bạn có thể ném một ngoại lệ tùy chỉnh hoặc ném lại SQLException
            // để chỉ ra rằng có lỗi trong quá trình tính toán.
            return 0; // Trả về 0 hoặc một giá trị đặc biệt để báo hiệu lỗi
        }
        return totalDuration;
    }

    public float getFeeService(String serviceName) {
        String sql = "Select price from Service where name= ?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, serviceName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                float price = rs.getFloat("price");
                return price;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getServiceIdByName(String serviceName) {

        String sql = "Select id from Service where name =?";
        try (Connection con = getConnect()) {
            int serviceId=0;
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, serviceName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                serviceId = rs.getInt("id");
            }
            return serviceId;
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }

    public List<Service> getChoosedService(String[] serviceName) {
        List<Service> services = new ArrayList<>();
        String sql = "Select id ,price from Service where name = ?";
        try (Connection con = getConnect()) {
            for (int i = 0; i < serviceName.length; i++) {
                String name = serviceName[i];
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    int id = rs.getInt("id");
                    float price = rs.getFloat("price");
                    Service service = new Service(id, name, price);
                    services.add(service);
                }
            }
            return services;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Service> getAllService() {
        List<Service> services = new ArrayList<>();
        String sql = "Select * from Service";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                float price = rs.getFloat("price");
                int duration = rs.getInt("duration");
                String description = rs.getString("description");
                String image = rs.getString("image");
                String[] images = image.split(", ");
                int categoryId = rs.getInt("categoryId");
                Service service = new Service(id, name, price, duration, description, images, categoryId);
                services.add(service);
                
                        
            }
           
            return services;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public void insertService(String name, double price, int duration, String description) {
        String sql = "INSERT INTO Service (name, price, duration, description) VALUES (?,?,?,?)";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setInt(3, duration);
            ps.setString(4, description);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void updateService(int id, String name, float price, int duration, String description) {

        String sql = "UPDATE Service SET name = ?, price = ?, duration = ?, description = ? WHERE id = ?";

        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setFloat(2, price);
            ps.setInt(3, duration);
            ps.setString(4, description);
            ps.setInt(5, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void deleteService(int id) {
        String sql = "delete from Service where id=?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    public String getServiceNameById(int serviceId){
        String sql = "Select name from Service where id=?";
        String name = null;
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
            }
            return name;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public double getServicePriceById(int serviceId) {
    String sql = "SELECT price FROM Service WHERE id = ?";
    try (Connection con = AppointmentDAO.getConnect();  // dùng chung connection nếu ServiceDAO không có riêng
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, serviceId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getDouble("price");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

    public Service getServiceById(int id) {
    String sql = "SELECT id, name, price FROM Service WHERE id = ?";
    try (Connection con = AppointmentDAO.getConnect();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Service service = new Service();
            service.setId(rs.getInt("id"));
            service.setName(rs.getString("name"));
            service.setPrice(rs.getFloat("price"));
            return service;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
    
    


}

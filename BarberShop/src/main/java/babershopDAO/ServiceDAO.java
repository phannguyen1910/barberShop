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
                String[] images = image.split(",");
                Service service = new Service(id, name, price, duration, description, images);
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

}

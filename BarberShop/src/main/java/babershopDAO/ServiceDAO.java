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

public class ServiceDAO {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
            System.out.println("ServiceDAO: Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.out.println("ServiceDAO: Error loading driver: " + e.getMessage());
        }
        try {
            Connection con = DriverManager.getConnection(DBURL, USERDB, PASSDB);
            System.out.println("ServiceDAO: Database connection established");
            return con;
        } catch (SQLException e) {
            System.out.println("ServiceDAO: Error connecting to database: " + e.getMessage());
        }
        return null;
    }

    public Service getService(int id) {
        String sql = "SELECT id, name, price, duration, description, image, categoryID FROM Service WHERE id = ?";
        try (Connection con = getConnect()) {
            if (con == null) {
                System.out.println("ServiceDAO.getService: Connection is null");
                return null;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Service service = new Service();
                service.setId(rs.getInt("id"));
                service.setName(rs.getString("name"));
                service.setPrice(rs.getFloat("price"));
                service.setDuration(rs.getInt("duration"));
                service.setDescription(rs.getString("description"));
                service.setImage(rs.getString("image"));
                service.setCategoryID(rs.getInt("categoryID"));
                System.out.println("ServiceDAO.getService: Retrieved service id=" + id + ", image=" + service.getImage());
                return service;
            }
        } catch (Exception e) {
            System.out.println("ServiceDAO.getService: Error: " + e.getMessage());
        }
        return null;
    }

    public float getFeeService(String serviceName) {
        String sql = "SELECT price FROM Service WHERE name = ?";
        try (Connection con = getConnect()) {
            if (con == null) {
                System.out.println("ServiceDAO.getFeeService: Connection is null");
                return 0;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, serviceName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getFloat("price");
            }
        } catch (Exception e) {
            System.out.println("ServiceDAO.getFeeService: Error: " + e.getMessage());
        }
        return 0;
    }

    public int getServiceIdByName(String serviceName) {
        String sql = "SELECT id FROM Service WHERE name = ?";
        try (Connection con = getConnect()) {
            if (con == null) {
                System.out.println("ServiceDAO.getServiceIdByName: Connection is null");
                return 0;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, serviceName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (Exception e) {
            System.out.println("ServiceDAO.getServiceIdByName: Error: " + e.getMessage());
        }
        return 0;
    }

    public List<Service> getChoosedService(String[] serviceName) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT id, price FROM Service WHERE name = ?";
        try (Connection con = getConnect()) {
            if (con == null) {
                System.out.println("ServiceDAO.getChoosedService: Connection is null");
                return null;
            }
            for (String name : serviceName) {
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
            System.out.println("ServiceDAO.getChoosedService: Error: " + e.getMessage());
        }
        return null;
    }

    public void insertService(String name, double price, int duration, String description, String image, int categoryID) {
        String sql = "INSERT INTO Service (name, price, duration, description, image, categoryID) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnect()) {
            if (con == null) {
                System.out.println("ServiceDAO.insertService: Connection is null");
                return;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setInt(3, duration);
            ps.setString(4, description);
            ps.setString(5, image);
            ps.setInt(6, categoryID);
            int rowsAffected = ps.executeUpdate();
            System.out.println("ServiceDAO.insertService: Inserted " + rowsAffected + " rows for service: " + name);
        } catch (Exception e) {
            System.out.println("ServiceDAO.insertService: Error: " + e.getMessage());
        }
    }

    public List<Service> getAllService() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service";
        try (Connection con = getConnect()) {
            if (con == null) {
                System.out.println("ServiceDAO.getAllService: Connection is null");
                return null;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                float price = rs.getFloat("price");
                int duration = rs.getInt("duration");
                String description = rs.getString("description");
                String image = rs.getString("image");
                int categoryID = rs.getInt("categoryID");
                Service service = new Service(id, name, price, duration, description, image, categoryID);
                services.add(service);
                System.out.println("ServiceDAO.getAllService: Added service: " + name + ", CategoryID: " + categoryID);
            }
            return services;
        } catch (Exception e) {
            System.out.println("ServiceDAO.getAllService: Error: " + e.getMessage());
            return null;
        }
    }

    public void updateService(int id, String name, float price, int duration, String description, String imagePath, int categoryID) {
        String sql = "UPDATE Service SET name = ?, price = ?, duration = ?, description = ?, categoryID = ?" +
                     (imagePath != null ? ", image = ?" : "") + " WHERE id = ?";
        try (Connection con = getConnect()) {
            if (con == null) {
                System.out.println("ServiceDAO.updateService: Connection is null");
                return;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setFloat(2, price);
            ps.setInt(3, duration);
            ps.setString(4, description);
            ps.setInt(5, categoryID);
            if (imagePath != null) {
                ps.setString(6, imagePath);
                ps.setInt(7, id);
            } else {
                ps.setInt(6, id);
            }
            int rowsAffected = ps.executeUpdate();
            System.out.println("ServiceDAO.updateService: Updated " + rowsAffected + " rows for service id=" + id +
                    ", imagePath=" + imagePath);
        } catch (Exception e) {
            System.out.println("ServiceDAO.updateService: Error: " + e.getMessage());
        }
    }

    public void deleteService(int id) {
        String sql = "DELETE FROM Service WHERE id = ?";
        try (Connection con = getConnect()) {
            if (con == null) {
                System.out.println("ServiceDAO.deleteService: Connection is null");
                return;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            System.out.println("ServiceDAO.deleteService: Deleted " + rowsAffected + " rows for service id=" + id);
        } catch (Exception e) {
            System.out.println("ServiceDAO.deleteService: Error: " + e.getMessage());
        }
    }

    public String getServiceNameById(int serviceId) {
        String sql = "SELECT name FROM Service WHERE id = ?";
        try (Connection con = getConnect()) {
            if (con == null) {
                System.out.println("ServiceDAO.getServiceNameById: Connection is null");
                return null;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (Exception e) {
            System.out.println("ServiceDAO.getServiceNameById: Error: " + e.getMessage());
        }
        return null;
    }

    public double getServicePriceById(int serviceId) {
        String sql = "SELECT price FROM Service WHERE id = ?";
        try (Connection con = getConnect()) {
            if (con == null) {
                System.out.println("ServiceDAO.getServicePriceById: Connection is null");
                return 0;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("price");
            }
        } catch (Exception e) {
            System.out.println("ServiceDAO.getServicePriceById: Error: " + e.getMessage());
        }
        return 0;
    }

    public Service getServiceById(int id) {
        String sql = "SELECT id, name, price, duration, description, image, categoryID FROM Service WHERE id = ?";
        try (Connection con = getConnect()) {
            if (con == null) {
                System.out.println("ServiceDAO.getServiceById: Connection is null");
                return null;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Service service = new Service();
                service.setId(rs.getInt("id"));
                service.setName(rs.getString("name"));
                service.setPrice(rs.getFloat("price"));
                service.setDuration(rs.getInt("duration"));
                service.setDescription(rs.getString("description"));
                service.setImage(rs.getString("image"));
                service.setCategoryID(rs.getInt("categoryID"));
                System.out.println("ServiceDAO.getServiceById: Retrieved service id=" + id + ", image=" + service.getImage());
                return service;
            }
        } catch (Exception e) {
            System.out.println("ServiceDAO.getServiceById: Error: " + e.getMessage());
        }
        return null;
    }
}
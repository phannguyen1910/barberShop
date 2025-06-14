package babershopDAO;

import static babershopDatabase.databaseInfo.DBURL;
import static babershopDatabase.databaseInfo.DRIVERNAME;
import static babershopDatabase.databaseInfo.PASSDB;
import static babershopDatabase.databaseInfo.USERDB;

import model.Holiday;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HolidayDAO {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver: " + e);
        }
        try {
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public static List<Holiday> getAllHolidays() {
        List<Holiday> list = new ArrayList<>();
        String sql = "SELECT date, name, status FROM Holiday ORDER BY date ASC";
        try (Connection con = getConnect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String date = rs.getString("date");
                String name = rs.getString("name");
                String status = rs.getString("status");
                list.add(new Holiday(date, name, status));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public static void insertHoliday(String date, String name, String status) {
        String sql = "INSERT INTO Holiday (date, name, status) VALUES (?, ?, ?)";
        try (Connection con = getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, date);
            ps.setString(2, name);
            ps.setString(3, status);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void updateHoliday(String date, String name, String status) {
        String sql = "UPDATE Holiday SET name = ?, status = ? WHERE date = ?";
        try (Connection con = getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, status);
            ps.setString(3, date);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void deleteHolidayByDate(String date) {
        String sql = "DELETE FROM Holiday WHERE date = ?";
        try (Connection con = getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, date);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static boolean isExistingHoliday(String date) {
        String sql = "SELECT COUNT(*) FROM Holiday WHERE date = ?";
        try (Connection con = getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, date);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }

    public static void saveOrUpdate(Holiday h) {
        if (isExistingHoliday(h.getDate())) {
            updateHoliday(h.getDate(), h.getName(), h.getStatus());
        } else {
            insertHoliday(h.getDate(), h.getName(), h.getStatus());
        }
    }
}
    
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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import model.WorkSchedule;

public class WorkScheduleDAO {

    private static final Map<String, Integer> registrationCache = new ConcurrentHashMap<>();

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

    public boolean addWorkSchedule(WorkSchedule schedule) {
        Connection conn = getConnect();
        if (conn == null) {
            System.out.println("Failed to establish database connection");
            return false;
        }
        String sql = "INSERT INTO [WorkSchedule] (staffId, workDate, status) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, schedule.getStaffId());
            ps.setObject(2, schedule.getWorkDate());
            ps.setString(3, schedule.getStatus());
            boolean success = ps.executeUpdate() > 0;
            if (success) {
                String dateStr = schedule.getWorkDate().toString();
                registrationCache.compute(dateStr, (k, v) -> (v == null) ? 1 : v + 1);
            }
            return success;
        } catch (SQLException e) {
            System.out.println("Error adding work schedule: " + e.getMessage());
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                System.out.println("Error closing connection: " + e.getMessage());
            }
        }
    }

    public int countRegistrationsForDay(LocalDate date) {
        String dateStr = date.toString();
        if (registrationCache.containsKey(dateStr)) {
            return registrationCache.get(dateStr);
        }
        String sql = "SELECT COUNT(*) FROM [WorkSchedule] WHERE workDate = ? AND status = 'off'";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setObject(1, date);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                registrationCache.put(dateStr, count);
                return count;
            }
        } catch (SQLException e) {
            System.out.println("Error counting registrations for day: " + e.getMessage());
        }
        return 0;
    }

    public int countStaffRegistrationsForMonth(int staffId, int year, int month) {
        String sql = "SELECT COUNT(*) FROM [WorkSchedule] WHERE staffId = ? AND YEAR(workDate) = ? AND MONTH(workDate) = ? AND status = 'off'";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ps.setInt(2, year);
            ps.setInt(3, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting staff registrations for month: " + e.getMessage());
        }
        return 0;
    }

    public Map<String, Integer> getRegistrations() {
        if (!registrationCache.isEmpty()) {
            System.out.println("Using cached registrations: " + registrationCache);
            return new HashMap<>(registrationCache);
        }
        Map<String, Integer> registrations = new HashMap<>();
        String sql = "SELECT workDate, COUNT(*) as count FROM [WorkSchedule] WHERE status = 'off' GROUP BY workDate";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LocalDate date = rs.getObject("workDate", LocalDate.class);
                if (date != null) {
                    String dateStr = date.toString();
                    int count = rs.getInt("count");
                    registrations.put(dateStr, count);
                    registrationCache.put(dateStr, count);
                    System.out.println("Fetched registration: " + dateStr + " -> " + count);
                }
            }
            if (registrations.isEmpty()) {
                System.out.println("No registrations found, cache will remain empty");
            }
        } catch (SQLException e) {
            System.out.println("Error fetching registrations: " + e.getMessage());
        }
        return registrations;
    }

    public List<WorkSchedule> getAllOffSchedules() {
        List<WorkSchedule> schedules = new ArrayList<>();
        String sql = "SELECT ws.id, ws.staffId, ws.workDate, ws.status, s.firstName, s.lastName " +
                     "FROM [WorkSchedule] ws JOIN [Staff] s ON ws.staffId = s.id WHERE ws.status = 'off'";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                WorkSchedule ws = new WorkSchedule();
                ws.setId(rs.getInt("id"));
                ws.setStaffId(rs.getInt("staffId"));
                ws.setWorkDate(rs.getObject("workDate", LocalDate.class));
                ws.setStatus(rs.getString("status"));
                ws.setFirstName(rs.getString("firstName"));
                ws.setLastName(rs.getString("lastName"));
                schedules.add(ws);
                System.out.println("Fetched schedule: " + ws.getId() + ", " + ws.getStaffId() + ", " + ws.getWorkDate());
            }
        } catch (SQLException e) {
            System.out.println("Error fetching all off schedules: " + e.getMessage());
        }
        return schedules;
    }

    public List<LocalDate> getDisallowedDays() {
        List<LocalDate> disallowedDays = new ArrayList<>();
        String sql = "SELECT date FROM [Holiday] WHERE status = 'locked'";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                disallowedDays.add(rs.getObject("date", LocalDate.class));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching disallowed days: " + e.getMessage());
        }
        return disallowedDays;
    }

    public Map<String, Integer> getRegisteredDaysForStaff(int staffId, int year, int month) {
        Map<String, Integer> registeredDays = new HashMap<>();
        String sql = "SELECT workDate FROM [WorkSchedule] WHERE staffId = ? AND YEAR(workDate) = ? AND MONTH(workDate) = ? AND status = 'off'";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ps.setInt(2, year);
            ps.setInt(3, month);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LocalDate date = rs.getObject("workDate", LocalDate.class);
                registeredDays.put(date.toString(), 1);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching registered days for staff: " + e.getMessage());
        }
        return registeredDays;
    }

    public String getStaffName(int staffId) {
        String sql = "SELECT firstName, lastName FROM [Staff] WHERE id = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("firstName") + " " + rs.getString("lastName");
            }
        } catch (SQLException e) {
            System.out.println("Error fetching staff name: " + e.getMessage());
        }
        return "Unknown Staff";
    }
}
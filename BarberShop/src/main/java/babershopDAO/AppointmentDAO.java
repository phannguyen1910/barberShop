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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Appointment;
import model.AppointmentService;
import model.Customer;
import model.Service;
import model.Voucher;

public class AppointmentDAO {

    private ServiceDAO serviceDAO = new ServiceDAO();
    private CustomerDAO customerDAO = new CustomerDAO();

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

    public List<Appointment> getAllAppointmentsWithDetails() {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT id, customerId, staffId, appointmentTime, status, numberOfPeople FROM Appointment";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setId(rs.getInt("id"));
                appointment.setCustomerId(rs.getInt("customerId"));
                appointment.setStaffId(rs.getInt("staffId"));
                appointment.setAppointmentTime(rs.getObject("appointmentTime", LocalDateTime.class));
                appointment.setStatus(rs.getString("status"));
                appointment.setNumberOfPeople(rs.getInt("numberOfPeople"));

                // Lấy tên khách hàng
                Customer customer = customerDAO.getCustomerById(appointment.getCustomerId());
                if (customer != null) {
                    appointment.setCustomerName(customer.getFirstName() + " " + customer.getLastName());
                }
                
                float totalAmount = getFeeOfAppointment(appointment.getId());
                appointment.setTotalAmount(totalAmount);

                // Lấy danh sách dịch vụ
                List<AppointmentService> appointmentServices = getAppointmentServicesByAppointmentId(appointment.getId());
                StringBuilder servicesString = new StringBuilder();
                for (AppointmentService as : appointmentServices) {
                    String serviceName = serviceDAO.getServiceNameById(as.getServiceId());
                    if (serviceName != null) {
                        servicesString.append(serviceName);
                        servicesString.append(", ");
                    }
                }
                if (servicesString.length() > 2) {
                    appointment.setServices(servicesString.substring(0, servicesString.length() - 2));
                }

                appointments.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    private List<AppointmentService> getAppointmentServicesByAppointmentId(int appointmentId) {
        List<AppointmentService> appointmentServices = new ArrayList<>();
        String sql = "SELECT appointmentId, serviceId FROM Appointment_Service WHERE appointmentId = ?";
        try (Connection con = getConnect(); PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, appointmentId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                AppointmentService as = new AppointmentService();
                as.setAppointmentId(rs.getInt("appointmentId"));
                as.setServiceId(rs.getInt("serviceId"));
                appointmentServices.add(as);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointmentServices;
    }

    private float getFeeOfAppointment(int appointmentId) {
        String sql = "SELECT totalAmount FROM Invoice WHERE appointmentId = ?";
        try (Connection con = getConnect()) {
            PreparedStatement pstmt = con.prepareStatement(sql);

            pstmt.setInt(1, appointmentId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                float totalAmount = rs.getFloat(1);
                return totalAmount;
            }

        } catch (Exception e) {
        }
        return 0;
    }

    public Appointment getAppointment(int id) {
        String sql = "Select appointment_time,  customer_id, staff_id from Appointment where id= ?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String date = rs.getString(1);
                LocalDateTime appointment_time = LocalDateTime.parse(date, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                int customerId = rs.getInt(2);
                int staff = rs.getInt(3);
                Appointment appointment = new Appointment(appointment_time, customerId, staff);
                return appointment;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Appointment> getAllAppointments() {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "Select * from Appointment";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String date = rs.getString("appointmentTime");
                LocalDateTime appointment_time = LocalDateTime.parse(date, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                int customerId = rs.getInt("customerId");
                int staff = rs.getInt("staffId");
                String status = rs.getString("status");
                int numberOfPeople = rs.getInt("numberOfpeople");
                Appointment appointment = new Appointment(id, customerId, staff, appointment_time, status, numberOfPeople);
                appointments.add(appointment);
                return appointments;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public void insertAppointment(String appointmentTime, int customerId, int staffId) {
        String sql = "INSERT INTO Appointment (appointment_time, customer_id, staff_id, ) VALUES (?,?,?)";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, appointmentTime);
            ps.setInt(2, customerId);
            ps.setInt(3, staffId);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    
    public boolean updateAppointmentStatus(int id, String status) {
    String sql = "UPDATE appointments SET status = ? WHERE id = ?";
    try (Connection con = getConnect();
         PreparedStatement stmt = con.prepareStatement(sql)) {
        stmt.setString(1, status);
        stmt.setInt(2, id);
        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
    

    public void updateAppointment(int id, int staffId) {

        String sql = "UPDATE Appointment SET staff_id = ? WHERE id = ?";

        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, staffId);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void deleteAppointment(int id) {
        String sql = "delete from Appointment where id=?";
        try (Connection con = getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public String Booking(int customerId, int staffId, String appointmentTime, int numberOfPeople, List<Integer> serviceIds) {
        String insertAppointment = "INSERT INTO Appointment (customerId, staffId, appointmentTime, numberOfPeople, status) VALUES (?, ?, ?, ?, 'pending')";
        String insertAppointmentService = "INSERT INTO Appointment_Service (appointmentId, serviceId, quantity) VALUES (?, ?, 1)";
        String checkDuplicate = "SELECT COUNT(*) FROM Appointment WHERE staffId = ? AND appointmentTime = ?";

        Connection con = null;
        PreparedStatement checkStmt = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        ResultSet rsCheck = null;
        ResultSet rsKeys = null;

        try {
            con = getConnect();
            con.setAutoCommit(false); // Bắt đầu giao dịch

            // --- Bước 1: Kiểm tra trùng lịch ---
            checkStmt = con.prepareStatement(checkDuplicate);
            checkStmt.setInt(1, staffId);
            checkStmt.setString(2, appointmentTime);
            rsCheck = checkStmt.executeQuery();
            if (rsCheck.next() && rsCheck.getInt(1) > 0) {
                return "Staff is not available at this time.";
            }

            // --- Bước 2: Insert vào bảng Appointment ---
            ps1 = con.prepareStatement(insertAppointment, PreparedStatement.RETURN_GENERATED_KEYS);
            ps1.setInt(1, customerId);
            ps1.setInt(2, staffId);
            ps1.setString(3, appointmentTime);
            ps1.setInt(4, numberOfPeople);

            int check = ps1.executeUpdate();
            if (check > 0) {
                rsKeys = ps1.getGeneratedKeys();
                if (rsKeys.next()) {
                    int appointmentId = rsKeys.getInt(1);

                    // --- Bước 3: Insert vào bảng AppointmentService ---
                    for (Integer serviceId : serviceIds) {
                        ps2 = con.prepareStatement(insertAppointmentService);
                        ps2.setInt(1, appointmentId);
                        ps2.setInt(2, serviceId);
                        int check2 = ps2.executeUpdate();
                        if (check2 == 0) {
                            throw new SQLException("Failed to add service to appointment.");
                        }
                    }
                    con.commit(); // Commit giao dịch nếu thành công
                    return "Booking successful";
                }
            }
            con.rollback(); // Rollback nếu không thành công
            return "Booking failed when creating appointment.";

        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback(); // Rollback khi có lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return "Không thể kết nối server: " + e.getMessage();
        } finally {
            // Đóng tất cả tài nguyên
            try {
                if (rsCheck != null) {
                    rsCheck.close();
                }
                if (rsKeys != null) {
                    rsKeys.close();
                }
                if (checkStmt != null) {
                    checkStmt.close();
                }
                if (ps1 != null) {
                    ps1.close();
                }
                if (ps2 != null) {
                    ps2.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public double caculateMoney(List<Service> services, int numberOfPeople) {
        double amount = 0;
        for (Service s : services) {
            amount += s.getPrice();
        }
        amount = amount * numberOfPeople;
        System.out.println(numberOfPeople);
        return amount;
    }
}

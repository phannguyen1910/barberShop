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
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
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
    private InvoiceDAO invoiceDAO = new InvoiceDAO();

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
    
    
    
     public boolean isStaffAvailable(int staffId, LocalDateTime proposedStartTime, int serviceDurationMinutes) throws SQLException {
        LocalDateTime proposedEndTime = proposedStartTime.plusMinutes(serviceDurationMinutes);

        String sql = "SELECT COUNT(*) FROM Appointment " +
                     "WHERE staffId = ? " +
                     "AND status IN ('Pending', 'Confirmed') " +
                     "AND (? < DATEADD(minute, totalServiceDurationMinutes, appointmentTime)) " +
                     "AND (appointmentTime < ?)";

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ps.setTimestamp(2, Timestamp.valueOf(proposedStartTime));
            ps.setTimestamp(3, Timestamp.valueOf(proposedEndTime));

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL khi kiểm tra lịch trống của nhân viên: " + e.getMessage());
            throw e;
        }
        return false;
    }

    

  
    public List<Appointment> getAppointmentsByStaffAndDate(int staffId, LocalDate date) {
        List<Appointment> appointments = new ArrayList<>();
        // Sử dụng CONVERT(DATE, ...) cho SQL Server để so sánh chỉ phần ngày
        String sql = "SELECT id, customerId, staffId, appointmentTime, status, branchId, totalServiceDurationMinutes FROM Appointment " +
                     "WHERE staffId = ? AND CONVERT(DATE, appointmentTime) = ? AND status IN ('Pending', 'Confirmed', 'Completed')"; // Thêm 'Completed' nếu bạn muốn các lịch hẹn đã hoàn thành cũng chiếm khung giờ

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ps.setDate(2, java.sql.Date.valueOf(date)); // Chuyển đổi LocalDate sang java.sql.Date

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment appt = new Appointment();
                appt.setId(rs.getInt("id"));
                appt.setCustomerId(rs.getInt("customerId"));
                appt.setStaffId(rs.getInt("staffId"));
                appt.setAppointmentTime(rs.getTimestamp("appointmentTime").toLocalDateTime());
                appt.setStatus(rs.getString("status"));
                appt.setBranchId(rs.getInt("branchId"));
                // Lấy totalServiceDurationMinutes từ cột mới trong DB
                appt.setTotalServiceDurationMinutes(rs.getInt("totalServiceDurationMinutes"));
                appointments.add(appt);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL khi lấy lịch hẹn của nhân viên theo ngày: " + e.getMessage());
            e.printStackTrace();
        }
        return appointments;
    }

    public boolean addAppointment(int customerId, int staffId, LocalDateTime appointmentTime, List<Integer> serviceIds, float totalAmount, int branchId, int serviceDurationMinutes) {
        String sql1 = "INSERT INTO Appointment (customerId, staffId, appointmentTime, status, branchId, [TotalDurationMinutes]) VALUES (?, ?, ?, 'Pending', ?, ?)";
        String sql2 = "INSERT INTO Appointment_Service ([appointmentId], [serviceId]) VALUES (?, ?)";

        

        Connection con = null;
        try {
            con = getConnect();
            con.setAutoCommit(false);

            try (PreparedStatement ps = con.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, customerId);
                ps.setInt(2, staffId);
                ps.setTimestamp(3, Timestamp.valueOf(appointmentTime));
                ps.setInt(4, branchId);
                ps.setInt(5, serviceDurationMinutes);
                ps.executeUpdate(); // ✅ Sửa lỗi ở đây

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int appointmentId = rs.getInt(1);
                        System.out.println("✅ Appointment ID created: " + appointmentId);

                        if (!serviceIds.isEmpty()) {
                            try (PreparedStatement ps2 = con.prepareStatement(sql2)) {
                                for (Integer serviceId : serviceIds) {
                                    ps2.setInt(1, appointmentId);
                                    ps2.setInt(2, serviceId);
                                    ps2.addBatch();
                                }
                                int[] affectedRows = ps2.executeBatch();
                                for (int affected : affectedRows) {
                                    if (affected == 0) {
                                        con.rollback();
                                        return false;
                                    }
                                }
                            }
                        }

                        InvoiceDAO invoiceDAO = new InvoiceDAO();
                        boolean invoiceInserted = invoiceDAO.insertInvoice(con, totalAmount, appointmentTime, appointmentId);
                        if (!invoiceInserted) {
                            con.rollback();
                            return false;
                        }

                        con.commit();
                        return true;
                    } else {
                        con.rollback();
                        return false;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ SQLException: " + e.getMessage());
            e.printStackTrace();
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    System.err.println("❌ Rollback failed: " + ex.getMessage());
                }
            }
            return false;
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // Inside your AppointmentDAO class
    public boolean addAppointmentByAdmin(int customerId, int staffId, LocalDateTime appointmentTime, int branchId, List<Integer> serviceIds) {
        String sql1 = "INSERT INTO Appointment (customerId, staffId, appointmentTime, status, branchId) OUTPUT INSERTED.ID VALUES (?, ?, ?, 'Confirmed', ?)";
        String sql2 = "INSERT INTO Appointment_Service ([appointmentId], [serviceId]) VALUES (?, ?)";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        PreparedStatement ps2 = null;

        try {
            con = getConnect();
            con.setAutoCommit(false);

            ps = con.prepareStatement(sql1);
            ps.setInt(1, customerId);
            ps.setInt(2, staffId);
            ps.setTimestamp(3, java.sql.Timestamp.valueOf(appointmentTime));
            ps.setInt(4, branchId);

            boolean hasResultSet = ps.execute();

            int appointmentId = -1;

            if (hasResultSet) {
                rs = ps.getResultSet();
                if (rs.next()) {
                    appointmentId = rs.getInt(1);
                    System.out.println("✅ Appointment ID created: " + appointmentId);
                } else {
                    System.err.println("❌ Không thể lấy ID của Appointment vừa chèn. ResultSet từ OUTPUT trống.");
                    con.rollback();
                    return false;
                }
            } else {
                System.err.println("❌ INSERT không tạo ra ResultSet từ OUTPUT mệnh đề.");
                con.rollback();
                return false;
            }

            if (appointmentId == -1) {
                System.err.println("❌ Appointment ID vẫn là -1 sau khi cố gắng lấy. Có lỗi trong quá trình lấy ID.");
                con.rollback();
                return false;
            }

            if (!serviceIds.isEmpty()) {
                ps2 = con.prepareStatement(sql2);
                for (Integer serviceId : serviceIds) {
                    ps2.setInt(1, appointmentId);
                    ps2.setInt(2, serviceId);
                    ps2.addBatch();
                }
                int[] affectedRowsService = ps2.executeBatch();

                for (int affected : affectedRowsService) {
                    if (affected == 0) {
                        System.err.println("❌ Một dịch vụ không thể thêm (serviceId có thể không tồn tại hoặc lỗi khác trong batch).");
                        con.rollback();
                        return false;
                    }
                }
                System.out.println("✅ Thêm " + serviceIds.size() + " dịch vụ thành công cho Appointment ID: " + appointmentId);
            }

            InvoiceDAO invoiceDAO = new InvoiceDAO();
            float totalAmount = calculateAmount(serviceIds);
            System.out.println(totalAmount);
            boolean invoiceInserted = invoiceDAO.insertInvoice(con, totalAmount, appointmentTime, appointmentId);
            if (!invoiceInserted) {
                con.rollback();
                return false;
            }

            con.commit();
            return true;

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi chèn dữ liệu vào CSDL: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();

            if (con != null) {
                try {
                    System.err.println("Attempting to rollback transaction due to SQLException.");
                    con.rollback();
                } catch (SQLException ex) {
                    System.err.println("Lỗi khi rollback: " + ex.getMessage());
                    ex.printStackTrace();
                }
            }
            return false;
        } catch (Exception e) {
            System.err.println("❌ Lỗi không xác định trong addAppointment: " + e.getMessage());
            e.printStackTrace();
            if (con != null) {
                try {
                    System.err.println("Attempting to rollback transaction due to generic Exception.");
                    con.rollback();
                } catch (SQLException ex) {
                    System.err.println("Lỗi khi rollback: " + ex.getMessage());
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (ps2 != null) {
                    ps2.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean editAppointmentService(int appointmentId, int[] serviceIds, String status) throws SQLException {
        String sqlUpdateAppointment = "UPDATE Appointment SET status = ? WHERE id = ?";
        String sqlDeleteServices = "DELETE FROM Appointment_Service WHERE AppointmentId = ?";
        String sqlInsertService = "INSERT INTO Appointment_Service (ServiceId, AppointmentId) VALUES (?, ?)";
        String sqlEditInvoice = "UPDATE Invoice SET totalAmount = ?, status = ? WHERE AppointmentId = ?";

        try (Connection con = getConnect()) {
            con.setAutoCommit(false);

            try (
                    PreparedStatement psUpdate = con.prepareStatement(sqlUpdateAppointment); PreparedStatement psDelete = con.prepareStatement(sqlDeleteServices); PreparedStatement psInsert = con.prepareStatement(sqlInsertService); PreparedStatement psEditInvoice = con.prepareStatement(sqlEditInvoice)) {
                // 1. Cập nhật trạng thái cuộc hẹn
                psUpdate.setString(1, status);
                psUpdate.setInt(2, appointmentId);
                psUpdate.executeUpdate();

                // 2. Xoá các dịch vụ cũ
                psDelete.setInt(1, appointmentId);
                psDelete.executeUpdate();

                // 3. Thêm lại dịch vụ mới
                for (int serviceId : serviceIds) {
                    psInsert.setInt(1, serviceId);
                    psInsert.setInt(2, appointmentId);
                    psInsert.addBatch();
                }
                psInsert.executeBatch();

                // 4. Cập nhật hóa đơn
                float totalAmount = calculateAmount2(serviceIds);
                psEditInvoice.setFloat(1, totalAmount);

                String invoiceStatus;
                switch (status) {
                    case "Completed":
                        invoiceStatus = "Paid";
                        break;
                    case "Confirmed":
                        invoiceStatus = "Paid Deposit";
                        break;
                    case "Cancelled":
                        invoiceStatus = "Cancelled";
                        break;
                    default:
                        throw new IllegalArgumentException("Invalid appointment status: " + status);
                }
                psEditInvoice.setString(2, invoiceStatus);
                psEditInvoice.setInt(3, appointmentId);
                psEditInvoice.executeUpdate();

                con.commit();
                return true;

            } catch (SQLException e) {
                con.rollback();
                System.err.println("Transaction rollback. Error: " + e.getMessage());
                throw e;
            }
        }
    }

    public float calculateAmount2(int[] serviceIds) {
        if (serviceIds == null || serviceIds.length == 0) {
            return 0;
        }

        float totalAmount = 0;
        StringBuilder sqlBuilder = new StringBuilder("SELECT price FROM Service WHERE id IN (");

        for (int i = 0; i < serviceIds.length; i++) {
            sqlBuilder.append("?");
            if (i < serviceIds.length - 1) {
                sqlBuilder.append(",");
            }
        }
        sqlBuilder.append(")");

        String sql = sqlBuilder.toString();

        try (Connection con = getConnect(); PreparedStatement pstmt = con.prepareStatement(sql)) {
            for (int i = 0; i < serviceIds.length; i++) {
                pstmt.setInt(i + 1, serviceIds[i]);
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                totalAmount += rs.getFloat("price");
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi truy vấn giá dịch vụ: " + e.getMessage());
        }

        return totalAmount;
    }

    public List<Appointment> getAllAppointmentsWithDetails() {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT id, customerId, staffId, appointmentTime, status, branchId FROM Appointment";
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
                appointment.setBranchId(rs.getInt("branchId"));

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

    public List<AppointmentService> getAppointmentServicesByAppointmentId(int appointmentId) {
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

    public float calculateAmount(List<Integer> serviceIds) {
        if (serviceIds == null || serviceIds.isEmpty()) {
            return 0;
        }

        float totalAmount = 0;
        StringBuilder sqlBuilder = new StringBuilder("SELECT price FROM Service WHERE id IN (");

        for (int i = 0; i < serviceIds.size(); i++) {
            sqlBuilder.append("?");
            if (i < serviceIds.size() - 1) {
                sqlBuilder.append(",");
            }
        }
        sqlBuilder.append(")");

        String sql = sqlBuilder.toString();

        try (Connection con = getConnect(); PreparedStatement pstmt = con.prepareStatement(sql)) {
            for (int i = 0; i < serviceIds.size(); i++) {
                pstmt.setInt(i + 1, serviceIds.get(i));
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                totalAmount += rs.getFloat("price");
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi truy vấn giá dịch vụ: " + e.getMessage());
        }

        return totalAmount;
    }

    public float getFeeOfAppointment(int appointmentId) {
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
                int branchId = rs.getInt("branchId");
                Appointment appointment = new Appointment(id, customerId, staff, appointment_time, status);
                appointments.add(appointment);
                return appointments;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean updateAppointmentStatus(int id, String status) {
        String sqlUpdateAppointmentStatus = "UPDATE Appointment SET status = ? WHERE id = ? ";
        String sqlEditInvoiceStatus = "UPDATE Invoice SET status = ? WHERE AppointmentId = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sqlUpdateAppointmentStatus)) {

            stmt.setString(1, status);
            stmt.setInt(2, id);
            int rowsAffected = stmt.executeUpdate();

            // Chỉ cập nhật Invoice nếu Appointment đã được cập nhật thành công
            if (rowsAffected > 0) {
                try (PreparedStatement ps2 = con.prepareStatement(sqlEditInvoiceStatus)) {
                    String invoiceStatus = status.equals("Completed") ? "Paid" : "Canceled";
                    ps2.setString(1, invoiceStatus);
                    ps2.setInt(2, id);
                    ps2.executeUpdate();
                }
            }

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

    public boolean cancelAppointment(int appointmentId) {
        String sql = "UPDATE Appointment SET status = 'Cancelled' WHERE id = ?";
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, appointmentId);
            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0; // true nếu có ít nhất 1 dòng được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Appointment> historyBooking(int customerId) {
        List<Appointment> appointments = new ArrayList<>();
        String sql1 = "SELECT a.id, CONCAT(s.lastName, ' ', s.firstName) AS staffName, "
                + "a.appointmentTime, a.status, b.name AS branchName "
                + "FROM Appointment a "
                + "INNER JOIN Staff s ON a.staffId = s.id "
                + "INNER JOIN Branch b ON a.branchId = b.id "
                + "WHERE a.customerId = ? "
                + "ORDER BY a.appointmentTime DESC";
        String sql2 = "SELECT s.name, s.price FROM Appointment_Service aps JOIN Service s ON aps.serviceId = s.id WHERE aps.appointmentId = ?";

        try (Connection con = getConnect()) {
            if (con == null) {
                System.err.println("Không thể kết nối đến cơ sở dữ liệu.");
                return appointments;
            }

            try (PreparedStatement ps1 = con.prepareStatement(sql1)) {
                ps1.setInt(1, customerId);
                ResultSet rs1 = ps1.executeQuery();
                LocalDateTime appointmentTime = null;
                while (rs1.next()) {
                    int id = rs1.getInt("id");

                    try {
                        appointmentTime = rs1.getObject("appointmentTime", LocalDateTime.class);
                    } catch (DateTimeParseException dtpe) {
                        System.err.println("Lỗi định dạng ngày giờ cho appointment ID " + id);
                        continue; // bỏ qua lần booking này
                    }

                    String staffName = rs1.getString("staffName");
                    String status = rs1.getString("status");
                    String branchName = rs1.getString("branchName");

                    float totalAmount = 0;
                    StringBuilder services = new StringBuilder();

                    try (PreparedStatement ps2 = con.prepareStatement(sql2)) {
                        ps2.setInt(1, id);
                        ResultSet rs2 = ps2.executeQuery();

                        while (rs2.next()) {
                            String name = rs2.getString("name");
                            if (services.length() > 0) {
                                services.append(", ");
                            }
                            services.append(name);
                            totalAmount += rs2.getFloat("price");
                        }

                    } catch (SQLException e2) {
                        System.err.println("Lỗi khi truy vấn danh sách dịch vụ cho appointment ID " + id + ": " + e2.getMessage());
                        continue; // bỏ qua nếu không lấy được dịch vụ
                    }

                    Appointment appointment = new Appointment(id, appointmentTime, status, services.toString(), totalAmount, staffName, branchName);
                    appointments.add(appointment);
                }

            } catch (SQLException e1) {
                System.err.println("Lỗi khi truy vấn lịch sử booking cho customerId " + customerId + ": " + e1.getMessage());
            }

        } catch (SQLException e) {
            System.err.println("Lỗi kết nối đến cơ sở dữ liệu: " + e.getMessage());
        }

        return appointments;
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

    public double caculateMoney(List<Service> services) {
        double amount = 0;
        for (Service s : services) {
            amount += s.getPrice();
        }
        return amount;
    }

    public List<Voucher> showVoucher() {
        String sql = "SELECT code, value, expiryDate, status FROM Voucher";
        List<Voucher> vouchers = new ArrayList<>();
        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String code = rs.getString("code");
                float value = rs.getFloat("value");

                LocalDate expiryDate = rs.getDate("expiryDate").toLocalDate(); // Dùng kiểu Date an toàn hơn

                String status = rs.getString("status");
                Voucher voucher = new Voucher(code, value, expiryDate, status);
                vouchers.add(voucher);
            }

        } catch (Exception e) {
            e.printStackTrace(); // hoặc log
        }
        return vouchers; // Luôn trả về danh sách, có thể rỗng nếu lỗi
    }
    // Trong AppointmentDAO.java

    public int getLastInsertedAppointmentId() {
        String sql = "SELECT TOP 1 id FROM Appointment ORDER BY id DESC";

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1; // Trả -1 nếu có lỗi hoặc không tìm thấy
    }
    public void updateAppointmentStatusAfterPayment(int appointmentId, String status) throws SQLException {
    String sql = "UPDATE Appointment SET status = ? WHERE id = ?";
    try (Connection conn = getConnect();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, status);
        ps.setInt(2, appointmentId);
        ps.executeUpdate();
    }
}
    public float getTotalAmount(int appointmentId) throws SQLException {
    String sql = "SELECT totalAmount FROM Appointment WHERE id = ?";
    try (Connection conn = getConnect();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, appointmentId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getFloat("totalAmount");
        }
    }
    return 0f;
}



}

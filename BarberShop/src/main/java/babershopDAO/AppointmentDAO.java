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

    public boolean addAppointment(int customerId, int staffId, LocalDateTime appointmentTime, int numberOfPeople, List<Integer> serviceIds) {
        String sql1 = "INSERT INTO Appointment (customerId, staffId, appointmentTime, numberOfPeople, status) VALUES (?, ?, ?, ?, 'pending')";
        String sql2 = "INSERT INTO Appointment_Service ([appointmentId] ,[serviceId]) VALUES (?, ?)";
        boolean check = false;

        // Cú pháp dấu ngoặc vuông [] là đúng cho SQL Server
        try (Connection con = getConnect()) {
            con.setAutoCommit(false); // Bắt đầu transaction

            try (PreparedStatement ps = con.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, customerId);
                ps.setInt(2, staffId);
                ps.setTimestamp(3, Timestamp.valueOf(appointmentTime));
                ps.setInt(4, numberOfPeople);
                //ps.setString(5, "Pending"); // 'Pending' đã được hardcode trong SQL, không cần set tham số này

                int rows = ps.executeUpdate(); // Thực thi INSERT

                // === Lấy ID được sinh ra tự động ===
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int appointmentId = rs.getInt(1); // Lấy ID đầu tiên từ ResultSet
                        System.out.println("✅ Appointment ID created: " + appointmentId);

                        // === Thêm các dịch vụ vào Appointment_Service (sử dụng Batch Update) ===
                        if (!serviceIds.isEmpty()) {
                            try (PreparedStatement ps2 = con.prepareStatement(sql2)) {
                                for (Integer serviceId : serviceIds) {
                                    ps2.setInt(1, appointmentId);
                                    ps2.setInt(2, serviceId);
                                    ps2.addBatch(); // Thêm vào batch
                                }
                                int[] affectedRows = ps2.executeBatch(); // Thực thi tất cả các lệnh trong batch

                                // Kiểm tra kết quả của batch update nếu cần
                                for (int affected : affectedRows) {
                                    if (affected == 0) {
                                        System.err.println("❌ Một dịch vụ không thể thêm (serviceId có thể không tồn tại hoặc lỗi khác).");
                                        con.rollback(); // Rollback toàn bộ nếu có lỗi trong batch
                                        return false;
                                    }
                                }
                                System.out.println("✅ Thêm " + serviceIds.size() + " dịch vụ thành công cho Appointment ID: " + appointmentId);
                            }
                        }

                        con.commit(); // Commit transaction nếu mọi thứ thành công
                        return true;
                    } else {
                        // Trường hợp không lấy được ID, có thể do cột ID không phải IDENTITY hoặc lỗi khác
                        System.err.println("❌ Không thể lấy ID của Appointment vừa chèn. Đảm bảo cột ID là IDENTITY.");
                        con.rollback(); // Rollback nếu không lấy được ID
                        return false;
                    }
                }
            }
        } catch (SQLException e) {
            // Log lỗi chi tiết từ database
            System.err.println("❌ Lỗi khi chèn dữ liệu vào CSDL: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace(); // In ra full stack trace để debug

            // Rollback nếu có lỗi xảy ra ở bất kỳ đâu trong try block
            try (Connection con = getConnect()) { // Cần lấy lại kết nối để rollback nếu con đã đóng
                if (con != null && !con.getAutoCommit()) {
                    con.rollback();
                }
            } catch (SQLException ex) {
                System.err.println("Lỗi khi rollback: " + ex.getMessage());
            }
            return false;
        } catch (Exception e) {
            // Bắt các ngoại lệ khác không phải SQLException
            System.err.println("❌ Lỗi không xác định trong addAppointment: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean addAppointmentByAdmin(int customerId, int staffId, LocalDateTime appointmentTime, int numberOfPeople, List<Integer> serviceIds) {
        // SQL Server: Sử dụng OUTPUT INSERTED.ID để trả về ID được tạo tự động
        // Không cần Statement.RETURN_GENERATED_KEYS trong prepareStatement khi dùng OUTPUT
        String sql1 = "INSERT INTO Appointment (customerId, staffId, appointmentTime, numberOfPeople, status) OUTPUT INSERTED.ID VALUES (?, ?, ?, ?, 'Pending')";

        // SQL Server: cú pháp dấu ngoặc vuông [] là đúng
        String sql2 = "INSERT INTO Appointment_Service ([appointmentId], [serviceId]) VALUES (?, ?)";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null; // ResultSet cho ID được sinh ra
        PreparedStatement ps2 = null; // PreparedStatement cho Appointment_Service

        try {
            con = getConnect(); // Lấy kết nối
            con.setAutoCommit(false); // Bắt đầu transaction

            // === THAY ĐỔI QUAN TRỌNG TẠI ĐÂY ===
            // Thay vì executeUpdate(), sử dụng execute() và sau đó lấy ResultSet
            ps = con.prepareStatement(sql1); // KHÔNG cần Statement.RETURN_GENERATED_KEYS khi dùng OUTPUT clause

            ps.setInt(1, customerId);
            ps.setInt(2, staffId);
            ps.setTimestamp(3, Timestamp.valueOf(appointmentTime));
            ps.setInt(4, numberOfPeople);

            // Thực thi câu lệnh. execute() trả về true nếu có ResultSet, false nếu không
            boolean hasResultSet = ps.execute();

            int appointmentId = -1; // Khởi tạo ID

            // === Lấy ID được sinh ra tự động ===
            if (hasResultSet) { // Kiểm tra xem có ResultSet được tạo ra không
                rs = ps.getResultSet(); // Lấy ResultSet từ mệnh đề OUTPUT
                if (rs.next()) {
                    appointmentId = rs.getInt(1); // Lấy ID đầu tiên từ ResultSet
                    System.out.println("✅ Appointment ID created: " + appointmentId);
                } else {
                    System.err.println("❌ Không thể lấy ID của Appointment vừa chèn. ResultSet từ OUTPUT trống.");
                    con.rollback();
                    return false;
                }
            } else { // Nếu execute() trả về false (không có ResultSet)
                System.err.println("❌ INSERT không tạo ra ResultSet từ OUTPUT mệnh đề.");
                con.rollback();
                return false;
            }

            // Kiểm tra nếu ID hợp lệ
            if (appointmentId == -1) {
                System.err.println("❌ Appointment ID vẫn là -1 sau khi cố gắng lấy. Có lỗi trong quá trình lấy ID.");
                con.rollback();
                return false;
            }

            // === Thêm các dịch vụ vào Appointment_Service (sử dụng Batch Update) ===
            if (!serviceIds.isEmpty()) {
                ps2 = con.prepareStatement(sql2); // Chuẩn bị statement cho dịch vụ
                for (Integer serviceId : serviceIds) {
                    ps2.setInt(1, appointmentId);
                    ps2.setInt(2, serviceId);
                    ps2.addBatch(); // Thêm vào batch
                }
                int[] affectedRowsService = ps2.executeBatch(); // Thực thi tất cả các lệnh trong batch

                // Kiểm tra kết quả của batch update
                for (int affected : affectedRowsService) {
                    if (affected == 0) { // Nếu có bất kỳ insert nào trong batch thất bại
                        System.err.println("❌ Một dịch vụ không thể thêm (serviceId có thể không tồn tại hoặc lỗi khác trong batch).");
                        con.rollback(); // Rollback toàn bộ transaction
                        return false;
                    }
                }
                System.out.println("✅ Thêm " + serviceIds.size() + " dịch vụ thành công cho Appointment ID: " + appointmentId);
            }

            con.commit(); // Commit transaction nếu mọi thứ thành công
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
            // Nếu có lỗi không phải SQLException, cũng nên cố gắng rollback transaction
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
            // Đóng tất cả tài nguyên trong finally block
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

        try (Connection con = getConnect()) {
            // Bắt đầu transaction
            con.setAutoCommit(false);

            try (PreparedStatement psUpdate = con.prepareStatement(sqlUpdateAppointment); PreparedStatement psDelete = con.prepareStatement(sqlDeleteServices); PreparedStatement psInsert = con.prepareStatement(sqlInsertService)) {

                psUpdate.setString(1, status);
                psUpdate.setInt(2, appointmentId);
                psUpdate.executeUpdate();

                psDelete.setInt(1, appointmentId);
                psDelete.executeUpdate();

                // 3. Thêm lại các dịch vụ mới được chọn
                for (int serviceId : serviceIds) {
                    psInsert.setInt(1, serviceId);
                    psInsert.setInt(2, appointmentId);
                    psInsert.addBatch();
                }
                psInsert.executeBatch();

                con.commit();
                return true;

            } catch (SQLException e) {

                con.rollback();
                System.err.println("Transaction is being rolled back. Error: " + e.getMessage());

                throw e;
            }
        }

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
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {
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

}

package model;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

public class Appointment {

    private int id;
    private int customerId;
    private int staffId;
    private LocalDateTime appointmentTime;
    private String status;
    private String customerName;
    private String services;
    private float totalAmount;
    private int branchId;
    private String staffName;
    private String branchName;

    public Appointment(LocalDateTime appointment_time, int customerId1, int staff) {
    }

    public Appointment() {
    }

    public Appointment(int id, LocalDateTime appointmentTime, String status, String services, float totalAmount, String staffName, String branchName) {
        this.id = id;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.services = services;
        this.totalAmount = totalAmount;
        this.staffName = staffName;
        this.branchName = branchName;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public Appointment(int id, int customerId, int staffId, LocalDateTime appointmentTime, String status, String customerName, String services, float totalAmount, int branchId) {
        this.id = id;
        this.customerId = customerId;
        this.staffId = staffId;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.customerName = customerName;
        this.services = services;
        this.totalAmount = totalAmount;
        this.branchId = branchId;
    }

    public Appointment(int id, int customerId, int staffId, LocalDateTime appointmentTime, String status, String customerName, String services, float totalAmount) {
        this.id = id;
        this.customerId = customerId;
        this.staffId = staffId;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.customerName = customerName;
        this.services = services;
        this.totalAmount = totalAmount;
    }

    public Appointment(int id, int customerId, int staffId, LocalDateTime appointmentTime, String status, String customerName, String services, int branchId) {
        this.id = id;
        this.customerId = customerId;
        this.staffId = staffId;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.customerName = customerName;
        this.services = services;
        this.branchId = branchId;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Appointment(int id, int customerId, int staffId, LocalDateTime appointmentTime, String status) {
        this.id = id;
        this.customerId = customerId;
        this.staffId = staffId;
        this.appointmentTime = appointmentTime;
        this.status = status;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public LocalDateTime getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(LocalDateTime appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getServices() {
        return services;
    }

    public void setServices(String services) {
        this.services = services;
    }

    public Date getAppointmentDateAsUtilDate() {
        if (this.appointmentTime == null) {
            return null;
        }
        // Convert LocalDateTime to java.util.Date
        // You might need to specify a ZoneId if your application operates across time zones.
        // For simplicity, using system default.
        return Date.from(this.appointmentTime.atZone(ZoneId.systemDefault()).toInstant());
    }

}

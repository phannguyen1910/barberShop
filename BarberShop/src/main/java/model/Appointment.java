package model;

import java.time.LocalDateTime;

public class Appointment {

    private int id;
    private int customerId;
    private int staffId;
    private LocalDateTime appointmentTime;
    private String status;
    private int numberOfPeople;
    private String customerName;
    private String services;
    private double totalAmount;
    private int branchId;

    public Appointment(LocalDateTime appointment_time, int customerId1, int staff) {
    }

    public Appointment() {
    }

    public Appointment(int id, int customerId, int staffId, LocalDateTime appointmentTime, String status, int numberOfPeople, String customerName, String services, double totalAmount, int branchId) {
        this.id = id;
        this.customerId = customerId;
        this.staffId = staffId;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.numberOfPeople = numberOfPeople;
        this.customerName = customerName;
        this.services = services;
        this.totalAmount = totalAmount;
        this.branchId = branchId;
    }

    public Appointment(int id, int customerId, int staffId, LocalDateTime appointmentTime, String status, String customerName, String services, double totalAmount) {
        this.id = id;
        this.customerId = customerId;
        this.staffId = staffId;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.customerName = customerName;
        this.services = services;
        this.totalAmount = totalAmount;
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

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Appointment(int id, int customerId, int staffId, LocalDateTime appointmentTime, String status, int numberOfPeople) {
        this.id = id;
        this.customerId = customerId;
        this.staffId = staffId;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.numberOfPeople = numberOfPeople;
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

    public int getNumberOfPeople() {
        return numberOfPeople;
    }

    public void setNumberOfPeople(int numberOfPeople) {
        this.numberOfPeople = numberOfPeople;
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

}

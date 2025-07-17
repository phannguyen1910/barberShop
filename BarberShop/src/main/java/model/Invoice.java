package model;

import java.time.LocalDate;

public class Invoice {
    private int id;
    private double totalAmount;
    private String paymentStatus;
    private LocalDate receivedDate;
    private int appointmentId;
    private String voucherCode;
    private String paymentMethod;
    
    public Invoice(double amount, String paymentStatus1, LocalDate receivedDate1, int appointmentId1, Integer voucherId) {
    }

    public Invoice(double amount, String paymentStatus, LocalDate receivedDate, int appointmentId, String voucherCode, String paymentMethod) {
        this.totalAmount = amount;
        this.paymentStatus = paymentStatus;
        this.receivedDate = receivedDate;
        this.appointmentId = appointmentId;
        this.voucherCode = voucherCode;
        this.paymentMethod = paymentMethod;
    }

  
    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getAmount() {
        return totalAmount;
    }

    public void setAmount(double amount) {
        this.totalAmount = amount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public LocalDate getReceivedDate() {
        return receivedDate;
    }

    public void setReceivedDate(LocalDate receivedDate) {
        this.receivedDate = receivedDate;
    }

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

   
}

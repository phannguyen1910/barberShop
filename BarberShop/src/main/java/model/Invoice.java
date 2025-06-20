package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Invoice {

    private int id;
    private float totalAmount;
    private LocalDateTime receivedDate;
    private int appointmentId;
    private String status;

    public Invoice(double amount, String paymentStatus1, LocalDate receivedDate1, int appointmentId1, Integer voucherId) {
    }

    public Invoice(int id, float totalAmount, LocalDateTime receivedDate, int appointmentId, String status) {
        this.id = id;
        this.totalAmount = totalAmount;
        this.receivedDate = receivedDate;
        this.appointmentId = appointmentId;
        this.status = status;
    }

    public Invoice(int id, float totalAmount, LocalDateTime receivedDate) {
        this.id = id;
        this.totalAmount = totalAmount;
        this.receivedDate = receivedDate;
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

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public LocalDateTime getReceivedDate() {
        return receivedDate;
    }

    public void setReceivedDate(LocalDateTime receivedDate) {
        this.receivedDate = receivedDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

}

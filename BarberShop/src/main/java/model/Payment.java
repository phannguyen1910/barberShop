package model;

import java.sql.Timestamp;

public class Payment {
    private int id;
    private int appointmentId;
    private String transactionNo;
    private String method;
    private float amount;
    private Timestamp receivedDate;

    public Payment() {}

    public Payment(int appointmentId, String transactionNo, String method, float amount, Timestamp receivedDate) {
        this.appointmentId = appointmentId;
        this.transactionNo = transactionNo;
        this.method = method;
        this.amount = amount;
        this.receivedDate = receivedDate;
    }

    // Getters & Setters
    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public String getTransactionNo() {
        return transactionNo;
    }

    public void setTransactionNo(String transactionNo) {
        this.transactionNo = transactionNo;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public float getAmount() {
        return amount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public Timestamp getReceivedDate() {
        return receivedDate;
    }

    public void setReceivedDate(Timestamp receivedDate) {
        this.receivedDate = receivedDate;
    }
}

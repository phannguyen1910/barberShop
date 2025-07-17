package model;

import java.sql.Timestamp;

public class Payment {
    private int id;
    private int bookingId;
    private String transactionNo;
    private double amount;
    private String method;
    private String status;
    private Timestamp payTime;

    // Constructors
    public Payment() {}

    public Payment(int bookingId, String transactionNo, double amount, String method, String status) {
        this.bookingId = bookingId;
        this.transactionNo = transactionNo;
        this.amount = amount;
        this.method = method;
        this.status = status;
    }

    // Getters
    public int getId() {
        return id;
    }

    public int getBookingId() {
        return bookingId;
    }

    public String getTransactionNo() {
        return transactionNo;
    }

    public double getAmount() {
        return amount;
    }

    public String getMethod() {
        return method;
    }

    public String getStatus() {
        return status;
    }

    public Timestamp getPayTime() {
        return payTime;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public void setTransactionNo(String transactionNo) {
        this.transactionNo = transactionNo;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setPayTime(Timestamp payTime) {
        this.payTime = payTime;
    }
}

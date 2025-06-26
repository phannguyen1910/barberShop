package model;

import java.sql.Timestamp;

public class Payment {
    private int id;
    private int invoiceId;
    private double amount;
    private Timestamp receivedDate;

    // Constructors, Getters, Setters
    public Payment() {}

    public Payment(int invoiceId, double amount, Timestamp receivedDate) {
        this.invoiceId = invoiceId;
        this.amount = amount;
        this.receivedDate = receivedDate;
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Timestamp getReceivedDate() {
        return receivedDate;
    }

    public void setReceivedDate(Timestamp receivedDate) {
        this.receivedDate = receivedDate;
    }
}

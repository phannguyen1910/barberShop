package model;

import java.time.LocalDateTime;

public class Feedback {
    private int id;
    private int customerId;
    private int staffId;
    private int appointmentId;
    private String comment;
    private java.time.LocalDateTime feedbackTime;
    private int rate;
    private int serviceId;
    private int rating;
    private String customerName;
    private String staffName;

    public Feedback() {
    }

    public Feedback(int customerId, int staffId, int appointmentId, String comment, int rate, java.time.LocalDateTime feedbackTime) {
        this.customerId = customerId;
        this.staffId = staffId;
        this.appointmentId = appointmentId;
        this.comment = comment;
        this.rate = rate;
        this.feedbackTime = feedbackTime;
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

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public java.time.LocalDateTime getFeedbackTime() {
        return feedbackTime;
    }

    public void setFeedbackTime(java.time.LocalDateTime feedbackTime) {
        this.feedbackTime = feedbackTime;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }
}

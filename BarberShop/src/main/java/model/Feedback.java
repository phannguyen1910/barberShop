
package model;

import java.time.LocalDateTime;

public class Feedback {
    private int id;
    private int customerId;
    private int staffId;
    private int appointmentId;
    private String comment;
    private int rate;
    private LocalDateTime feedbackTime;

    public Feedback() {
    }

    public Feedback(int customerId, int staffId, int appointmentId, String comment, int rate, LocalDateTime feedbackTime) {
        this.customerId = customerId;
        this.staffId = staffId;
        this.appointmentId = appointmentId;
        this.comment = comment;
        this.rate = rate;
        this.feedbackTime = feedbackTime;
    }
    
    
    

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public LocalDateTime getFeedbackTime() {
        return feedbackTime;
    }

    public void setFeedbackTime(LocalDateTime feedbackTime) {
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
}

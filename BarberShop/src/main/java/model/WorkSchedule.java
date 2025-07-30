package model;

import java.time.LocalDate;

public class WorkSchedule {
    private int id;
    private int staffId;
    private LocalDate workDate;
    private String status;
    private String firstName;
    private String lastName;
    private String branch;

    // Default constructor
    public WorkSchedule() {
    }

    // Getters
    public int getId() {
        return id;
    }

    public int getStaffId() {
        return staffId;
    }

    public LocalDate getWorkDate() {
        return workDate;
    }

    public String getStatus() {
        return status;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getBranch() {
        return branch;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public void setWorkDate(LocalDate workDate) {
        this.workDate = workDate;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }
}
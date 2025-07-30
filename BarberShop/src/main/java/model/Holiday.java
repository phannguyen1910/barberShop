package model;

public class Holiday {
    private String date;
    private String name;
    private String status;

    public Holiday() {}

    public Holiday(String date, String name, String status) {
        this.date = date;
        this.name = name;
        this.status = status;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}

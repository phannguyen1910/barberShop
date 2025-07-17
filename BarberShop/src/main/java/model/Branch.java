
package model;

public class Branch {
      private int id;
    private String name;
    private String address;
    private boolean status;
    private String city;
    // Constructors
    public Branch() {
    }

    public Branch(int id, String name, String address, boolean status, String city) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.status = status;
        this.city = city;
    }

    public Branch(String name, String address, boolean status, String city) {
        this.name = name;
        this.address = address;
        this.status = status;
        this.city = city;
    }

    public Branch(int id, String name, String address, String city) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.city = city;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    // Optional: toString()
    @Override
    public String toString() {
        return "Branch{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", status=" + status +
                '}';
    }
}

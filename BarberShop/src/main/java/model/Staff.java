package model;

public class Staff extends Account{

    private int id;
    private int accountId;
    private String firstName;
    private String lastName;
    private String img;

    // Constructor
    public Staff(int id, int accountId, String firstName, String lastName, String img, String email, String phoneNumber, String password, String role, int status) {
        super(email, phoneNumber, password, role, status);
        this.id = id;
        this.accountId = accountId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.img = img;
    }

    public Staff() {
    }

    public Staff(String firstName, String lastName, String img) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.img = img;
    }

    public Staff(int id, String firstName, String lastName) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
    }
    
    

    public Staff( String firstName, String lastName, String img, String email, String phoneNumber, String password, String role, int status) {
        super(email, phoneNumber, password, role, status);
        this.firstName = firstName;
        this.lastName = lastName;
        this.img = img;
    }

    public Staff(String firstName, String lastName, String email, String phoneNumber, String password, String role, int status) {
        super(email, phoneNumber, password, role, status);
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public Staff(int id, String firstName, String lastName, String img) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.img = img;
    }


    
  
    

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }
    
    
}
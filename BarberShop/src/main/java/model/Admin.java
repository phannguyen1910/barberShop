
package model;

public class Admin extends Account {
    private int id;
    private String firstName;
    private String lastName;
    private int accountId;

    public Admin(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }
    
    
     public Admin(String email, String phoneNumber, String password, String role, int status, String firstName, String lastName) {
        super(email, phoneNumber, password, role, status);  // Call to superclass constructor
        this.firstName = firstName;
        this.lastName = lastName;
    }
    
    public Admin(int accountId, String firstName, String lastName, String email, String phoneNumber, String password, String role, int status) {
        super(email, phoneNumber, password, role, status);
        this.accountId = accountId;
    }
    
    public Admin(String firstName, String lastName, String email, String phoneNumber) {
        super(email, phoneNumber);
        this.firstName = firstName;
        this.lastName = lastName;
    }
    public Admin(String firstName, String lastName, String email, String phoneNumber, String password) {
        super(email, phoneNumber, password);
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }
    
    
}

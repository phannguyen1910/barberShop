package model;

/**
 *
 * @author Sekiro
 */
public class Customer extends Account {

    private int id;
    private int accountId;
    private String firstName;
    private String lastName;

    // Constructor
    public Customer(String email, String phoneNumber, String password, String role, int status, String firstName, String lastName) {
        super(email, phoneNumber, password, role, status);
    }

    public Customer(int id, int accountId, String firstName, String lastName, String email, String phoneNumber, String password, String role, int status) {
        super(email, phoneNumber, password, role, status);
        this.id = id;
        this.accountId = accountId;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public Customer(int id, String firstName, String lastName, String email, String phoneNumber) {
        super(email, phoneNumber);
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    
    
    

    public Customer(int accountId, String firstName, String lastName) {
        this.accountId = accountId;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public Customer(int id, int accountId, String firstName, String lastName) {
        this.id = id;
        this.accountId = accountId;
        this.firstName = firstName;
        this.lastName = lastName;
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
}
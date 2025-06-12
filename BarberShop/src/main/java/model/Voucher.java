package model;

/**
 *
 * @author Sekiro
 */
import java.time.LocalDate;

public class Voucher {
    private int id;
    private String code;
    private float value;
    private LocalDate expiryDate;
    private String status;

    public Voucher() {
    }

    // Constructor
    public Voucher(String code, float value, LocalDate expiryDate, String status) {
        this.code = code;
        this.value = value;
        this.expiryDate = expiryDate;
        this.status = status;
    }

    public Voucher(String code, float value, LocalDate expiryDate) {
        this.code = code;
        this.value = value;
        this.expiryDate = expiryDate;
    }
    
    

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public float getValue() {
        return value;
    }

    public void setValue(float value) {
        this.value = value;
    }

    public LocalDate getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(LocalDate expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}

package model;


import java.time.LocalDate;

public class Voucher {
    private int id;
    private String code;
    private String voucherName; // Thêm thuộc tính mới
    private float value;
    private LocalDate expiryDate;
    private int status;

    public Voucher() {
    }

    // Constructor
    public Voucher(String code, float value, LocalDate expiryDate, int status) {
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

    public Voucher(int id, String code, float value, LocalDate expiryDate, int status) {
        this.id = id;
        this.code = code;
        this.value = value;
        this.expiryDate = expiryDate;
        this.status = status;
    }

    public Voucher(int id, String code, LocalDate expiryDate, int status) {
        this.id = id;
        this.code = code;
        this.expiryDate = expiryDate;
        this.status = status;
    }

    public Voucher(String code, LocalDate expiryDate, int status) {
        this.code = code;
        this.expiryDate = expiryDate;
        this.status = status;
    }

    public Voucher(int id, String code, float value, String expiryDate, int status) {
        throw new UnsupportedOperationException("Not supported yet."); }

    // Constructor mới bao gồm voucherName
    public Voucher(int id, String code, String voucherName, float value, LocalDate expiryDate, int status) {
        this.id = id;
        this.code = code;
        this.voucherName = voucherName;
        this.value = value;
        this.expiryDate = expiryDate;
        this.status = status;
    }

    public Voucher(String code, String voucherName, float value, LocalDate expiryDate, int status) {
        this.code = code;
        this.voucherName = voucherName;
        this.value = value;
        this.expiryDate = expiryDate;
        this.status = status;
    }

    public Voucher(int id, String code, String voucherName, LocalDate expiryDate, int status) {
        throw new UnsupportedOperationException("Not supported yet."); 
    }

    public Voucher(String code, float value, LocalDate expiryDate, String status) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
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

    public String getVoucherName() { // Thêm getter
        return voucherName;
    }

    public void setVoucherName(String voucherName) { // Thêm setter
        this.voucherName = voucherName;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}

package model;

public class Validation {
    public static String validateFirstName(String firstName){
        
        
        if (firstName.length() > 50) {
            return "First name must be less than 50 characters long.";
        }
        String nameRegex = "^[\\p{L}\\s]+$";
        if (!firstName.matches(nameRegex)) {
            System.out.println("Name must contain only letters and spaces.");
            return "Tên chỉ được chứa chữ cái và khoảng trắng.";
        }
        return null; 
    }
    
    public String validateLastName(String lastName){
        
         if (lastName.length() < 2) {
            System.out.println("eror in lasname1");
            return "Họ phải dài ít nhất 2 ký tự.";
            
        }
        
        if (lastName.length() > 50) {
            System.out.println("eror in lastname2");
            return "Họ phải có độ dài dưới 50 ký tự.";
        }
        String lastNameRegex = "^[\\p{L}]+(\\s[\\p{L}]+)*$";

        if (!lastName.matches(lastNameRegex)) {
            System.out.println("eror in lastName3");
            return "Họ chỉ được chứa chữ cái và khoảng trắng.";
        }
        return null; 
    }
    
    public String validatePhoneNumber(String phoneNumber) {
        String phoneRegex = "^0\\d{9}$"; 
        // Kiểm tra số điện thoại có hợp lệ không
        if (!phoneNumber.matches(phoneRegex)) {
            System.out.println("eror in phone");
            return "Số điện thoại phải bắt đầu bằng số 0 và có đúng 10 chữ số.";
        }

        return null;
    }
    
   
}

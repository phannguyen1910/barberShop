# Fix Lỗi Session Booking Không Được Xóa Sau Khi Thanh Toán

## Vấn đề

Sau khi đặt lịch và thanh toán xong, khi quay lại đặt lịch mới, thông tin booking cũ vẫn còn lưu trong session, gây ra việc hiển thị thông tin cũ thay vì cho phép người dùng chọn mới.

## Nguyên nhân

- `VnpayReturnServlet` chỉ xóa session trong khối `catch` (khi có lỗi)
- Không xóa session khi thanh toán thành công
- Code xóa session bị trùng lặp và đặt sai vị trí

## Giải pháp đã thực hiện

### 1. Sửa VnpayReturnServlet.java

```java
// Thêm xóa session sau khi thanh toán thành công
if ("00".equals(vnp_ResponseCode)) {
    // Thanh toán thành công
    try {
        // ... xử lý thanh toán ...

        // Xóa các session booking sau khi thanh toán thành công
        clearBookingSession(session);
    } catch (Exception e) {
        // ... xử lý lỗi ...
    }
} else {
    // Thanh toán thất bại
    req.setAttribute("transResult", false);
    req.setAttribute("error", "Thanh toán thất bại: Mã lỗi " + vnp_ResponseCode);

    // Xóa session ngay cả khi thanh toán thất bại
    clearBookingSession(session);
}
```

### 2. Thêm method clearBookingSession()

```java
/**
 * Xóa tất cả session liên quan đến booking để tránh thông tin cũ còn lưu
 * khi người dùng đặt lịch mới
 */
private void clearBookingSession(HttpSession session) {
    // Xóa session booking cơ bản
    session.removeAttribute("serviceNames");
    session.removeAttribute("staffFullName");
    session.removeAttribute("appointmentTime");
    session.removeAttribute("totalServiceDuration");
    session.removeAttribute("selectedBranchName");
    session.removeAttribute("customerEmail");
    session.removeAttribute("selectedTotalPrice");
    session.removeAttribute("selectedBranchId");
    session.removeAttribute("servicesId");
    session.removeAttribute("preSelectedBranchId");
    session.removeAttribute("preSelectedBranchName");
    session.removeAttribute("selectedServiceNames");

    // Xóa thêm các session khác có thể liên quan
    session.removeAttribute("customerId");
    session.removeAttribute("staffId");
    session.removeAttribute("amount");
    session.removeAttribute("txnRef");
    session.removeAttribute("appointmentId");

    System.out.println("✅ Đã xóa tất cả session booking");
}
```

### 3. Cập nhật payment-success.jsp

- Thêm nút "Đặt lịch mới" để người dùng có thể bắt đầu đặt lịch mới
- Thêm nút "Thử lại" cho trường hợp thanh toán thất bại

## Các file đã thay đổi

1. `src/main/java/controller/Payment/VnpayReturnServlet.java`
2. `src/main/webapp/views/payment/payment-success.jsp`

## Cách test

### 1. Test luồng thanh toán thành công

1. Đặt lịch và thanh toán thành công
2. Sau khi thanh toán xong, click "Đặt lịch mới"
3. Kiểm tra xem form đặt lịch có sạch không (không còn thông tin cũ)

### 2. Test luồng thanh toán thất bại

1. Đặt lịch và thanh toán thất bại
2. Click "Thử lại"
3. Kiểm tra xem form đặt lịch có sạch không

### 3. Test trực tiếp

1. Đặt lịch xong
2. Quay lại trang đặt lịch
3. Kiểm tra xem có còn thông tin cũ không

## Lưu ý quan trọng

- Đảm bảo server được restart sau khi thay đổi
- Session sẽ được xóa trong cả 3 trường hợp: thành công, thất bại, và có lỗi
- Người dùng có thể bắt đầu đặt lịch mới ngay sau khi thanh toán xong

## Kết quả mong đợi

Sau khi áp dụng các thay đổi:

- Session booking sẽ được xóa hoàn toàn sau khi thanh toán
- Người dùng có thể đặt lịch mới mà không bị ảnh hưởng bởi thông tin cũ
- Giao diện rõ ràng với các nút điều hướng phù hợp

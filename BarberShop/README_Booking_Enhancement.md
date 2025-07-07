# Tính năng Vô hiệu hóa Khung giờ dựa trên Thời lượng Lịch đặt

## Tổng quan

Tính năng này cho phép hệ thống tự động vô hiệu hóa các khung giờ không khả dụng khi đặt lịch với nhân viên, dựa trên thời lượng của các dịch vụ đã chọn và lịch hẹn hiện có của nhân viên.

## Các thành phần chính

### 1. API Endpoints

#### `/api/staff-availability`

- **Mục đích**: Lấy thông tin về các khung giờ đã bị chiếm của nhân viên trong một ngày cụ thể
- **Method**: GET
- **Parameters**:
  - `staffId`: ID của nhân viên
  - `appointmentDate`: Ngày cần kiểm tra (format: YYYY-MM-DD)
- **Response**: JSON array chứa thông tin các khung giờ bị chiếm

```json
[
  {
    "startTime": "09:00",
    "endTime": "10:30",
    "durationMinutes": 90
  }
]
```

#### `/api/service-duration`

- **Mục đích**: Tính toán tổng thời lượng của các dịch vụ đã chọn
- **Method**: GET
- **Parameters**:
  - `serviceIds`: Array các ID dịch vụ
- **Response**: JSON object chứa thông tin thời lượng

```json
{
  "totalDurationMinutes": 120,
  "services": [...]
}
```

### 2. Các file đã được cập nhật

#### Backend

- `src/main/java/controller/StaffManagement/StaffAvailabilityServlet.java`
- `src/main/java/controller/ServiceManagement/ServiceDurationServlet.java`

#### Frontend

- `src/main/webapp/views/booking/booking.jsp`
- `src/main/webapp/CSS/booking.css`

## Cách hoạt động

### 1. Khi người dùng chọn nhân viên

- Hệ thống gọi API `/api/staff-availability` để lấy danh sách các khung giờ đã bị chiếm
- Các khung giờ bị chiếm sẽ được vô hiệu hóa và hiển thị tooltip thông tin

### 2. Khi người dùng chọn dịch vụ

- Hệ thống gọi API `/api/service-duration` để tính toán tổng thời lượng
- Thời lượng được lưu vào session storage
- Các khung giờ không đủ thời gian sẽ được vô hiệu hóa

### 3. Logic kiểm tra khung giờ

Hệ thống kiểm tra các điều kiện sau:

- Khung giờ có nằm trong thời gian làm việc không (8:30 - 20:30)
- Khung giờ có bị chiếm bởi lịch hẹn khác không
- Có đủ thời gian cho dịch vụ đã chọn không
- Khung giờ có nằm trong quá khứ không (nếu là ngày hôm nay)

## Cách sử dụng

### 1. Trong quá trình đặt lịch

1. Chọn chi nhánh
2. Chọn dịch vụ (hệ thống sẽ tính toán thời lượng)
3. Chọn ngày
4. Chọn nhân viên (hệ thống sẽ kiểm tra lịch trống)
5. Chọn khung giờ khả dụng
6. Xác nhận đặt lịch

### 2. Hiển thị trực quan

- Khung giờ khả dụng: Nền trắng, có thể click
- Khung giờ bị chiếm: Nền xám, không thể click, có tooltip hiển thị thông tin
- Khung giờ không đủ thời gian: Nền xám, tooltip hiển thị "Không đủ thời gian"

## Testing

Sử dụng file `test_api.html` để test các API:

1. Mở file trong trình duyệt
2. Nhập thông tin test
3. Click nút test để kiểm tra response

## Lưu ý kỹ thuật

### 1. Thời gian

- Hệ thống sử dụng múi giờ local của browser
- Thời gian làm việc: 8:30 - 20:30
- Khung giờ được chia thành 30 phút

### 2. Database

- Cần có cột `totalServiceDurationMinutes` trong bảng `Appointment`
- Cột `duration` trong bảng `Service` chứa thời lượng dịch vụ (phút)

### 3. Performance

- API calls được thực hiện bất đồng bộ
- Sử dụng session storage để cache thông tin thời lượng
- Chỉ gọi API khi cần thiết

## Troubleshooting

### 1. Khung giờ không được vô hiệu hóa

- Kiểm tra console để xem có lỗi API không
- Đảm bảo nhân viên và ngày đã được chọn
- Kiểm tra dữ liệu trong database

### 2. API trả về lỗi

- Kiểm tra log server
- Đảm bảo các tham số được truyền đúng
- Kiểm tra kết nối database

### 3. Tooltip không hiển thị

- Kiểm tra CSS có được load đúng không
- Đảm bảo thuộc tính `title` được set đúng
- Kiểm tra z-index của tooltip

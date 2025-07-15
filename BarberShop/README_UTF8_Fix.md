# Fix Lỗi Encoding UTF-8 cho Chatbot

## Vấn đề

Chatbot của bạn đang gặp lỗi encoding khi trả lời bằng tiếng Việt, hiển thị các ký tự lỗi như:

```
VÃ¢ng, tÃ´i cÃ³ thá»ƒ tÆ° váº¥n vá» kiá»ƒu tÃ³c "cáº¯t moi" cho nam...
```

## Nguyên nhân

Lỗi này xảy ra do thiếu cấu hình encoding UTF-8 ở nhiều tầng:

1. **Servlet level**: Không thiết lập encoding cho request/response
2. **API Client level**: Không thiết lập encoding khi đọc response từ Gemini API
3. **Database level**: Không cấu hình encoding cho connection
4. **Web application level**: Không có filter encoding toàn cục

## Giải pháp đã thực hiện

### 1. Sửa ChatServlet.java

```java
// Thêm vào đầu doGet() và doPost()
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
response.setContentType("application/json;charset=UTF-8");
```

### 2. Sửa GeminiApiClient.java

```java
// Sửa BufferedReader để đọc với UTF-8
try (BufferedReader br = new BufferedReader(new InputStreamReader(
    connection.getResponseCode() == 200
    ? connection.getInputStream() : connection.getErrorStream(), "UTF-8"))) {
```

### 3. Sửa databaseInfo.java

```java
// Thêm encoding parameters vào connection URL
public static String DBURL = "jdbc:sqlserver://DESKTOP-CIUU9E1\\SQLEXPRESS;databaseName=baberShop;encrypt=false;trustServerCertificate=false;loginTimeout=30;characterEncoding=UTF-8;useUnicode=true;";
```

### 4. Thêm CharacterEncodingFilter vào web.xml

```xml
<filter>
    <filter-name>CharacterEncodingFilter</filter-name>
    <filter-class>org.apache.catalina.filters.SetCharacterEncodingFilter</filter-class>
    <init-param>
        <param-name>encoding</param-name>
        <param-value>UTF-8</param-value>
    </init-param>
    <init-param>
        <param-name>forceEncoding</param-name>
        <param-value>true</param-value>
    </init-param>
</filter>
<filter-mapping>
    <filter-name>CharacterEncodingFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

## Cách test

### 1. Sử dụng file test_chatbot_encoding.html

- Mở file `test_chatbot_encoding.html` trong browser
- Click các nút test để gửi tin nhắn tiếng Việt
- Kiểm tra xem chatbot có trả lời đúng encoding không

### 2. Test trực tiếp trên website

- Mở chatbot trên website chính
- Gửi tin nhắn: "Tư vấn kiểu tóc cắt moi cho nam"
- Kiểm tra xem response có hiển thị đúng tiếng Việt không

## Các file đã thay đổi

1. `src/main/java/controller/ChatServlet.java`
2. `src/main/java/chatbot/GeminiApiClient.java`
3. `src/main/java/babershopDatabase/databaseInfo.java`
4. `src/main/webapp/WEB-INF/web.xml`
5. `test_chatbot_encoding.html` (file test mới)

## Lưu ý quan trọng

- Đảm bảo server được restart sau khi thay đổi
- Kiểm tra database có hỗ trợ UTF-8 không
- Đảm bảo IDE/editor sử dụng UTF-8 encoding
- Kiểm tra browser có hỗ trợ UTF-8 không

## Kết quả mong đợi

Sau khi áp dụng các thay đổi, chatbot sẽ trả lời tiếng Việt đúng cách:

```
Vâng, tôi có thể tư vấn về kiểu tóc "cắt moi" cho nam. Bạn muốn biết thông tin gì về kiểu tóc này?
```

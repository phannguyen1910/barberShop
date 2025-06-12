package controller;

import babershopDAO.AccountDAO;
import babershopDAO.CustomerDAO;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Properties;
import java.util.Random;

@WebServlet(name = "SendOTPServlet", urlPatterns = {"/send-otp"})
public class SendOTPServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        RequestDispatcher dispatcher = null;
        HttpSession session = request.getSession();
        
        // Lấy email từ form
        String email = request.getParameter("email");
        
        // Kiểm tra email có được nhập không
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("message", "Please enter your email address.");
            dispatcher = request.getRequestDispatcher("/views/auth/forgot-password.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        // Trim email để loại bỏ khoảng trắng
        email = email.trim();
        
        try {
            // Kiểm tra xem email có tồn tại trong hệ thống không
            if (!AccountDAO.checkExistedEmail(email)) {
                request.setAttribute("message", "Email address not found in our system. Please try again.");
                dispatcher = request.getRequestDispatcher("/views/auth/forgot-password.jsp");
                dispatcher.forward(request, response);
                return;
            }
            
            // Tạo OTP ngẫu nhiên
            Random rand = new Random();
            int otpvalue = 100000 + rand.nextInt(900000); // OTP từ 100000 đến 999999
            
            // Cấu hình email
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", "465");

            Session mailSession = Session.getDefaultInstance(props, new jakarta.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("nguynhuphannguyen2004@gmail.com", "gyyi hdqm vqtq fuwc");
                }
            });

            // Gửi email
            try {
                MimeMessage message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress("nguynhuphannguyen2004@gmail.com"));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                message.setSubject("OTP for Password Reset - Cut&StyleBarber");
                message.setText("Dear Customer,\n\n" +
                              "Your OTP code for password reset is: " + otpvalue + "\n\n" +
                              "This OTP is valid for 60 seconds only.\n" +
                              "Please do not share this code with anyone.\n\n" +
                              "Best regards,\n" +
                              "Cut&StyleBarber Team");
                
                Transport.send(message);
                System.out.println("OTP sent successfully to: " + email);
                
                // Lưu thông tin vào session
                session.setAttribute("otp", otpvalue);
                session.setAttribute("otpGeneratedTime", System.currentTimeMillis());
                session.setAttribute("email", email);
                
                // Chuyển đến trang xác thực OTP
                request.setAttribute("message", "OTP has been sent to your email address. Please check your inbox.");
                dispatcher = request.getRequestDispatcher("/views/auth/otp-verification.jsp");
                dispatcher.forward(request, response);
                
            } catch (MessagingException e) {
                e.printStackTrace();
                System.err.println("Failed to send email: " + e.getMessage());
                request.setAttribute("message", "Failed to send OTP email. Please try again later.");
                dispatcher = request.getRequestDispatcher("/views/auth/forgot-password.jsp");
                dispatcher.forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error in SendOTPServlet: " + e.getMessage());
            request.setAttribute("message", "An error occurred. Please try again.");
            dispatcher = request.getRequestDispatcher("/views/auth/forgot-password.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to forgot password page
        response.sendRedirect(request.getContextPath() + "/views/auth/forgot-password.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Servlet for sending OTP to user's email for password reset";
    }
}
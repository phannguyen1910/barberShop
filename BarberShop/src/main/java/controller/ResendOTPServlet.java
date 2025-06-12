/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ResendOTPServlet", urlPatterns = {"/resend-otp"})
public class ResendOTPServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ResendOTPServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResendOTPServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher;

        session.removeAttribute("otp");
        session.removeAttribute("otpGeneratedTime");
        String email = (String) session.getAttribute("email");

        int otpvalue = 0;

        // Kiểm tra xem email có hợp lệ không
        if (email != null && !email.isEmpty()) {
            Random rand = new Random();
            otpvalue = 100000 + rand.nextInt(900000); // Tạo mã OTP ngẫu nhiên từ 100000 đến 999999

            String to = email;
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

            try {
                MimeMessage message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress("nguynhuphannguyen2004@gmail.com"));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject("OTP for Password Reset");
                message.setText("OTP Code: " + otpvalue + "\nYour OTP code in Cut&StyleBarber valid within 60 seconds. You do not give this code to anyone.");
                Transport.send(message);
                System.out.println("OTP sent successfully");
            } catch (MessagingException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Failed to send OTP. Please try again.");
                dispatcher = request.getRequestDispatcher("/views/auth/forgot-password.jsp");
                dispatcher.forward(request, response);
                return;
            }

            session.setAttribute("otp", otpvalue);
            session.setAttribute("otpGeneratedTime", System.currentTimeMillis());
            session.setAttribute("email", email);
            request.setAttribute("message", "OTP has been sent to your email address");

            response.sendRedirect(request.getContextPath() + "/views/auth/otp-verification.jsp");

//            dispatcher = request.getRequestDispatcher("enterOTP.jsp");
//            dispatcher.forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Invalid email address. Please try again.");

            dispatcher = request.getRequestDispatcher(request.getContextPath() + "/views/auth/forgot-password.jsp");
            dispatcher.forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

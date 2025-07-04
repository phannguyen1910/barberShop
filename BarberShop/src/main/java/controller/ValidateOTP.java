/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ValidateOTP", urlPatterns = {"/validate-otp"})
public class ValidateOTP extends HttpServlet {

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
            out.println("<title>Servlet ValidateOTP</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ValidateOTP at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String otp = String.valueOf(request.getSession().getAttribute("otp"));
        String enteredOTP = (String) request.getParameter("enteredOTP");

        Long otpGeneratedTime = (Long) request.getSession().getAttribute("otpGeneratedTime");
        if (otpGeneratedTime == null || (System.currentTimeMillis() - otpGeneratedTime) > 60 * 1000) {
            request.setAttribute("message", "OTP has expired. Please request a new one.");
            request.getRequestDispatcher("/views/auth/otp-verification.jsp").forward(request, response);
            return;
        }

        if (otp == null || enteredOTP == null || otp.isEmpty() || enteredOTP.isEmpty()) {
            request.setAttribute("message", "null enteredOTP");
            request.getRequestDispatcher("/views/auth/otp-verification.jsp").forward(request, response);
            return;
        }

        if (otp.equalsIgnoreCase(enteredOTP)) {
            request.getRequestDispatcher("/views/auth/reset-password.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Wrong OTP code!");
            request.getRequestDispatcher("/views/auth/otp-verification.jsp").forward(request, response);
        }
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

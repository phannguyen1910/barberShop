/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import babershopDAO.ServiceDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DeleteService", urlPatterns = {"/DeleteService"})
public class DeleteService extends HttpServlet {

    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        serviceDAO = new ServiceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String idStr = request.getParameter("id");
        if (idStr == null) {
            String message = URLEncoder.encode("ID dịch vụ không hợp lệ", "UTF-8");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?error=" + message);
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            String message = URLEncoder.encode("ID dịch vụ không hợp lệ", "UTF-8");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?error=" + message);
            return;
        }

        try {
            serviceDAO.deleteService(id);
            String message = URLEncoder.encode("Xóa dịch vụ thành công", "UTF-8");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?success=" + message);
        } catch (Exception e) {
            e.printStackTrace();
            String message = URLEncoder.encode("Có lỗi xảy ra khi xóa dịch vụ: " + e.getMessage(), "UTF-8");
            response.sendRedirect(request.getContextPath() + "/ViewServicesServlet?error=" + message);
        }
    }
}



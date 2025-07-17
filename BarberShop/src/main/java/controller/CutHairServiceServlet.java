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
import java.util.List;
import java.util.stream.Collectors;
import model.Service;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CutHairServiceServlet", urlPatterns = {"/CutHairServiceServlet"})

public class CutHairServiceServlet extends HttpServlet {
    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        serviceDAO = new ServiceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tất cả dịch vụ
        List<Service> allServices = serviceDAO.getAllService();
        
        // Lọc dịch vụ có categoryID = 1 (Cắt Tóc)
        List<Service> cutHairServices = allServices != null 
            ? allServices.stream()
                .filter(service -> service.getCategoryID() == 1)
                .collect(Collectors.toList())
            : null;

        // Đặt danh sách dịch vụ vào request
        request.setAttribute("cutHairServices", cutHairServices);
        
        // Chuyển hướng đến cutHairService.jsp
        request.getRequestDispatcher("/views/service/cutHairService.jsp").forward(request, response);
    }
}

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
import model.Service;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ViewServicesServlet", urlPatterns = {"/ViewServicesServlet"})
public class ViewServicesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServiceDAO serviceDAO = new ServiceDAO();
        List<Service> services = serviceDAO.getAllService();
        System.out.println("Danh sách dịch vụ: " + (services != null ? services : "null"));
        if (services != null) {
            System.out.println("Số lượng dịch vụ: " + services.size());
            for (Service s : services) {
                System.out.println("Service: " + s.getId() + ", " + s.getName());
            }
        }
        request.setAttribute("services", services);
        request.getRequestDispatcher("/views/admin/serviceManagement.jsp").forward(request, response);
    }
}

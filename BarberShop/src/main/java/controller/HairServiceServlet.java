/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;


import babershopDAO.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import model.Service;

@WebServlet("/HairServiceServlet")
public class HairServiceServlet extends HttpServlet {
    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        serviceDAO = new ServiceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Service> allServices = serviceDAO.getAllService();
        List<Service> hairServices = allServices != null 
            ? allServices.stream()
                .filter(service -> service.getCategoryID() == 2 || service.getCategoryID() == 3)
                .collect(Collectors.toList())
            : null;
        request.setAttribute("hairServices", hairServices);
        request.getRequestDispatcher("/views/service/hairStylesService.jsp").forward(request, response);
    }
}

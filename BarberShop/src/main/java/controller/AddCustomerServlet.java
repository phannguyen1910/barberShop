package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import model.Customer;
import babershopDAO.CustomerDAO;

@WebServlet("/add-customer")
public class AddCustomerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String password = request.getParameter("password");

        // Tạo customer từ constructor cha
        Customer customer = new Customer(
            0, 0, // id, accountId sẽ được sinh sau
            firstName,
            lastName,
            email,
            phoneNumber,
            password,
            "Customer", // role mặc định
            1           // status: 1 = active
        );

        // Gọi hàm insert từ DAO
        CustomerDAO.insertCustomer(customer);

        // Chuyển hướng về trang quản lý khách hàng
        response.sendRedirect(request.getContextPath() + "/admin/view-customers");
    }
}


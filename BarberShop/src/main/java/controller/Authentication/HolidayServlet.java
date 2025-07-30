package controller.Authentication;

import com.google.gson.Gson;
import babershopDAO.HolidayDAO;
import model.Holiday;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.*;
import java.util.List;

@WebServlet("/api/holidays")
public class HolidayServlet extends HttpServlet {

    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Holiday> holidays = HolidayDAO.getAllHolidays(); // dùng đúng tên
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(holidays));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Holiday holiday = gson.fromJson(request.getReader(), Holiday.class);
        HolidayDAO.saveOrUpdate(holiday); // không cần boolean nếu DAO không trả về
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\":true}");
    }


    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String date = request.getParameter("date");
        HolidayDAO.deleteHolidayByDate(date); // gọi đúng tên phương thức
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\":true}");
    }
}


/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Authentication;

import babershopDAO.HolidayDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Holiday;

/**
 *
 * @author Admin
 */
@WebServlet("/api/holiday")
public class HolidayAPI extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HolidayDAO dao = new HolidayDAO();
        List<Holiday> holidays = HolidayDAO.getAllHolidays();

        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        out.print("[");
        for (int i = 0; i < holidays.size(); i++) {
            out.print("\"" + holidays.get(i).getDate().toString() + "\"");
            if (i != holidays.size() - 1) out.print(",");
        }
        out.print("]");
    }
}

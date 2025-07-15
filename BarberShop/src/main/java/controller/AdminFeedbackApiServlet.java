package controller;

import babershopDAO.FeedbackDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Feedback;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/api/feedback")
public class AdminFeedbackApiServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Feedback> feedbackList = FeedbackDAO.getAllFeedbackWithNames();
        if (feedbackList == null) feedbackList = new ArrayList<>();
        response.setContentType("application/json; charset=UTF-8");

        Gson gson = new GsonBuilder()
            .registerTypeAdapter(java.time.LocalDateTime.class, 
                (com.google.gson.JsonSerializer<java.time.LocalDateTime>) (src, typeOfSrc, context) ->
                    new com.google.gson.JsonPrimitive(src.format(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE_TIME))
            )
            .create();

        response.getWriter().write(gson.toJson(feedbackList));
    }
}
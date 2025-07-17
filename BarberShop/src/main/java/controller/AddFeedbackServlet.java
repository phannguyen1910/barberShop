package controller;

import babershopDAO.FeedbackDAO;
import babershopDAO.AppointmentDAO;
import model.Feedback;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "AddFeedbackServlet", urlPatterns = {"/addFeedback"})
public class AddFeedbackServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String staffIdParam = request.getParameter("staffId");
            int staffId;
            if (staffIdParam == null || staffIdParam.isEmpty() || staffIdParam.equals("0")) {
                // Lấy staffId từ DB dựa vào appointmentId nếu thiếu
                int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
                staffId = AppointmentDAO.getStaffIdByAppointmentId(appointmentId);
            } else {
                staffId = Integer.parseInt(staffIdParam);
            }
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");
            LocalDateTime feedbackTime = LocalDateTime.now();

            Feedback feedback = new Feedback();
            feedback.setCustomerId(customerId);
            feedback.setStaffId(staffId);
            feedback.setAppointmentId(appointmentId);
            feedback.setServiceId(serviceId);
            feedback.setRating(rating);
            feedback.setComment(comment);
            feedback.setFeedbackTime(feedbackTime);

            FeedbackDAO.insertFeedback(feedback);

            // Chuyển hướng về trang profile với thông báo thành công
            response.sendRedirect(request.getContextPath() + "/profile?msg=success");
        } catch (Exception e) {
            e.printStackTrace();
            // Chuyển hướng về profile với thông báo lỗi
            response.sendRedirect(request.getContextPath() + "/profile?msg=error");
        }
    }
}
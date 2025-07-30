package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import babershopDAO.AdviseDAO;
import chatbot.GeminiApiClient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Advise;
import model.ChatMessage;

@WebServlet(name = "ChatServlet", urlPatterns = {"/chat"})
public class ChatServlet extends HttpServlet {
    private static final String GEMINI_API_KEY = "AIzaSyA1CXS2UOmPiXq4MrXssQVeHoAIJ49cT3U";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        request.getRequestDispatcher("/WEB-INF/chat.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String userMessage = request.getParameter("message");
        if (userMessage != null && !userMessage.trim().isEmpty()) {
            HttpSession session = request.getSession();
            List<ChatMessage> chatHistory = (List<ChatMessage>) session.getAttribute("chatHistory");
            if (chatHistory == null) {
                chatHistory = new ArrayList<>();
                session.setAttribute("chatHistory", chatHistory);
            }
            chatHistory.add(new ChatMessage(userMessage, "user"));
            String aiResponse = generateAIResponse(userMessage, chatHistory, request);
            chatHistory.add(new ChatMessage(aiResponse, "ai"));
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"message\": \"" +
                        aiResponse.replace("\"", "\\\"").replace("\n", "\\n") + "\"}");
                return;
            }
        }
        request.getRequestDispatcher("/WEB-INF/chat.jsp").forward(request, response);
    }

    private String generateAIResponse(String userMessage, List<ChatMessage> chatHistory, HttpServletRequest request) {
        try {
            AdviseDAO adviseDAO = new AdviseDAO();
            // Tin nhắn đầu tiên
            // if (chatHistory.size() == 1) {
            //     return "Xin chào! Tôi có thể giúp bạn tư vấn dịch vụ, kiểu tóc, giá cả, ưu đãi... Bạn muốn hỏi gì hôm nay?";
            // }
            // Lời chào
            if (userMessage.toLowerCase().equals("hi") || userMessage.toLowerCase().equals("hello")) {
                return "Chào bạn! Tôi là chatbot của BarberShop. Bạn cần tôi tư vấn gì hôm nay?";
            }
            // Tìm kiếm tư vấn tương đồng nhất (LIKE, không cần giống hoàn toàn)
            List<Advise> advises = adviseDAO.searchAdvises(userMessage);
            if (!advises.isEmpty()) {
                Advise bestMatch = advises.get(0); // Lấy kết quả đầu tiên (tốt nhất)
                StringBuilder response = new StringBuilder();
                response.append(bestMatch.getAnswer());
                if (bestMatch.getImage() != null && !bestMatch.getImage().isEmpty()) {
                    String imagePath = bestMatch.getImage().replace("\\", "/");
                    String imageUrl = request.getContextPath() + "/" + imagePath;
                    response.append("<br><img src='").append(imageUrl).append("' alt='Hình minh họa' style='max-width:150px;'/><br>");
                }
                return response.toString();
            } else {
                // Nếu không tìm thấy, dùng GeminiApiClient để trả lời
                try {
                    GeminiApiClient gemini = new GeminiApiClient(GEMINI_API_KEY);
                    String instruction = "Bạn là một chuyên gia tư vấn về tóc nam. Chỉ trả lời các câu hỏi liên quan đến tóc nam, kiểu tóc nam, chăm sóc tóc nam, dịch vụ cắt tóc nam. Nếu câu hỏi không liên quan, hãy lịch sự từ chối.";
                    String fullPrompt = instruction + "\nCâu hỏi: " + userMessage;
                    String geminiResponse = gemini.generateResponse(fullPrompt);
                    return geminiResponse;
                } catch (Exception ex) {
                    return "Xin lỗi, tôi chưa có thông tin phù hợp và không thể kết nối AI trả lời lúc này.";
                }
            }
        } catch (Exception e) {
            return "Xin lỗi, tôi gặp lỗi khi tìm kiếm thông tin. Bạn có thể thử lại không? Lỗi: " + e.getMessage();
        }
    }
}
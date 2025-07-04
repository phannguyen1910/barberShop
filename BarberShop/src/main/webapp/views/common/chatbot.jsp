<%-- 
    Document   : chatbot
    Created on : Jul 3, 2025, 11:26:57 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/html.css">

<div class="chat-wrapper">
    <!-- Floating Action Button (FAB) for Chat -->
    <div class="chat-fab" id="chat-fab" onclick="toggleChat()">
        <span class="chat-fab-icon bot-fab-anim" style="display: flex; align-items: center; justify-content: center; width: 64px; height: 64px; background: #201E15; border: 2.5px solid #d4af37; border-radius: 50%; box-shadow: 0 4px 16px 0 rgba(212,175,55,0.18);">
            <img class="bot-img-anim" src="${pageContext.request.contextPath}/image/image_logo/bot-icon.png" alt="chatbot" style="width: 44px; height: 44px; object-fit: contain; display: block;" />
        </span>
        <style>
        .bot-fab-anim {
            animation: bot-fab-pulse 1.6s infinite alternate;
        }
        @keyframes bot-fab-pulse {
            0% { box-shadow: 0 4px 16px 0 rgba(212,175,55,0.18); }
            100% { box-shadow: 0 0 32px 6px #ffe06655; }
        }
        .bot-img-anim {
            animation: bot-img-shake 1.2s infinite alternate;
            transform-origin: 50% 60%;
        }
        @keyframes bot-img-shake {
            0% { transform: rotate(-4deg) scale(1); }
            30% { transform: rotate(3deg) scale(1.04); }
            60% { transform: rotate(-2deg) scale(0.98); }
            100% { transform: rotate(2deg) scale(1); }
        }
        </style>
    </div>
    <!-- Chat Container -->
    <div class="chat-container" id="chat-container" style="display:none; background:#fff; border:1.5px solid #e5e7eb; box-shadow:0 8px 32px 0 rgba(0,0,0,0.08),0 1.5px 8px 0 rgba(0,0,0,0.04);">
        <div class="chat-header" onclick="toggleChat()" style="background:#fff; color:#222; border-bottom:1.5px solid #e5e7eb;">
            <span>Cut&Styles Barber</span>
            <div class="chat-icon">💬</div>
        </div>
        <div class="chat-messages" id="chat-messages">
            <c:forEach items="${chatHistory}" var="message">
                <div class="message ${message.sender}-message">
                    <div class="message-content"><c:out value="${message.message}" escapeXml="false"/></div>
                    <div class="timestamp">
                        <fmt:formatDate value="${message.timestamp}" pattern="EEE MMM dd HH:mm:ss z yyyy"/>
                    </div>
                </div>
            </c:forEach>
        </div>
        <form class="chat-input-bar" id="chat-form" action="${pageContext.request.contextPath}/chat" method="post" autocomplete="off" style="display: flex; align-items: center; border: 1.5px solid #e5e7eb; border-radius: 18px; padding: 0 8px; background: #fff; gap: 8px; height: 38px; margin: 8px 10px 8px 10px;">
            <button type="button" tabindex="-1" aria-label="Attach" style="background: none; border: none; color: #3b82fe; display: flex; align-items: center; justify-content: center; padding: 0; width: 28px; height: 28px; cursor: pointer;">
                <svg width="18" height="18" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M7 13.5L14.5 6C15.3284 5.17157 16.6716 5.17157 17.5 6C18.3284 6.82843 18.3284 8.17157 17.5 9L10 16.5C8.34315 18.1569 5.65685 18.1569 4 16.5C2.34315 14.8431 2.34315 12.1569 4 10.5L11.5 3" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
            <input type="text" name="message" id="message-input" placeholder="Type your message here..." required style="flex:1; border:none; outline:none; background:transparent; color:#222; font-size:0.98em; padding:0 6px; height:32px; font-weight:500;" />
            <button type="submit" aria-label="Send" style="background: none; border: none; color: #3b82fe; display: flex; align-items: center; justify-content: center; padding: 0; width: 32px; height: 32px; border-radius: 50%; cursor: pointer;">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M3 17L17 10L3 3V8L13 10L3 12V17Z" fill="currentColor"/>
                </svg>
            </button>
        </form>
        <style>
        .chat-input-bar input::placeholder {
            color: #ffe066;
            opacity: 1;
        }
        .chat-input-bar button:active, .chat-input-bar button:focus {
            outline: none;
        }
        .chat-input-bar button[type="submit"]:hover {
            background: #d4af37;
            color: #201E15;
        }
        .chat-messages {
            display: flex;
            flex-direction: column;
        }
        </style>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const chatMessages = document.getElementById('chat-messages');
    const chatForm = document.getElementById('chat-form');
    const messageInput = document.getElementById('message-input');
    const chatFab = document.getElementById('chat-fab');
    const chatContainer = document.getElementById('chat-container');

    let botGreeted = false;

    chatForm && chatForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const message = messageInput.value.trim();
        if (!message) return;

        appendMessage(message, 'user');
        messageInput.value = '';

        fetch('${pageContext.request.contextPath}/chat', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: 'message=' + encodeURIComponent(message)
        })
        .then(response => response.json())
        .then(data => {
            appendMessage(data.message, 'ai');
        })
        .catch(error => {
            appendMessage('Sorry, something went wrong. Please try again.', 'ai');
        });
    });

    function appendMessage(content, sender) {
        const messageDiv = document.createElement('div');
        if(sender === 'user') {
            messageDiv.className = 'message user-message';
            messageDiv.style.alignSelf = 'flex-end';
        } else {
            messageDiv.className = 'message ai-message';
            messageDiv.style.alignSelf = 'flex-start';
        }

        const contentDiv = document.createElement('div');
        contentDiv.className = 'message-content';
        contentDiv.innerHTML = content;

        const timestampDiv = document.createElement('div');
        timestampDiv.className = 'timestamp';
        const now = new Date();
        timestampDiv.textContent = now.toLocaleString();

        messageDiv.appendChild(contentDiv);
        messageDiv.appendChild(timestampDiv);

        chatMessages.appendChild(messageDiv);
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    // Hiện tin nhắn chào khi mở chat lần đầu
    window.toggleChat = function() {
        const chatFab = document.getElementById('chat-fab');
        const chatContainer = document.getElementById('chat-container');
        if (chatContainer.style.display === 'none' || chatContainer.style.display === '') {
            chatContainer.style.display = 'flex';
            chatFab.style.display = 'none';
            // Nếu chưa có tin nhắn nào thì hiện tin nhắn chào
            if (!botGreeted && chatMessages.children.length === 0) {
                appendMessage('Xin chào! Tôi có thể giúp bạn tư vấn dịch vụ, kiểu tóc, giá cả, ưu đãi... Bạn muốn hỏi gì hôm nay?', 'ai');
                botGreeted = true;
            }
        } else {
            chatContainer.style.display = 'none';
            chatFab.style.display = 'flex';
        }
    }
});
</script>
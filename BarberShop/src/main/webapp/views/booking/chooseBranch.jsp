<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn Chi Nhánh - CUT & STYLES | Premium Barber Services</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/booking.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background-image: url('https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1374&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;
            min-height: 100vh;
            color: #1a1a1a;
            position: relative;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
            z-index: -1;
        }

        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
            min-height: calc(100vh - 80px);
        }

        .header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .main-title {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            font-weight: 700;
            color: #fff;
            margin-bottom: 1rem;
            text-shadow: 3px 3px 6px rgba(0,0,0,0.7);
        }

        .subtitle {
            font-size: 1.2rem;
            color: #f0f0f0;
            font-weight: 300;
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.7);
        }

        .choose-branch-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .choose-branch-container h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            color: #1a1a1a;
            text-align: center;
            margin-bottom: 1rem;
        }

        .choose-branch-container > p {
            text-align: center;
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 2.5rem;
            font-weight: 300;
        }

        .alert {
            background: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            border: 1px solid #f5c6cb;
        }

        .branch-grid-container {
            margin-bottom: 3rem;
        }

        .branch-grid-header {
            background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
            color: #fff;
            padding: 1.5rem;
            font-weight: 600;
            font-size: 1.2rem;
            text-align: center;
            border-radius: 12px 12px 0 0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .branch-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 0 0 12px 12px;
        }

        .branch-card {
            background: #fff;
            border-radius: 12px;
            padding: 1.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid transparent;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
            min-height: 180px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .branch-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #ffd700, #ffed4e);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .branch-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            border-color: #ffd700;
        }

        .branch-card:hover::before {
            transform: scaleX(1);
        }

        .branch-card.selected {
            border-color: #ffd700;
            background: linear-gradient(135deg, #fffdf0 0%, #fff9e6 100%);
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(255, 215, 0, 0.3);
        }

        .branch-card.selected::before {
            transform: scaleX(1);
        }

        .branch-info {
            flex-grow: 1;
        }

        .branch-name {
            font-weight: 700;
            font-size: 1.2rem;
            color: #1a1a1a;
            margin-bottom: 0.8rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .branch-name::before {
            content: '\F1AD';
            font-family: 'Bootstrap Icons';
            color: #ffd700;
            font-size: 1.1rem;
        }

        .branch-address {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: flex-start;
            gap: 0.5rem;
            line-height: 1.4;
        }

        .branch-address::before {
            content: '\F124';
            font-family: 'Bootstrap Icons';
            color: #ffd700;
            margin-top: 0.1rem;
            flex-shrink: 0;
        }

        .branch-city {
            color: #888;
            font-size: 0.9rem;
            font-weight: 300;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .branch-city::before {
            content: '\F3C6';
            font-family: 'Bootstrap Icons';
            color: #ffd700;
        }

        .branch-check-icon {
            position: absolute;
            top: 1rem;
            right: 1rem;
            font-size: 1.5rem;
            color: #ddd;
            transition: all 0.3s ease;
        }

        .branch-card.selected .branch-check-icon {
            color: #ffd700;
            transform: scale(1.3) rotate(360deg);
        }

        .confirm-branch-selection {
            width: 100%;
            background: linear-gradient(135deg, #ffd700 0%, #ffed4e 100%);
            border: none;
            padding: 1.5rem 2rem;
            border-radius: 15px;
            font-size: 1.2rem;
            font-weight: 700;
            color: #1a1a1a;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.8rem;
            box-shadow: 0 8px 25px rgba(255, 215, 0, 0.3);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .confirm-branch-selection:hover:not(:disabled) {
            background: linear-gradient(135deg, #e6c200 0%, #f0d700 100%);
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(255, 215, 0, 0.4);
        }

        .confirm-branch-selection:disabled {
            background: #ccc;
            cursor: not-allowed;
            opacity: 0.6;
            transform: none;
            box-shadow: none;
        }

        .empty-state {
            text-align: center;
            padding: 4rem;
            color: #666;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 12px;
        }

        .empty-state i {
            font-size: 5rem;
            color: #ddd;
            margin-bottom: 1.5rem;
        }

        .empty-state h3 {
            font-size: 1.8rem;
            margin-bottom: 1rem;
            color: #1a1a1a;
        }

        .fade-in {
            animation: fadeInUp 0.8s ease forwards;
            opacity: 0;
            transform: translateY(30px);
        }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .branch-card-enter {
            animation: cardSlideIn 0.6s ease forwards;
            opacity: 0;
            transform: translateY(20px) scale(0.95);
        }

        @keyframes cardSlideIn {
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        /* Footer Styles */
        .footer {
            background: rgba(26, 26, 26, 0.95);
            backdrop-filter: blur(10px);
            color: #fff;
            padding: 3rem 0 1rem;
            margin-top: auto;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }

        .footer-logo {
            height: 60px;
            margin-bottom: 1rem;
        }

        .footer-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #ffd700;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 0.5rem;
        }

        .footer-links a {
            color: #ccc;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: #ffd700;
        }

        .footer-contact p {
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .footer-contact i {
            color: #ffd700;
            width: 16px;
        }

        .footer-bottom {
            text-align: center;
            padding: 1rem;
            border-top: 1px solid #333;
            margin-top: 2rem;
            color: #999;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .branch-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 992px) {
            .branch-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .main-title {
                font-size: 2.5rem;
            }
        }

        @media (max-width: 768px) {
            .branch-grid {
                grid-template-columns: 1fr;
                padding: 1.5rem;
            }
            
            .main-title {
                font-size: 2rem;
            }

            .choose-branch-container {
                padding: 2rem 1.5rem;
            }

            .main-container {
                padding: 1rem;
            }

            .branch-card {
                min-height: 160px;
            }
        }

        @media (max-width: 480px) {
            .choose-branch-container {
                padding: 1.5rem 1rem;
            }
            
            .branch-grid {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <%@ include file="/views/common/navbar.jsp" %>

    <div class="main-container">
        <div class="header">
            <h1 class="main-title">Chọn Chi Nhánh</h1>
            <p class="subtitle">Trải nghiệm dịch vụ chăm sóc nam giới đẳng cấp tại Cut&Styles Barber</p>
        </div>

        <div class="choose-branch-container fade-in">
            <h1>🏪 Chọn Chi Nhánh Của Bạn</h1>
            <p>Vui lòng chọn một chi nhánh để tiếp tục đặt lịch dịch vụ cao cấp của chúng tôi.</p>

            <c:if test="${error != null}">
                <div class="alert" role="alert">
                    ${error}
                </div>
            </c:if>

            <form id="selectBranchForm" action="${pageContext.request.contextPath}/ChooseBranchServlet" method="post">
                <c:choose>
                    <c:when test="${not empty listBranch}">
                        <div class="branch-grid-container">
                            <div class="branch-grid-header">
                                <i class="bi bi-building"></i>
                                <span>Danh Sách Chi Nhánh</span>
                            </div>
                            <div class="branch-grid">
                                <c:forEach var="branch" items="${listBranch}" varStatus="status">
                                    <div class="branch-card branch-card-enter" 
                                         data-branch-id="${branch.id}" 
                                         onclick="selectBranch(this, '${branch.id}', '${branch.name}')"
                                         style="animation-delay: ${status.index * 0.1}s">
                                        
                                        <div class="branch-check-icon">
                                            <i class="bi bi-check-circle-fill"></i>
                                        </div>
                                        
                                        <div class="branch-info">
                                            <div class="branch-name">${branch.name}</div>
                                            <div class="branch-address">${branch.address}</div>
                                            <div class="branch-city">${branch.city}</div>
                                        </div>
                                        
                                        <input type="radio" name="branchId" value="${branch.id}" 
                                               data-branch-name="${branch.name}" style="display: none;">
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="bi bi-building-x"></i>
                            <h3>Không có chi nhánh khả dụng</h3>
                            <p>Hiện tại chưa có chi nhánh nào hoạt động. Vui lòng quay lại sau.</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <input type="hidden" id="selectedBranchIdHidden" name="branchId">
                <input type="hidden" id="selectedBranchNameHidden" name="branchName">
                
                <button type="submit" class="confirm-branch-selection" id="confirmBranchBtn" disabled>
                    <i class="bi bi-arrow-right-circle"></i>
                    <span>Xác nhận Chi Nhánh</span>
                </button>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-container">
            <div>
                <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Cut&Styles Logo" class="footer-logo">
            </div>
            <div>
                <h4 class="footer-title">Liên kết nhanh</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/common/franchise.jsp">Liên hệ nhượng quyền</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/commit/support.jsp">Chính sách cam kết</a></li>
                </ul>
            </div>
            <div>
                <h4 class="footer-title">Thông tin liên hệ</h4>
                <div class="footer-contact">
                    <p><i class="bi bi-geo-alt-fill"></i> Khu đô thị FPT city, Hòa Hải, Ngũ Hành Sơn, Đà Nẵng</p>
                    <p><i class="bi bi-telephone-fill"></i> Liên hệ học nghề tóc: 0774511941</p>
                    <p><i class="bi bi-clock-fill"></i> Giờ phục vụ: Thứ 2 đến Chủ Nhật, 8h30 - 20h30</p>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
        </div>
    </footer>

    <script>
        let selectedBranchId = null;
        let selectedBranchName = null;
        const confirmBranchBtn = document.getElementById('confirmBranchBtn');
        const selectedBranchIdHidden = document.getElementById('selectedBranchIdHidden');
        const selectedBranchNameHidden = document.getElementById('selectedBranchNameHidden');

        function selectBranch(cardElement, branchId, branchName) {
            // Remove 'selected' class from all cards
            document.querySelectorAll('.branch-card').forEach(card => {
                card.classList.remove('selected');
                const radio = card.querySelector('input[type="radio"]');
                if(radio) radio.checked = false;
            });

            // Add 'selected' class to the clicked card
            cardElement.classList.add('selected');
            const radio = cardElement.querySelector('input[type="radio"]');
            if(radio) radio.checked = true;

            selectedBranchId = branchId;
            selectedBranchName = branchName;
            
            // Update hidden fields for form submission
            selectedBranchIdHidden.value = selectedBranchId;
            selectedBranchNameHidden.value = selectedBranchName;

            // Enable confirm button with animation
            confirmBranchBtn.disabled = false;
            confirmBranchBtn.style.transform = 'scale(1.05)';
            setTimeout(() => {
                confirmBranchBtn.style.transform = 'scale(1)';
            }, 200);

            // Add pulse effect to selected card
            cardElement.style.animation = 'pulse 0.6s ease';
            setTimeout(() => {
                cardElement.style.animation = '';
            }, 600);
        }

        // Initialize page
        document.addEventListener('DOMContentLoaded', () => {
            // Disable button by default if no selection
            if (!selectedBranchId) {
                confirmBranchBtn.disabled = true;
            }

            // Add stagger animation to branch cards
            const cards = document.querySelectorAll('.branch-card');
            cards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0) scale(1)';
                }, index * 100);
            });

            // Add animation to container
            setTimeout(() => {
                document.querySelector('.choose-branch-container').style.opacity = '1';
                document.querySelector('.choose-branch-container').style.transform = 'translateY(0)';
            }, 300);
        });

        // Form submission with loading state
        document.getElementById('selectBranchForm').addEventListener('submit', function(e) {
            if (!selectedBranchId) {
                e.preventDefault();
                alert('Vui lòng chọn một chi nhánh trước khi tiếp tục!');
                return;
            }

            // Add loading state
            const btnIcon = confirmBranchBtn.querySelector('i');
            const btnText = confirmBranchBtn.querySelector('span');
            
            btnIcon.className = 'bi bi-arrow-clockwise';
            btnIcon.style.animation = 'spin 1s linear infinite';
            btnText.textContent = 'Đang xử lý...';
            confirmBranchBtn.disabled = true;
        });

        // Add pulse animation for selected state
        const style = document.createElement('style');
        style.textContent = `
            @keyframes pulse {
                0% { transform: scale(1); }
                50% { transform: scale(1.05); }
                100% { transform: scale(1); }
            }
            @keyframes spin {
                from { transform: rotate(0deg); }
                to { transform: rotate(360deg); }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>
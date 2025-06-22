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
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        /* Reset và base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

        /* Main container */
        .main-container {
            padding: 40px 20px;
            min-height: 100vh;
        }

        /* Header section */
        .header {
            text-align: center;
            margin-bottom: 60px;
            padding: 0 20px;
        }

        .main-title {
            font-size: 3.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #2c2c2c 0%, #1a1a1a 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1rem;
            letter-spacing: -2px;
        }

        .subtitle {
            font-size: 1.2rem;
            color: #666;
            margin-bottom: 2rem;
            line-height: 1.6;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Choose branch container */
        .choose-branch-container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 60px 40px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .choose-branch-container h1 {
            color: #2c2c2c;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-align: center;
        }

        .choose-branch-container > p {
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 3rem;
            text-align: center;
            line-height: 1.6;
        }

        /* Branch selection grid */
        .branch-selection-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 3rem;
        }

        /* Branch cards */
        .branch-card-selectable {
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 30px;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            text-align: left;
            position: relative;
            overflow: hidden;
        }

        .branch-card-selectable::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(212, 160, 23, 0.1), transparent);
            transition: left 0.6s;
        }

        .branch-card-selectable:hover::before {
            left: 100%;
        }

        .branch-card-selectable:hover {
            border-color: #d4a017;
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(212, 160, 23, 0.2);
        }

        .branch-card-selectable.selected {
            border-color: #d4a017;
            background: linear-gradient(135deg, #fff9e6 0%, #fff 100%);
            box-shadow: 0 20px 40px rgba(212, 160, 23, 0.3);
            transform: translateY(-5px);
        }

        .branch-card-selectable.selected::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #d4a017, #f4d03f);
        }

        /* Branch info */
        .branch-info {
            position: relative;
            z-index: 2;
        }

        .branch-card-selectable .branch-name {
            font-weight: 700;
            color: #2c2c2c;
            font-size: 1.4rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .branch-card-selectable .branch-name::before {
            content: '🏢';
            font-size: 1.2rem;
        }

        .branch-card-selectable .branch-address {
            font-size: 1rem;
            color: #666;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .branch-card-selectable .branch-address::before {
            content: '📍';
            font-size: 0.9rem;
        }

        .branch-card-selectable .branch-city {
            font-size: 0.9rem;
            color: #d4a017;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .branch-card-selectable .branch-city::before {
            content: '🌆';
            font-size: 0.8rem;
        }

        /* Check icon */
        .branch-check-icon-selectable {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 1.8rem;
            color: #d4a017;
            opacity: 0;
            transform: scale(0.5) rotate(-180deg);
            transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            z-index: 3;
        }

        .branch-card-selectable.selected .branch-check-icon-selectable {
            opacity: 1;
            transform: scale(1) rotate(0deg);
        }

        /* Confirm button */
        .confirm-branch-selection {
            padding: 16px 40px;
            font-size: 1.2rem;
            font-weight: 600;
            background: linear-gradient(135deg, #d4a017 0%, #f4d03f 100%);
            color: white;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: block;
            margin: 0 auto;
            min-width: 250px;
            box-shadow: 0 8px 20px rgba(212, 160, 23, 0.3);
            position: relative;
            overflow: hidden;
        }

        .confirm-branch-selection::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.6s;
        }

        .confirm-branch-selection:hover::before {
            left: 100%;
        }

        .confirm-branch-selection:hover {
            background: linear-gradient(135deg, #b88f14 0%, #d4a017 100%);
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(212, 160, 23, 0.4);
        }

        .confirm-branch-selection:active {
            transform: translateY(0);
            box-shadow: 0 6px 15px rgba(212, 160, 23, 0.3);
        }

        .confirm-branch-selection:disabled {
            background: #ccc;
            cursor: not-allowed;
            opacity: 0.6;
            transform: none;
            box-shadow: none;
        }

        .confirm-branch-selection:disabled:hover {
            background: #ccc;
            transform: none;
            box-shadow: none;
        }

        .confirm-branch-selection:disabled::before {
            display: none;
        }

        /* Alert styles */
        .alert-danger {
            color: #721c24;
            background: linear-gradient(135deg, #f8d7da 0%, #f1c2c7 100%);
            border: 1px solid #f5c6cb;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 4px 10px rgba(114, 28, 36, 0.1);
        }

        .alert-danger::before {
            content: '⚠️';
            font-size: 1.2rem;
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: #ddd;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #666;
        }

        .empty-state p {
            font-size: 1rem;
            color: #999;
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-in {
            animation: fadeIn 0.8s ease-out;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .main-title {
                font-size: 2.5rem;
            }

            .choose-branch-container {
                padding: 40px 20px;
                margin: 20px;
            }

            .branch-selection-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .branch-card-selectable {
                padding: 20px;
            }

            .confirm-branch-selection {
                width: 100%;
                min-width: auto;
            }
        }

        @media (max-width: 480px) {
            .main-title {
                font-size: 2rem;
            }

            .subtitle {
                font-size: 1rem;
            }

            .choose-branch-container h1 {
                font-size: 2rem;
            }

            .branch-card-selectable .branch-name {
                font-size: 1.2rem;
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="header">
            <h1 class="main-title">Chọn Chi Nhánh</h1>
            <p class="subtitle">Trải nghiệm dịch vụ chăm sóc nam giới đẳng cấp tại Cut&Styles Barber</p>
        </div>

        <div class="choose-branch-container fade-in">
            <h1>🏪 Chọn Chi Nhánh Của Bạn</h1>
            <p>Vui lòng chọn một chi nhánh để tiếp tục đặt lịch dịch vụ cao cấp của chúng tôi.</p>

            <c:if test="${error != null}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <form id="selectBranchForm" action="${pageContext.request.contextPath}/ChooseBranchServlet" method="post">
                <div class="branch-selection-grid">
                    <c:choose>
                        <c:when test="${not empty listBranch}">
                            <c:forEach var="branch" items="${listBranch}">
                                <div class="branch-card-selectable" data-branch-id="${branch.id}" 
                                     onclick="selectBranch(this, '${branch.id}', '${branch.name}')">
                                    <div class="branch-info">
                                        <div class="branch-name">${branch.name}</div>
                                        <div class="branch-address">${branch.address}</div>
                                        <div class="branch-city">${branch.city}</div>
                                    </div>
                                    <div class="branch-check-icon-selectable">
                                        <i class="bi bi-check-circle-fill"></i>
                                    </div>
                                    <input type="radio" name="branchId" value="${branch.id}" 
                                           data-branch-name="${branch.name}" style="display: none;">
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="bi bi-building-x"></i>
                                <h3>Không có chi nhánh khả dụng</h3>
                                <p>Hiện tại chưa có chi nhánh nào hoạt động. Vui lòng quay lại sau.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <input type="hidden" id="selectedBranchIdHidden" name="branchId">
                <input type="hidden" id="selectedBranchNameHidden" name="branchName">
                
                <button type="submit" class="confirm-branch-selection" id="confirmBranchBtn" disabled>
                    <i class="bi bi-arrow-right-circle"></i> Xác nhận Chi Nhánh
                </button>
            </form>
        </div>
    </div>

    <script>
        let selectedBranchId = null;
        let selectedBranchName = null;
        const confirmBranchBtn = document.getElementById('confirmBranchBtn');
        const selectedBranchIdHidden = document.getElementById('selectedBranchIdHidden');
        const selectedBranchNameHidden = document.getElementById('selectedBranchNameHidden');

        function selectBranch(cardElement, branchId, branchName) {
            // Remove 'selected' class from all cards
            document.querySelectorAll('.branch-card-selectable').forEach(card => {
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
        }

        // Initialize page
        document.addEventListener('DOMContentLoaded', () => {
            // Disable button by default if no selection
            if (!selectedBranchId) {
                confirmBranchBtn.disabled = true;
            }

            // Add stagger animation to branch cards
            const cards = document.querySelectorAll('.branch-card-selectable');
            cards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
                card.classList.add('fade-in');
            });
        });

        // Form submission with loading state
        document.getElementById('selectBranchForm').addEventListener('submit', function(e) {
            if (!selectedBranchId) {
                e.preventDefault();
                alert('Vui lòng chọn một chi nhánh trước khi tiếp tục!');
                return;
            }

            // Add loading state
            confirmBranchBtn.innerHTML = '<i class="bi bi-arrow-clockwise"></i> Đang xử lý...';
            confirmBranchBtn.disabled = true;
        });
    </script>
</body>
</html>
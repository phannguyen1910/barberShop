<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xác nhận đặt lịch - Cut&Styles Barber</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/booking.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <style>
            .info-section {
                background: #fff;
                border-radius: 12px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            }
            .info-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 1.5rem;
            }
            .info-item {
                display: flex;
                align-items: center;
                padding: 1rem;
                background: #f9f9f9;
                border-radius: 8px;
            }
            .service-item {
                display: flex;
                justify-content: space-between;
                padding: 1rem 0;
                border-bottom: 1px solid #eee;
            }
            .service-name {
                font-weight: 600;
                color: #1a1a1a;
            }
            .service-price {
                font-weight: 700;
                color: #ffd700;
            }
            .voucher-section {
                background: #f9f9f9;
                border-radius: 12px;
                padding: 2rem;
                margin: 2rem 0;
            }
            .voucher-toggle {
                width: 100%;
                background: #ffd700;
                border: none;
                padding: 1rem;
                border-radius: 8px;
                cursor: pointer;
            }
            .voucher-list {
                display: none;
                margin-top: 1rem;
            }
            .voucher-list.show {
                display: block;
            }
            .voucher-item {
                background: #fff;
                border: 1px solid #ddd;
                padding: 1rem;
                margin: 0.5rem 0;
                cursor: pointer;
            }
            .voucher-item.selected {
                background: #e0f7fa;
            }
            .total-section {
                background: #1a1a1a;
                border-radius: 12px;
                padding: 2rem;
            }
            .total-row {
                display: flex;
                justify-content: space-between;
                padding: 1rem 0;
                color: #fff;
            }
            .total-row.final {
                border-top: 2px solid #ffd700;
                padding-top: 1.5rem;
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <%@ include file="/views/common/navbar.jsp" %>

        <!-- Main Content -->
        <div class="main-container">
            <div class="booking-card" style="width: 80%; margin: 0 auto; padding: 2rem;">
                <h1>Xác nhận đặt lịch</h1>
                <p>Vui lòng kiểm tra thông tin và xác nhận đặt lịch của bạn</p>

                <!-- Thông tin đặt lịch -->
                <div class="info-section">
                    <h5>Thông tin đặt lịch</h5>
                    <div class="info-grid">
                        <div class="info-item"><span>Nhân viên:</span> <span>${staffName}</span></div>
                        <div class="info-item"><span>Số người:</span> <span>${numberOfPeople}</span></div>
                        <div class="info-item"><span>Ngày & Giờ:</span> <span>${dateTime}</span></div>
                    </div>
                </div>

                <!-- Danh sách dịch vụ -->
                <div class="info-section">
                    <h5>Dịch vụ đã chọn</h5>
                    <c:choose>
                        <c:when test="${not empty listService}">
                            <c:forEach var="service" items="${listService}">
                                <div class="service-item">
                                    <div>
                                        <div class="service-name">${service.name}</div>
                                    </div>
                                    <div class="service-price">
                                        <fmt:formatNumber value="${service.price * numberOfPeople}" type="number" groupingUsed="true" /> VNĐ
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p>Không có dịch vụ nào được chọn hoặc dữ liệu không tải được.</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Phần voucher -->
                <div class="voucher-section">
                    <button type="button" class="voucher-toggle" onclick="toggleVoucherList()">
                        <i class="bi bi-gift"></i> Sử dụng voucher
                    </button>
                    <div class="voucher-list" id="voucherList">
                        <c:choose>
                            <c:when test="${not empty vouchers}">
                                <c:forEach var="voucher" items="${vouchers}">
                                    <div class="voucher-item" onclick="selectVoucher('${voucher.code}', ${voucher.value})">
                                        <span>${voucher.code} - Giảm ${voucher.value}%</span>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p>Không có voucher nào khả dụng.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Tổng tiền -->
                <div class="total-section">
                    <div class="total-row">
                        <span>Tổng tiền dịch vụ:</span>
                        <span id="originalTotal"><fmt:formatNumber value="${totalMoney}" type="number" groupingUsed="true" /> VNĐ</span>
                    </div>
                    <div class="total-row" id="discountRow" style="display: none;">
                        <span>Giảm giá:</span>
                        <span id="discountAmount">0 VNĐ</span>
                    </div>
                    <div class="total-row final">
                        <span>Tổng thanh toán:</span>
                        <span id="finalTotal"><fmt:formatNumber value="${totalMoney}" type="number" groupingUsed="true" /> VNĐ</span>
                    </div>
                </div>

                <!-- Form đặt lịch -->
                <form action="${pageContext.request.contextPath}/PaymentServlet" method="post" id="bookingForm">
                    <input type="hidden" name="customerId" value="${customerId}">
                    <input type="hidden" name="staffId" value="${param.staffId}">
                    <input type="hidden" name="numberOfPeople" value="${numberOfPeople}">
                    <input type="hidden" name="appointmentDateTime" value="${dateTime}">
                    <input type="hidden" name="finalAmount" id="finalAmountInput" value="${totalMoney}">
                    <input type="hidden" name="voucherCode" id="voucherCodeInput" value="">
                    <div class="booking-actions">
                        <a href="${pageContext.request.contextPath}/views/booking/booking.jsp" class="btn-back">Quay lại</a>
                        <button type="submit" class="btn-booking">Xác nhận đặt lịch</button>
                    </div>
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
        let originalTotal = ${totalMoney};
        let selectedVoucherCode = null;
        let selectedVoucherDiscount = 0;

        function toggleVoucherList() {
            const voucherList = document.getElementById('voucherList');
            voucherList.style.display = voucherList.style.display === 'block' ? 'none' : 'block';
        }

        function selectVoucher(code, discountPercent) {
            selectedVoucherCode = code;
            selectedVoucherDiscount = discountPercent / 100; // Convert to decimal (e.g., 10% -> 0.10)
            document.querySelectorAll('.voucher-item').forEach(item => item.classList.remove('selected'));
            event.target.classList.add('selected');

            updateTotal();
            toggleVoucherList();
        }

        function updateTotal() {
            const discountRow = document.getElementById('discountRow');
            const discountAmount = document.getElementById('discountAmount');
            const finalTotal = document.getElementById('finalTotal');
            const finalAmountInput = document.getElementById('finalAmountInput');
            const voucherCodeInput = document.getElementById('voucherCodeInput');

            if (selectedVoucherDiscount > 0) {
                const discount = originalTotal * selectedVoucherDiscount;
                const finalAmount = originalTotal - discount;
                discountRow.style.display = 'flex';
                discountAmount.textContent = '-' + formatNumber(discount) + ' VNĐ';
                finalTotal.textContent = formatNumber(finalAmount) + ' VNĐ';
                finalAmountInput.value = finalAmount;
                voucherCodeInput.value = selectedVoucherCode;
            } else {
                discountRow.style.display = 'none';
                finalTotal.textContent = formatNumber(originalTotal) + ' VNĐ';
                finalAmountInput.value = originalTotal;
                voucherCodeInput.value = '';
            }
        }

        function formatNumber(num) {
            return new Intl.NumberFormat('vi-VN').format(num);
        }
        </script>
    </body>
</html>
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
            body {
                background: linear-gradient(120deg, #232526 0%, #414345 100%);
                min-height: 100vh;
                font-family: 'Inter', 'Roboto', Arial, sans-serif;
            }
            .main-container {
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px 0;
                background: #fff;
                border-radius: 24px;
                box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.10);
                margin: 32px auto;
                max-width: 900px;
            }
            .booking-card {
                background: transparent;
                border-radius: 20px;
                box-shadow: none;
                border: none;
                width: 100%;
                max-width: 600px;
                padding: 2.5rem 2rem;
                color: #232526;
            }
            .booking-card h1 {
                color: #DAA520;
                font-family: 'Playfair Display', serif;
                font-size: 2.2rem;
                margin-bottom: 0.5rem;
                text-align: center;
                font-weight: 800;
                letter-spacing: 0.5px;
            }
            .booking-card p {
                color: #444;
                text-align: center;
                margin-bottom: 2rem;
                font-weight: 500;
            }
            .info-section, .voucher-section, .total-section {
                background: #fff;
                border-radius: 14px;
                padding: 1.5rem 1.2rem;
                margin-bottom: 1.5rem;
                border: 1.5px solid #FFD700;
                box-shadow: 0 2px 12px rgba(218,165,32,0.08);
            }
            .info-section h5, .voucher-section h5 {
                color: #DAA520;
                font-size: 1.1rem;
                margin-bottom: 1rem;
                font-weight: 700;
                letter-spacing: 0.2px;
            }
            .info-grid {
                display: flex;
                flex-direction: column;
                gap: 0.8rem;
            }
            .info-item {
                display: flex;
                align-items: center;
                justify-content: space-between;
                font-size: 1rem;
                color: #232526;
                padding: 0.5rem 0;
                border-bottom: 1px solid rgba(218,165,32,0.08);
                font-weight: 600;
            }
            .info-item:last-child { border-bottom: none; }
            .service-item {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0.7rem 0;
                border-bottom: 1px solid rgba(218,165,32,0.08);
            }
            .service-item:last-child { border-bottom: none; }
            .service-name {
                font-weight: 700;
                color: #DAA520;
                display: flex;
                align-items: center;
                gap: 8px;
                letter-spacing: 0.1px;
            }
            .service-icon {
                font-size: 1.1rem;
                color: #DAA520;
                font-weight: 700;
            }
            .voucher-toggle {
                width: 100%;
                background: linear-gradient(90deg, #FFD700 60%, #DAA520 100%);
                border: none;
                padding: 0.9rem;
                border-radius: 8px;
                cursor: pointer;
                color: #232526;
                font-weight: 700;
                font-size: 1rem;
                margin-bottom: 0.5rem;
                transition: background 0.2s;
                letter-spacing: 0.2px;
            }
            .voucher-toggle:hover {
                background: linear-gradient(90deg, #DAA520 60%, #FFD700 100%);
            }
            .voucher-list {
                display: none;
                margin-top: 0.5rem;
            }
            .voucher-list.show { display: block; }
            .voucher-item {
                background: rgba(255,255,255,0.08);
                border: 1.5px solid #FFD700;
                color: #DAA520;
                padding: 0.7rem 1rem;
                margin: 0.4rem 0;
                border-radius: 8px;
                cursor: pointer;
                transition: background 0.2s, border 0.2s, color 0.2s;
                font-weight: 700;
                letter-spacing: 0.1px;
            }
            .voucher-item.selected, .voucher-item:hover {
                background: #FFD700;
                color: #232526;
                border: 1.5px solid #FFD700;
            }
            .total-section {
                background: #fff;
                border: 1.5px solid #FFD700;
                color: #232526;
                margin-bottom: 2rem;
                box-shadow: 0 2px 12px rgba(218,165,32,0.08);
            }
            .total-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.7rem 0;
                font-size: 1.1rem;
                font-weight: 700;
                color: #232526;
            }
            .total-row.final {
                border-top: 2px solid #FFD700;
                padding-top: 1.2rem;
                font-size: 1.2rem;
                color: #DAA520;
                font-weight: 800;
            }
            .deposit-section {
                display: flex;
                align-items: center;
                margin-bottom: 1.2rem;
                gap: 0.7rem;
                color: #DAA520;
                font-weight: 700;
            }
            .payment-button {
                width: 100%;
                background: #FFD700;
                color: #232526;
                border: none;
                padding: 1rem;
                border-radius: 25px;
                font-size: 1.1rem;
                font-weight: 800;
                cursor: not-allowed;
                opacity: 0.7;
                transition: background 0.2s, color 0.2s, opacity 0.2s;
                margin-bottom: 0.5rem;
                letter-spacing: 0.2px;
            }
            .payment-button.enabled {
                cursor: pointer;
                opacity: 1;
                background: linear-gradient(90deg, #FFD700 60%, #DAA520 100%);
                color: #232526;
            }
            @media (max-width: 700px) {
                .booking-card { padding: 1.2rem 0.5rem; }
                .main-container { padding: 10px 0; border-radius: 0; }
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <%@ include file="/views/common/navbar.jsp" %>

        <!-- Main Content -->
        <div class="main-container">
            <div class="booking-card">
                <h1>Xác nhận đặt lịch</h1>
                <p>Vui lòng kiểm tra thông tin và xác nhận đặt lịch của bạn</p>

                <!-- Thông tin đặt lịch -->
                <div class="info-section">
                    <h5><i class="bi bi-info-circle-fill"></i> Thông tin đặt lịch</h5>
                    <div class="info-grid">
                        <div class="info-item"><span>Nhân viên:</span> <span>${staffName}</span></div>
                        <div class="info-item"><span>Ngày & Giờ:</span> <span>${dateTime}</span></div>
                    </div>
                </div>

                <!-- Danh sách dịch vụ -->
                <div class="info-section">
                    <h5><i class="bi bi-scissors"></i> Dịch vụ đã chọn</h5>
                    <c:choose>
                        <c:when test="${not empty listService}">
                            <c:forEach var="service" items="${listService}">
                                <div class="service-item">
                                    <div class="service-name">
                                        <i class="service-icon bi bi-scissors"></i>
                                        ${service.name}
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
                    <button type="button" class="voucher-toggle" data-bs-toggle="modal" data-bs-target="#voucherModal">
                        <i class="bi bi-gift"></i> Sử dụng voucher
                    </button>
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
                <form action="ConfirmationServlet" method="post">
                    <input type="hidden" name="customerId" value="${customerId}" />
                    <input type="hidden" name="staffId" value="${staffId}" />
                    <input type="hidden" name="appointmentTime" value="${dateTime}" />
                    <c:forEach var="service" items="${listService}">
                        <input type="hidden" name="serviceIds" value="${service.id}" />
                    </c:forEach>
                    <input type="hidden" name="totalBill" value="${totalMoney}" />

                    <div class="deposit-section">
                        <input type="checkbox" id="depositConfirm" onchange="togglePaymentButton()">
                        <label for="depositConfirm">Vui lòng đặt cọc 50.000đ để xác nhận đặt lịch</label>
                    </div>
                    <button type="submit" id="paymentButton" class="payment-button" disabled>Thanh toán bằng VNPAY</button>
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

        <!-- Modal chọn voucher -->
        <div class="modal fade" id="voucherModal" tabindex="-1" aria-labelledby="voucherModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius:16px;">
              <div class="modal-header" style="background:#fffbe7;">
                <h5 class="modal-title" id="voucherModalLabel" style="color:#DAA520;font-weight:700;">
                  <i class="bi bi-gift"></i> Chọn voucher
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
              </div>
              <div class="modal-body" style="background:#fff;">
                <div id="voucherModalList">
                  <c:choose>
                    <c:when test="${not empty vouchers}">
                      <c:forEach var="voucher" items="${vouchers}">
                        <div class="voucher-item" style="margin-bottom:8px;" onclick="selectVoucherFromModal('${voucher.code}', ${voucher.value}, this)">
                          <span><i class="bi bi-ticket-perforated"></i> ${voucher.code} - Giảm ${voucher.value}%</span>
                        </div>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <p>Không có voucher nào khả dụng.</p>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
            </div>
          </div>
        </div>

        <script>

            let originalTotal = ${totalMoney};
            let selectedVoucherCode = null;
            let selectedVoucherDiscount = 0;

            

            function formatNumber(num) {
                return new Intl.NumberFormat('vi-VN').format(num);
            }

            function togglePaymentButton() {
                const checkbox = document.getElementById('depositConfirm');
                const paymentButton = document.getElementById('paymentButton');
                if (checkbox.checked) {
                    paymentButton.classList.add('enabled');
                    paymentButton.disabled = false;
                } else {
                    paymentButton.classList.remove('enabled');
                    paymentButton.disabled = true;
                }
            }
  

       function selectVoucherFromModal(code, discountPercent, el) {
           selectedVoucherCode = code;
           selectedVoucherDiscount = discountPercent / 100; // Convert to decimal (e.g., 10% -> 0.10)
           // Bỏ chọn các voucher khác
           document.querySelectorAll('#voucherModalList .voucher-item').forEach(item => item.classList.remove('selected'));
           el.classList.add('selected');
           updateTotal();
           // Đóng modal
           var modal = bootstrap.Modal.getInstance(document.getElementById('voucherModal'));
           modal.hide();
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
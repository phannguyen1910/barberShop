<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đặt lịch giữ chỗ - Cut&Styles Barber</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/booking.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <style>
            .staff-selection {
                margin-top: 1rem;
                display: none;
            }

            .staff-grid {
                display: flex;
                gap: 1.5rem;
                overflow-x: auto;
                padding: 1rem 0;
                scrollbar-width: thin;
                justify-content: center;
            }

            .staff-card {
                flex: 0 0 auto;
                width: 225px;
                height: 300px;
                position: relative;
                cursor: pointer;
                border-radius: 15px;
                overflow: hidden;
                /* Enhanced styling */
                transition: all 0.3s ease;
                border: 3px solid transparent;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                transform: scale(1);
            }

            .staff-card:hover {
                transform: scale(1.02);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
            }

            .staff-card.selected {
                border: 3px solid #007bff;
                box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
                transform: scale(1.02);
            }

            .staff-card img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
                transition: filter 0.3s ease;
            }

            .staff-card.selected img {
                filter: brightness(1.1);
            }

            .staff-name {
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100%;
                background: rgba(0, 0, 0, 0.6);
                color: white;
                text-align: center;
                padding: 0.5rem;
                font-size: 1.5rem;
                font-weight: 500;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                transition: all 0.3s ease;
            }

            .staff-radio {
                position: absolute;
                opacity: 0;
                width: 100%;
                height: 100%;
                cursor: pointer;
            }

            .staff-card:hover .staff-name {
                background: rgba(0, 0, 0, 0.8);
            }

            .staff-card.selected .staff-name {
                background: rgba(0, 123, 255, 0.9);
                font-weight: 600;
            }

            /* Check icon for selected staff */
            .staff-check-icon {
                position: absolute;
                top: 10px;
                right: 10px;
                width: 30px;
                height: 30px;
                background: #28a745;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 16px;
                opacity: 0;
                transform: scale(0);
                transition: all 0.3s ease;
                z-index: 10;
            }

            .staff-card.selected .staff-check-icon {
                opacity: 1;
                transform: scale(1);
            }

            /* Pulse animation for selected card */
            .staff-card.selected {
                animation: selectedPulse 2s infinite;
            }

            /* Debug Styles */
            .debug-section {
                margin: 1rem 0;
                padding: 1rem;
                background-color: #f8f9fa;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            @media (max-width: 768px) {
                .staff-grid {
                    justify-content: flex-start;
                }

                .staff-card {
                    width: 180px;
                    height: 240px;
                }

                .staff-name {
                    font-size: 1.2rem;
                }

                .staff-check-icon {
                    width: 25px;
                    height: 25px;
                    font-size: 14px;
                }
            }

            .time-slot.disabled {
                background-color: #ccc;
                cursor: not-allowed;
                opacity: 0.6;
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <%@ include file="/views/common/navbar.jsp" %>
        <!-- Background Image Section -->
        <div class="background-section"></div>

        <!-- Main Content -->
        <div class="main-container">
            <div class="booking-card fade-in">
                <!-- Header -->
                <div class="booking-header">
                    <h1 class="booking-title">Đặt lịch giữ chỗ</h1>
                    <p class="booking-subtitle">Đặt lịch nhanh chóng để trải nghiệm dịch vụ cao cấp tại salon của bạn</p>
                </div>

                <c:if test="${error != null}">
                    <div style="margin-top: 20px" class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>

                <!-- Steps -->
                <div class="steps-container">
                    <!-- Step 1: Choose Number of People -->
                    <div class="step">
                        <div class="step-header">
                            <div class="step-number">1</div>
                            <div class="step-title">Chọn số người</div>
                        </div>
                        <div class="step-content">
                            <button class="btn btn-outline btn-full" id="togglePeopleForm">
                                <i class="bi bi-people"></i>
                                Chọn số người sử dụng dịch vụ
                            </button>
                            <div id="peopleForm" class="people-form" style="display: none;">
                                <div class="form-group">
                                    <label class="form-label" for="numPeople">Số người bạn muốn đặt:</label>
                                    <select id="numPeople" class="form-select">
                                        <option value="1">1 người</option>
                                        <option value="2">2 người</option>
                                        <option value="3">3 người</option>
                                        <option value="4">4 người</option>
                                        <option value="5">5 người</option>
                                        <option value="6">6 người</option>
                                        <option value="7">7 người</option>
                                        <option value="8">8 người</option>
                                        <option value="9">9 người</option>
                                        <option value="10">10 người</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Step 2: Choose Service -->
                    <div class="step">
                        <div class="step-header">
                            <div class="step-number">2</div>
                            <div class="step-title">Chọn dịch vụ</div>
                        </div>
                        <div class="step-content">
                            <div id="serviceList" class="service-list">
                                <c:set var="serviceNamesAttr" value="${requestScope.serviceNames}" />
                                <c:set var="totalPriceAttr" value="${requestScope.totalPrice}" />
                                <c:choose>
                                    <c:when test="${not empty serviceNamesAttr and serviceNamesAttr != ''}">
                                        <h4>Dịch vụ đã chọn:</h4>
                                        <ul>
                                            <c:forTokens var="serviceName" items="${serviceNamesAttr}" delims=",">
                                                <li class="service-item">
                                                    <span class="service-name">${serviceName.trim()}</span>
                                                </li>
                                            </c:forTokens>
                                        </ul>
                                        <p>Tổng tiền: <fmt:formatNumber value="${totalPriceAttr}" type="number" groupingUsed="true" /> VNĐ</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p>Chưa có dịch vụ nào được chọn. Vui lòng chọn dịch vụ từ trang dịch vụ.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <a href="${pageContext.request.contextPath}/ChooseServiceServlet" class="btn btn-secondary btn-full" style="margin-top: 1rem;">
                                <i class="bi bi-scissors"></i>
                                Chọn thêm dịch vụ
                            </a>
                        </div>
                    </div>

                    <!-- Step 3: Choose Date, Time & Stylist -->
                    <div class="step">
                        <div class="step-header">
                            <div class="step-number">3</div>
                            <div class="step-title">Chọn ngày, giờ & stylist</div>
                        </div>
                        <div class="step-content">
                            <div class="datetime-container">
                                <div class="date-picker-row">
                                    <div class="date-input-group">
                                        <i class="bi bi-calendar3"></i>
                                        <input type="date" id="bookingDate" class="date-input" name="appointmentDate">
                                    </div>
                                    <button class="btn btn-weekend" id="weekendBtn" style="display: none;">
                                        <i class="bi bi-calendar2-week"></i>
                                        <span id="dayType"></span>
                                    </button>
                                </div>
                                <button class="btn btn-outline btn-full" id="toggleTimeGrid">
                                    <i class="bi bi-clock"></i>
                                    <span id="toggleTimeText">Xem khung giờ</span>
                                </button>
                                <div class="time-grid" id="timeSlots" style="display: none;"></div>

                                <!-- Staff Selection Form -->
                                <button class="btn btn-outline btn-full" id="toggleStaffSelection" style="margin-top: 1rem;">
                                    <i class="bi bi-person-badge"></i>
                                    <span id="toggleStaffText">Chọn nhân viên</span>
                                </button>
                                <div class="staff-selection" id="staffSelection">
                                    <div class="staff-grid">
                                        <c:if test="${not empty listOfStaff}">
                                            <c:forEach var="staff" items="${listOfStaff}">
                                                <div class="staff-card" data-staff-id="${staff.id}" onclick="selectStaff(this, '${staff.id}')">
                                                    <img src="${pageContext.request.contextPath}/${staff.img}" 
                                                         alt="${staff.firstName} ${staff.lastName}" 
                                                         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/image/default-avatar.jpg';">
                                                    <div class="staff-name">${staff.firstName}</div>
                                                    <div class="staff-check-icon">
                                                        <i class="bi bi-check"></i>
                                                    </div>
                                                    <input type="radio" name="staffId" value="${staff.id}" class="staff-radio">
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty listOfStaff}">
                                            <p>Không có nhân viên nào khả dụng.</p>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Confirm Section -->
                <div class="confirm-section">
                    <button type="button" class="btn btn-primary btn-full pulse" id="confirmBtn" disabled>
                        <i class="bi bi-check-circle"></i>
                        Xác nhận đặt lịch
                    </button>
                </div>
            </div>
        </div>

        <!-- Hidden Form for Submission -->
        <form id="bookingForm" action="${pageContext.request.contextPath}/BookingServlet" method="post">
            <input type="hidden" name="numberOfPeople" id="hiddenNumberOfPeople">
            <input type="hidden" name="appointmentDate" id="hiddenAppointmentDate">
            <input type="hidden" name="appointmentTime" id="hiddenAppointmentTime">
            <input type="hidden" name="customerId" id="hiddenCustomerId" value="${sessionScope.customerId}">
            <input type="hidden" name="staffId" id="hiddenStaffId" value="">
            <!-- Service Names from request attribute -->
            <c:if test="${not empty requestScope.serviceNames and requestScope.serviceNames != ''}">
                <c:forTokens var="serviceName" items="${requestScope.serviceNames}" delims=",">
                    <input type="hidden" name="serviceName" value="${serviceName}">
                </c:forTokens>
            </c:if>
            <input type="hidden" name="totalPrice" id="hiddenTotalPrice" value="${requestScope.totalPrice}">
        </form>

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
            const container = document.getElementById("timeSlots");
            const confirmBtn = document.getElementById("confirmBtn");
            const bookingDate = document.getElementById("bookingDate");
            const weekendBtn = document.getElementById("weekendBtn");
            const dayType = document.getElementById("dayType");
            const togglePeopleForm = document.getElementById("togglePeopleForm");
            const peopleForm = document.getElementById("peopleForm");
            const toggleTimeGrid = document.getElementById("toggleTimeGrid");
            const toggleTimeText = document.getElementById("toggleTimeText");
            const toggleStaffSelection = document.getElementById("toggleStaffSelection");
            const staffSelection = document.getElementById("staffSelection");
            const toggleStaffText = document.getElementById("toggleStaffText");

            const startHour = 8.5; // 8:30 AM
            const endHour = 20.5;  // 8:30 PM

            let selectedTime = null;
            let selectedDate = null;

            // Enhanced staff selection function
            function selectStaff(cardElement, staffId) {
                const allCards = document.querySelectorAll('.staff-card');
                const currentlySelected = cardElement.classList.contains('selected');

                // Remove selection from all cards
                allCards.forEach(card => {
                    card.classList.remove('selected');
                    const radio = card.querySelector('.staff-radio');
                    if (radio)
                        radio.checked = false;
                });

                // Clear hidden field
                document.getElementById('hiddenStaffId').value = '';

                // If card wasn't selected, select it
                if (!currentlySelected) {
                    cardElement.classList.add('selected');
                    const radio = cardElement.querySelector('.staff-radio');
                    if (radio)
                        radio.checked = true;
                    document.getElementById('hiddenStaffId').value = staffId;
                }

                // Update form validation
                checkFormComplete();
            }

            // Set default date to today
            document.addEventListener("DOMContentLoaded", () => {
                const today = new Date().toISOString().split("T")[0];
                bookingDate.value = today;
                selectedDate = today;
                showAvailableTimes(new Date(today));
                checkFormComplete();
            });

            // Set date constraints
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            const maxDate = new Date();
            maxDate.setDate(today.getDate() + 3);
            bookingDate.min = today.toISOString().split("T")[0];
            bookingDate.max = maxDate.toISOString().split("T")[0];

            // Show available times with Vietnam timezone (UTC+7)
            function showAvailableTimes(selectedDate) {
                const vnTimeZone = 'Asia/Ho_Chi_Minh';
                const now = new Date().toLocaleString('en-US', {timeZone: vnTimeZone});
                const currentDate = new Date(now);

                const selectedDateMidnight = new Date(selectedDate);
                selectedDateMidnight.setHours(0, 0, 0, 0);

                const currentMidnight = new Date(currentDate);
                currentMidnight.setHours(0, 0, 0, 0);
                const isToday = selectedDateMidnight.getTime() === currentMidnight.getTime();

                const currentMinutes = isToday ? (currentDate.getHours() * 60 + currentDate.getMinutes()) : 0;

                container.style.display = "grid";
                container.classList.add("expanded");
                toggleTimeText.textContent = "Thu gọn khung giờ";
                container.innerHTML = '';

                for (let hour = Math.floor(startHour); hour <= Math.floor(endHour); hour++) {
                    for (let minute of [0, 30]) {
                        if (hour === Math.floor(startHour) && minute < (startHour % 1) * 60)
                            continue;
                        if (hour === Math.floor(endHour) && minute > (endHour % 1) * 60)
                            continue;

                        const label = hour.toString().padStart(2, '0') + ':' + (minute === 0 ? '00' : '30');
                        const timeValue = hour * 60 + minute;
                        const isEnabled = !isToday || timeValue >= currentMinutes;

                        const btn = document.createElement("button");
                        btn.className = "time-slot" + (isEnabled ? "" : " disabled");
                        btn.innerText = label;
                        if (!isEnabled) {
                            btn.disabled = true;
                        } else {
                            btn.addEventListener("click", () => {
                                document.querySelectorAll(".time-slot").forEach(b => b.classList.remove("selected"));
                                btn.classList.add("selected");
                                selectedTime = label;
                                checkFormComplete();
                            });
                        }

                        container.appendChild(btn);
                    }
                }
            }

            window.addEventListener('DOMContentLoaded', () => {
                fetch('<%=request.getContextPath()%>/api/holiday')
                        .then(response => response.json())
                        .then(holidayList => {
                            const dateInput = document.getElementById("date");
                            if (!dateInput)
                                return;

                            dateInput.addEventListener("change", function () {
                                const selectedDate = this.value;
                                if (holidayList.includes(selectedDate)) {
                                    alert("Ngày bạn chọn là ngày nghỉ. Vui lòng chọn ngày khác.");
                                    this.value = "";
                                }
                            });
                        })
                        .catch(error => console.error("Lỗi khi tải danh sách ngày nghỉ:", error));
            });



            // Check if selections are complete
            function checkFormComplete() {
                const hasSelectedTime = selectedTime !== null;
                const hasSelectedStaff = document.querySelector('input[name="staffId"]:checked') !== null;
                const hasSelectedServices = document.querySelectorAll('input[name="serviceName"]').length > 0;
                const hasSelectedPeople = document.getElementById("numPeople").value !== "";
                const hasSelectedDate = bookingDate.value !== "";

                if (hasSelectedTime && hasSelectedStaff && hasSelectedServices && hasSelectedPeople && hasSelectedDate) {
                    confirmBtn.disabled = false;
                } else {
                    confirmBtn.disabled = true;
                }
            }

            // Date change handler
            bookingDate.addEventListener("change", () => {
                selectedDate = bookingDate.value;
                const selectedDateObj = new Date(bookingDate.value);
                const selectedDateMidnight = new Date(selectedDateObj);
                selectedDateMidnight.setHours(0, 0, 0, 0);

                if (selectedDateMidnight >= today && selectedDateMidnight <= maxDate) {
                    showAvailableTimes(selectedDateObj);
                    checkFormComplete();
                } else {
                    alert("Vui lòng chọn ngày trong phạm vi từ hôm nay đến 3 ngày tới.");
                    bookingDate.value = today.toISOString().split("T")[0];
                    selectedDate = today.toISOString().split("T")[0];
                    showAvailableTimes(new Date(today));
                    checkFormComplete();
                }
            });

            // Toggle people form
            togglePeopleForm.addEventListener("click", () => {
                peopleForm.style.display = peopleForm.style.display === "none" ? "block" : "none";
            });

            // Toggle time grid
            toggleTimeGrid.addEventListener("click", () => {
                if (container.classList.contains("expanded")) {
                    container.classList.remove("expanded");
                    container.style.display = "none";
                    toggleTimeText.textContent = "Xem khung giờ";
                } else if (bookingDate.value) {
                    container.classList.add("expanded");
                    container.style.display = "grid";
                    toggleTimeText.textContent = "Thu gọn khung giờ";
                }
            });

            // Toggle staff selection
            toggleStaffSelection.addEventListener("click", () => {
                staffSelection.style.display = staffSelection.style.display === "none" ? "block" : "none";
                toggleStaffText.textContent = staffSelection.style.display === "block" ? "Ẩn danh sách nhân viên" : "Chọn nhân viên";
            });

            // Update check form when number of people changes
            document.getElementById("numPeople").addEventListener("change", () => {
                checkFormComplete();
            });

            // Confirm booking handler
            confirmBtn.addEventListener("click", (e) => {
                e.preventDefault();

                const form = document.getElementById('bookingForm');
                const selectedStaffId = document.querySelector('input[name="staffId"]:checked')?.value;

                // Set other fields
                document.getElementById('hiddenNumberOfPeople').value = document.getElementById('numPeople').value;
                document.getElementById('hiddenStaffId').value = selectedStaffId || '';
                document.getElementById('hiddenAppointmentDate').value = selectedDate || bookingDate.value;
                document.getElementById('hiddenAppointmentTime').value = selectedTime;

                // Debugging: Log form data to ensure values are set
                console.log('Form Data:');
                console.log('Number of People:', document.getElementById('hiddenNumberOfPeople').value);
                console.log('Appointment Date:', document.getElementById('hiddenAppointmentDate').value);
                console.log('Appointment Time:', document.getElementById('hiddenAppointmentTime').value);
                console.log('Customer ID:', document.getElementById('hiddenCustomerId').value);
                console.log('Staff ID:', document.getElementById('hiddenStaffId').value);
                console.log('Service Names:', Array.from(document.querySelectorAll('input[name="serviceName"]')).map(input => input.value));
                console.log('Total Price:', document.getElementById('hiddenTotalPrice').value);

                // Submit the form to BookingServlet
                form.submit();
            });
        </script>
    </body>
</html>
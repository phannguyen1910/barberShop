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
    </head>
    <body>
        <%@ include file="/views/common/navbar.jsp" %>
        <div class="background-section"></div>

        <div class="main-container">
            <div class="booking-card fade-in">
                <div class="booking-header">
                    <h1 class="booking-title">Đặt lịch giữ chỗ</h1>
                    <p class="booking-subtitle">Đặt lịch nhanh chóng để trải nghiệm dịch vụ cao cấp tại salon của bạn</p>
                </div>

                <c:if test="${error != null}">
                    <div style="margin-top: 20px" class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>

                <div class="steps-container">
                    <div class="step">
                        <div class="step-header">
                            <div class="step-number">1</div>
                            <div class="step-title">Chọn cơ sở</div>
                        </div>
                        <div class="step-content">
                            <%-- Nút này sẽ chuyển hướng sang trang ChooseBranchServlet --%>
                            <a href="${pageContext.request.contextPath}/ChooseBranchServlet" class="btn btn-outline btn-full">
                                <i class="bi bi-building"></i>
                                <span id="toggleBranchText">
                                    <c:choose>
                                        <c:when test="${not empty preSelectedBranchName}">
                                            Đã chọn: ${preSelectedBranchName}
                                        </c:when>
                                        <c:otherwise>
                                            Chọn cơ sở
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </a>
                        </div>
                    </div>

                    <div class="step">
                        <div class="step-header">
                            <div class="step-number">2</div> <%-- Changed from 3 to 2 --%>
                            <div class="step-title">Chọn dịch vụ</div>
                        </div>
                        <div class="step-content">
                            <div id="serviceList" class="service-list">
                                <%-- Lấy serviceNames và totalPrice từ request attribute, đã được BookingServlet cập nhật từ session --%>
                                <c:set var="serviceNamesAttr" value="${requestScope.serviceNames}" />
                                <c:set var="totalPriceAttr" value="${requestScope.totalPrice}" />
                                <c:set var="totalServiceDuration" value="${requestScope.totalServiceDuration}" />
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
                                        <p>Thời gian: <fmt:formatNumber value="${totalServiceDuration}" type="number" /> Phút</p>
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

                    <div class="step">
                        <div class="step-header">
                            <div class="step-number">3</div> <%-- Changed from 4 to 3 --%>
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

                                <button class="btn btn-outline btn-full" id="toggleStaffSelection" style="margin-top: 1rem;">
                                    <i class="bi bi-person-badge"></i>
                                    <span id="toggleStaffText">Chọn nhân viên</span>
                                </button>
                                <div class="staff-selection" id="staffSelection">
                                    <div class="staff-grid" id="staffGrid">
                                        <c:if test="${not empty listOfStaff}">
                                            <c:forEach var="staff" items="${listOfStaff}">
                                                <%-- Thêm data-branch-id vào mỗi thẻ nhân viên --%>
                                                <div class="staff-card" data-staff-id="${staff.id}" data-branch-id="${staff.branchId}" onclick="selectStaff(this, '${staff.id}')" style="display: none;">
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
                                        <div id="noStaffMessage" style="display: none;">
                                            <p>Vui lòng chọn cơ sở trước để xem danh sách nhân viên.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="confirm-section">
                    <button type="button" class="btn btn-primary btn-full pulse" id="confirmBtn" disabled>
                        <i class="bi bi-check-circle"></i>
                        Xác nhận đặt lịch
                    </button>
                </div>
            </div>
        </div>

        <form id="bookingForm" action="${pageContext.request.contextPath}/BookingServlet" method="post">
            <input type="hidden" name="branchId" id="hiddenBranchId" value="${preSelectedBranchId}">
            <input type="hidden" name="appointmentDate" id="hiddenAppointmentDate">
            <input type="hidden" name="appointmentTime" id="hiddenAppointmentTime">
            <input type="hidden" name="customerId" id="hiddenCustomerId" value="${sessionScope.account.id}"> <%-- Lấy account ID từ session --%>
            <input type="hidden" name="staffId" id="hiddenStaffId">
            <%-- Service names và total price sẽ được lấy từ session trong BookingServlet doPost, không cần truyền lại ở đây --%>
        </form>

        <%@ include file="/views/common/footer.jsp" %>

        <script>
    // Biến global để lưu trữ selectedBranchId
    let selectedBranchId = "${preSelectedBranchId}";
    let preSelectedBranchName = "${preSelectedBranchName}";

    // Khi DOM đã sẵn sàng
    document.addEventListener("DOMContentLoaded", () => {
        if (selectedBranchId && selectedBranchId.trim() !== "") {
            filterStaffByBranch(selectedBranchId);
            document.getElementById('toggleBranchText').textContent = `Đã chọn: ${preSelectedBranchName}`;
        } else {
            filterStaffByBranch(null);
        }

        const today = new Date().toISOString().split("T")[0];
        const bookingDateElement = document.getElementById("bookingDate");
        bookingDateElement.value = today;
        selectedDate = today;
        showAvailableTimes(new Date(today), 'init');

        if (selectedBranchId && selectedBranchId.trim() !== "") {
            document.getElementById('staffSelection').style.display = 'block';
            document.getElementById('toggleStaffText').textContent = "Ẩn danh sách nhân viên";
        } else {
            document.getElementById('staffSelection').style.display = 'none';
            document.getElementById('toggleStaffText').textContent = "Chọn nhân viên";
        }

        checkFormComplete();
    });

    // Các hằng số và biến khác
    const container = document.getElementById("timeSlots");
    const confirmBtn = document.getElementById("confirmBtn");
    const bookingDate = document.getElementById("bookingDate");
    const toggleTimeGrid = document.getElementById("toggleTimeGrid");
    const toggleTimeText = document.getElementById("toggleTimeText");
    const toggleStaffSelection = document.getElementById("toggleStaffSelection");
    const staffSelection = document.getElementById("staffSelection");
    const toggleStaffText = document.getElementById("toggleStaffText");

    const startHour = 8.5; // 8:30 AM
    const endHour = 20.5;  // 8:30 PM

    let selectedTime = null;
    let selectedDate = null;
    let totalServiceDuration = Number("${requestScope.totalServiceDuration}" || 0); // phút

    // Hàm lọc nhân viên theo Branch ID
    function filterStaffByBranch(branchId) {
        const allStaffCards = document.querySelectorAll('.staff-card');
        const noStaffMessage = document.getElementById('noStaffMessage');
        let hasVisibleStaff = false;

        allStaffCards.forEach(card => {
            const staffBranchId = card.dataset.branchId;
            if (branchId && staffBranchId === branchId) {
                card.style.display = 'block';
                hasVisibleStaff = true;
            } else {
                card.style.display = 'none';
                if (card.classList.contains('selected')) {
                    card.classList.remove('selected');
                    const radio = card.querySelector('.staff-radio');
                    if (radio) radio.checked = false;
                }
            }
        });

        if (branchId && !hasVisibleStaff) {
            noStaffMessage.style.display = 'block';
            noStaffMessage.innerHTML = '<p>Không có nhân viên nào khả dụng tại cơ sở này.</p>';
        } else if (!branchId) {
            noStaffMessage.style.display = 'block';
            noStaffMessage.innerHTML = '<p>Vui lòng chọn cơ sở trước để xem danh sách nhân viên.</p>';
        } else {
            noStaffMessage.style.display = 'none';
        }
        checkFormComplete();
    }

  
    function clearStaffSelection() {
        const allStaffCards = document.querySelectorAll('.staff-card');
        allStaffCards.forEach(card => {
            card.classList.remove('selected');
            const radio = card.querySelector('.staff-radio');
            if (radio) radio.checked = false;
        });
        document.getElementById('hiddenStaffId').value = '';
        toggleStaffText.textContent = "Chọn nhân viên";
        checkFormComplete();
    }

    // Hàm chọn nhân viên
    function selectStaff(cardElement, staffId) {
        console.log('DEBUG selectStaff CALLED - staffId from card:', staffId);
        const allCards = document.querySelectorAll('.staff-card');
        const currentlySelected = cardElement.classList.contains('selected');

        allCards.forEach(card => {
            card.classList.remove('selected');
            const radio = card.querySelector('.staff-radio');
            if (radio) radio.checked = false;
        });

        document.getElementById('hiddenStaffId').value = '';
        toggleStaffText.textContent = "Chọn nhân viên";

        if (!currentlySelected) {
            cardElement.classList.add('selected');
            const radio = cardElement.querySelector('.staff-radio');
            if (radio) radio.checked = true;
            document.getElementById('hiddenStaffId').value = staffId;
            const staffName = cardElement.querySelector('.staff-name').textContent;
            toggleStaffText.textContent = `Đã chọn: ${staffName}`;
            if (bookingDate.value) {
                showAvailableTimes(new Date(bookingDate.value), 'select staff');
            }
        } else {
            if (bookingDate.value) {
                selectedTime = null;
                showAvailableTimes(new Date(bookingDate.value), 'unselect staff');
            }
        }
        checkFormComplete();
    }

    // Thiết lập ràng buộc ngày
    const todayDateOnly = new Date();
    todayDateOnly.setHours(0, 0, 0, 0);
    const maxDate = new Date(todayDateOnly);
    maxDate.setDate(todayDateOnly.getDate() + 3);
    bookingDate.min = todayDateOnly.toISOString().split("T")[0];
    bookingDate.max = maxDate.toISOString().split("T")[0];

    // Hiển thị khung giờ khả dụng
    async function showAvailableTimes(selectedDateObj, reason = '') {
        const staffId = document.getElementById('hiddenStaffId').value;
        const appointmentDate = document.getElementById('bookingDate').value;

        console.log('=== DEBUG showAvailableTimes ===');
        console.log('Reason:', reason);
        console.log('staffId from hiddenStaffId:', staffId);
        console.log('appointmentDate from bookingDate element:', appointmentDate);

        let occupiedSlots = [];
        if (staffId && staffId.trim() !== '' && !isNaN(staffId) && Number(staffId) > 0) {
            try {
                const contextPath = '${pageContext.request.contextPath}';
                const baseUrl = contextPath + '/StaffAvailabilityServlet';
                const params = new URLSearchParams();
                params.append('staffId', staffId.toString());
                params.append('appointmentDate', appointmentDate.toString());
                const fullUrl = baseUrl + '?' + params.toString();

                const response = await fetch(fullUrl);
                if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                occupiedSlots = await response.json();
            } catch (error) {
                console.error('Error fetching occupied slots:', error);
                occupiedSlots = [];
            }
        } else {
            occupiedSlots = [];
        }

        // Xóa sạch container trước khi tạo mới
        container.innerHTML = '';
        selectedTime = null; // Reset selected time to avoid confusion
        document.querySelectorAll(".time-slot").forEach(b => b.classList.remove("selected"));

        const now = new Date();
        const selectedDateMidnight = new Date(selectedDateObj);
        selectedDateMidnight.setHours(0, 0, 0, 0);
        const currentMidnight = new Date(now);
        currentMidnight.setHours(0, 0, 0, 0);
        const isToday = selectedDateMidnight.getTime() === currentMidnight.getTime();
        const currentMinutesFromMidnight = (now.getHours() * 60 + now.getMinutes());
        const currentMinutesWithGrace = currentMinutesFromMidnight - 1;

        container.style.display = "grid";
        container.classList.add("expanded");
        toggleTimeText.textContent = "Thu gọn khung giờ";

        for (let hour = Math.floor(startHour); hour <= Math.floor(endHour); hour++) {
            for (let minute of [0, 30]) {
                if (hour === Math.floor(startHour) && minute < (startHour % 1) * 60) continue;
                if (hour === Math.floor(endHour) && minute > (endHour % 1) * 60) continue;

                const label = hour.toString().padStart(2, '0') + ':' + (minute === 0 ? '00' : '30');
                const timeValueMinutes = hour * 60 + minute;

                let isDisabled = false;
                let disableReason = '';

                if (isToday && timeValueMinutes < currentMinutesWithGrace) {
                    isDisabled = true;
                    disableReason = 'past';
                }

                if (occupiedSlots.length > 0) {
                    const isOccupied = occupiedSlots.some(slot => {
                        const slotStartMinutes = parseInt(slot.startTime.split(':')[0]) * 60 + parseInt(slot.startTime.split(':')[1]);
                        const slotEndMinutes = parseInt(slot.endTime.split(':')[0]) * 60 + parseInt(slot.endTime.split(':')[1]);
                        return timeValueMinutes >= slotStartMinutes && timeValueMinutes < slotEndMinutes;
                    });
                    if (isOccupied) {
                        isDisabled = true;
                        disableReason = 'occupied';
                    }
                }

                const btn = document.createElement("button");
                btn.className = "time-slot" + (isDisabled ? " disabled" : "");
                btn.innerText = label;

                if (isDisabled) {
                    btn.disabled = true;
                    btn.title = disableReason === 'past' ? 'Thời gian đã trôi qua' : 'Thời gian đã được đặt trước';
                } else {
                    btn.addEventListener("click", () => {
                        document.querySelectorAll(".time-slot").forEach(b => b.classList.remove("selected"));
                        btn.classList.add("selected");
                        selectedTime = label;
                        checkStaffAvailabilityForSelectedTime(label);
                        checkFormComplete();
                    });
                }
                container.appendChild(btn);
            }
        }
        checkFormComplete();
    }

    // Xử lý ngày nghỉ
    window.addEventListener('DOMContentLoaded', () => {
        fetch('${pageContext.request.contextPath}/api/holiday')
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok ' + response.statusText);
                return response.json();
            })
            .then(holidayList => {
                bookingDate.addEventListener("change", function () {
                    const selectedDateValue = this.value;
                    const selectedDateObj = new Date(selectedDateValue);

                    if (holidayList.includes(selectedDateValue)) {
                        alert("Ngày bạn chọn là ngày nghỉ. Vui lòng chọn ngày khác.");
                        this.value = "";
                        selectedDate = null;
                        showAvailableTimes(new Date(), 'change date');
                    } else {
                        selectedDate = selectedDateValue;
                        showAvailableTimes(selectedDateObj, 'change date');
                    }
                    checkFormComplete();
                });
            })
            .catch(error => console.error("Lỗi khi tải danh sách ngày nghỉ:", error));
    });

    // Kiểm tra form hoàn chỉnh
    function checkFormComplete() {
        const hasSelectedBranch = selectedBranchId !== null && selectedBranchId.trim() !== "";
        const hasSelectedTime = selectedTime !== null;
        const hasSelectedStaff = document.querySelector('input[name="staffId"]:checked') !== null;
        const hasSelectedServices = "${requestScope.serviceIds}" !== null && "${requestScope.serviceIds}" !== "[]";
        const hasSelectedDate = bookingDate.value !== "";

        confirmBtn.disabled = !(hasSelectedBranch && hasSelectedTime && hasSelectedStaff && hasSelectedServices && hasSelectedDate);
    }

    // Xử lý sự kiện thay đổi ngày
    bookingDate.addEventListener("change", () => {
        console.log('DEBUG bookingDate changed to:', bookingDate.value);
        const selectedDateValue = bookingDate.value;
        const selectedDateObj = new Date(selectedDateValue);

        selectedTime = null;
        document.querySelectorAll(".time-slot").forEach(b => b.classList.remove("selected"));

        const selectedDateMidnight = new Date(selectedDateObj);
        selectedDateMidnight.setHours(0, 0, 0, 0);

        if (selectedDateMidnight >= todayDateOnly && selectedDateMidnight <= maxDate) {
            selectedDate = selectedDateValue;
            showAvailableTimes(selectedDateObj, 'change date');
        } else {
            alert("Vui lòng chọn ngày trong phạm vi từ hôm nay đến 3 ngày tới.");
            bookingDate.value = todayDateOnly.toISOString().split("T")[0];
            selectedDate = todayDateOnly.toISOString().split("T")[0];
            showAvailableTimes(new Date(todayDateOnly), 'change date');
        }
    });

    // Toggle form khung giờ
    toggleTimeGrid.addEventListener("click", () => {
        if (container.classList.contains("expanded")) {
            container.classList.remove("expanded");
            container.style.display = "none";
            toggleTimeText.textContent = "Xem khung giờ";
        } else if (bookingDate.value) {
            container.classList.add("expanded");
            container.style.display = "grid";
            toggleTimeText.textContent = "Thu gọn khung giờ";
            showAvailableTimes(new Date(bookingDate.value), 'toggle time grid');
        } else {
            alert("Vui lòng chọn ngày trước để xem khung giờ khả dụng");
        }
    });

    // Toggle form chọn nhân viên
    toggleStaffSelection.addEventListener("click", () => {
        staffSelection.style.display = staffSelection.style.display === "none" ? "block" : "none";
        toggleStaffText.textContent = staffSelection.style.display === "block" ? "Ẩn danh sách nhân viên" : "Chọn nhân viên";

        if (staffSelection.style.display === "block") {
            filterStaffByBranch(selectedBranchId);
        } else {
            document.querySelectorAll('.staff-card').forEach(card => card.style.display = 'none');
            document.getElementById('noStaffMessage').style.display = 'block';
            document.getElementById('noStaffMessage').innerHTML = '<p>Vui lòng chọn cơ sở trước để xem danh sách nhân viên.</p>';
        }
    });

    // Thêm event listener cho radio button change
    document.addEventListener('change', function(event) {
        if (event.target.name === 'staffId' && event.target.type === 'radio') {
            const staffId = event.target.value;
            console.log('Staff radio changed to:', staffId);
            document.getElementById('hiddenStaffId').value = staffId;
            selectedTime = null;
            document.querySelectorAll(".time-slot").forEach(b => b.classList.remove("selected"));
            if (bookingDate.value) {
                showAvailableTimes(new Date(bookingDate.value), 'radio change');
            }
        }
    });

    // Xử lý xác nhận đặt lịch
    confirmBtn.addEventListener("click", (e) => {
        e.preventDefault();

        const form = document.getElementById('bookingForm');
        const selectedStaffRadio = document.querySelector('input[name="staffId"]:checked');
        const selectedStaffId = selectedStaffRadio ? selectedStaffRadio.value : '';

        document.getElementById('hiddenBranchId').value = selectedBranchId || '';
        document.getElementById('hiddenStaffId').value = selectedStaffId;
        document.getElementById('hiddenAppointmentDate').value = selectedDate;
        document.getElementById('hiddenAppointmentTime').value = selectedTime;

        console.log('Form Data to be sent to BookingServlet POST:');
        console.log('Branch ID (hidden):', document.getElementById('hiddenBranchId').value);
        console.log('Appointment Date (hidden):', document.getElementById('hiddenAppointmentDate').value);
        console.log('Appointment Time (hidden):', document.getElementById('hiddenAppointmentTime').value);
        console.log('Customer ID (hidden):', document.getElementById('hiddenCustomerId').value);
        console.log('Staff ID (hidden):', document.getElementById('hiddenStaffId').value);

        form.submit();
    });

    // Hàm kiểm tra staff bận khi chọn khung giờ
    async function checkStaffAvailabilityForSelectedTime(selectedLabel) {
        if (!selectedLabel || !totalServiceDuration) return;

        const [hour, minute] = selectedLabel.split(':').map(Number);
        const startDate = new Date(bookingDate.value);
        startDate.setHours(hour, minute, 0, 0);

        const staffCards = document.querySelectorAll('.staff-card');
        for (const card of staffCards) {
            const staffId = card.getAttribute('data-staff-id');
            let isBusy = false;
            try {
                const contextPath = '${pageContext.request.contextPath}';
                const params = new URLSearchParams();
                params.append('staffId', staffId);
                params.append('appointmentDate', bookingDate.value);
                params.append('startTime', selectedLabel);
                params.append('duration', totalServiceDuration);
                const url = contextPath + '/StaffAvailabilityServlet?' + params.toString();
                const res = await fetch(url);
                if (res.ok) {
                    const data = await res.json();
                    isBusy = data.busy;
                }
            } catch (e) {
                isBusy = false;
            }
            if (isBusy) {
                card.classList.add('disabled');
                card.style.pointerEvents = 'none';
                card.style.opacity = 0.5;
            } else {
                card.classList.remove('disabled');
                card.style.pointerEvents = '';
                card.style.opacity = '';
            }
        }
    }
</script>
        <style>
            .staff-card.disabled {
                pointer-events: none;
                opacity: 0.5;
                filter: grayscale(0.7);
            }
        </style>
    </body>
</html>
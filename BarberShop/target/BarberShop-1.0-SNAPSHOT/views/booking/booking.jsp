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
                            <div class="step-number">2</div>
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

                    <div class="step">
                        <div class="step-header">
                            <div class="step-number">3</div>
                            <div class="step-title">Chọn dịch vụ</div>
                        </div>
                        <div class="step-content">
                            <div id="serviceList" class="service-list">
                                <%-- Lấy serviceNames và totalPrice từ request attribute, đã được BookingServlet cập nhật từ session --%>
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

                    <div class="step">
                        <div class="step-header">
                            <div class="step-number">4</div>
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
            <%-- hiddenBranchId sẽ được pre-fill từ requestScope.preSelectedBranchId --%>
            <input type="hidden" name="branchId" id="hiddenBranchId" value="${preSelectedBranchId}">
            <input type="hidden" name="numberOfPeople" id="hiddenNumberOfPeople">
            <input type="hidden" name="appointmentDate" id="hiddenAppointmentDate">
            <input type="hidden" name="appointmentTime" id="hiddenAppointmentTime">
            <input type="hidden" name="customerId" id="hiddenCustomerId" value="${sessionScope.account.id}"> <%-- Lấy account ID từ session --%>
            <input type="hidden" name="staffId" id="hiddenStaffId" value="">
            <%-- Service names và total price sẽ được lấy từ session trong BookingServlet doPost, không cần truyền lại ở đây --%>
            <%-- <c:if test="${not empty requestScope.serviceNames and requestScope.serviceNames != ''}">
                <c:forTokens var="serviceName" items="${requestScope.serviceNames}" delims=",">
                    <input type="hidden" name="serviceName" value="${serviceName}">
                </c:forTokens>
            </c:if>
            <input type="hidden" name="totalPrice" id="hiddenTotalPrice" value="${requestScope.totalPrice}"> --%>
        </form>

        <%@ include file="/views/common/footer.jsp" %>

        <script>
            // Biến global để lưu trữ selectedBranchId
            // Giá trị này được khởi tạo từ request attribute 'preSelectedBranchId'
            let selectedBranchId = "${preSelectedBranchId}";
            let preSelectedBranchName = "${preSelectedBranchName}"; // Get the name as well

            // Khi DOM đã sẵn sàng
            document.addEventListener("DOMContentLoaded", () => {
                // Kiểm tra nếu có chi nhánh đã được chọn trước đó
                if (selectedBranchId && selectedBranchId.trim() !== "") {
                    filterStaffByBranch(selectedBranchId);
                    document.getElementById('toggleBranchText').textContent = `Đã chọn: ${preSelectedBranchName}`;
                } else {
                    filterStaffByBranch(null); // Hide all staff initially
                }

                // Set default date and show available times
                const today = new Date().toISOString().split("T")[0];
                const bookingDateElement = document.getElementById("bookingDate");
                bookingDateElement.value = today;
                selectedDate = today;
                showAvailableTimes(new Date(today));

                // Initialize staff selection visibility based on whether a branch is pre-selected
                if (selectedBranchId && selectedBranchId.trim() !== "") {
                    document.getElementById('staffSelection').style.display = 'block';
                    document.getElementById('toggleStaffText').textContent = "Ẩn danh sách nhân viên";
                } else {
                     document.getElementById('staffSelection').style.display = 'none';
                     document.getElementById('toggleStaffText').textContent = "Chọn nhân viên";
                }

                // Kiểm tra trạng thái form hoàn chỉnh
                checkFormComplete();
            });

            // Các hằng số và biến khác
            const container = document.getElementById("timeSlots");
            const confirmBtn = document.getElementById("confirmBtn");
            const bookingDate = document.getElementById("bookingDate");
            const weekendBtn = document.getElementById("weekendBtn"); // This button still exists but its logic isn't fully in this snippet
            const dayType = document.getElementById("dayType"); // Same as above
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
            // selectedBranchId đã được khai báo và khởi tạo ở trên


            // Hàm lọc nhân viên theo Branch ID
            function filterStaffByBranch(branchId) {
                const allStaffCards = document.querySelectorAll('.staff-card');
                const noStaffMessage = document.getElementById('noStaffMessage');
                let hasVisibleStaff = false;

                allStaffCards.forEach(card => {
                    const staffBranchId = card.dataset.branchId;
                    // So sánh staffBranchId (kiểu string) với branchId (cũng kiểu string)
                    if (branchId && staffBranchId === branchId) {
                        card.style.display = 'block';
                        hasVisibleStaff = true;
                    } else {
                        card.style.display = 'none';
                        // Đảm bảo bỏ chọn nhân viên nếu thẻ của họ bị ẩn đi
                        if (card.classList.contains('selected')) {
                            card.classList.remove('selected');
                            const radio = card.querySelector('.staff-radio');
                            if (radio) radio.checked = false;
                        }
                    }
                });

                // Hiển thị thông báo nếu không có nhân viên hoặc chưa chọn chi nhánh
                if (branchId && !hasVisibleStaff) {
                    noStaffMessage.style.display = 'block';
                    noStaffMessage.innerHTML = '<p>Không có nhân viên nào khả dụng tại cơ sở này.</p>';
                } else if (!branchId) {
                    noStaffMessage.style.display = 'block';
                    noStaffMessage.innerHTML = '<p>Vui lòng chọn cơ sở trước để xem danh sách nhân viên.</p>';
                } else {
                    noStaffMessage.style.display = 'none';
                }
                checkFormComplete(); // Re-check completeness after staff filtering
            }

            // Hàm bỏ chọn nhân viên hiện tại
            function clearStaffSelection() {
                const allStaffCards = document.querySelectorAll('.staff-card');
                allStaffCards.forEach(card => {
                    card.classList.remove('selected');
                    const radio = card.querySelector('.staff-radio');
                    if (radio) radio.checked = false;
                });
                document.getElementById('hiddenStaffId').value = '';
                toggleStaffText.textContent = "Chọn nhân viên";
                checkFormComplete(); // Re-check completeness after clearing staff
            }

            // Hàm chọn nhân viên
            function selectStaff(cardElement, staffId) {
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
                }

                checkFormComplete();
            }

            // Thiết lập ràng buộc ngày
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            const maxDate = new Date();
            maxDate.setDate(today.getDate() + 3);
            bookingDate.min = today.toISOString().split("T")[0];
            bookingDate.max = maxDate.toISOString().split("T")[0];

            // Hiển thị khung giờ khả dụng
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
                selectedTime = null; // Clear selected time when date changes

                for (let hour = Math.floor(startHour); hour <= Math.floor(endHour); hour++) {
                    for (let minute of [0, 30]) {
                        if (hour === Math.floor(startHour) && minute < (startHour % 1) * 60) continue;
                        if (hour === Math.floor(endHour) && minute > (endHour % 1) * 60) continue;

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
                 checkFormComplete(); // Re-check completeness after time slots are rendered
            }

            // Xử lý ngày nghỉ (holiday)
            window.addEventListener('DOMContentLoaded', () => {
                fetch('<%=request.getContextPath()%>/api/holiday')
                    .then(response => response.json())
                    .then(holidayList => {
                        const dateInput = document.getElementById("bookingDate");
                        if (!dateInput) return;

                        dateInput.addEventListener("change", function () {
                            const selectedDateValue = this.value; // Use a different variable name
                            if (holidayList.includes(selectedDateValue)) {
                                alert("Ngày bạn chọn là ngày nghỉ. Vui lòng chọn ngày khác.");
                                this.value = "";
                                selectedDate = null; // Clear selectedDate if it's a holiday
                                showAvailableTimes(new Date()); // Re-render with current date times
                            }
                            checkFormComplete();
                        });
                    })
                    .catch(error => console.error("Lỗi khi tải danh sách ngày nghỉ:", error));
            });

            // Kiểm tra form hoàn chỉnh để bật/tắt nút xác nhận
            function checkFormComplete() {
                // selectedBranchId đã được khởi tạo từ request attribute hoặc giữ nguyên null/empty
                const hasSelectedBranch = selectedBranchId !== null && selectedBranchId.trim() !== "";
                const hasSelectedTime = selectedTime !== null;
                const hasSelectedStaff = document.querySelector('input[name="staffId"]:checked') !== null;
                // Check if serviceNamesAttr (from request scope) is present and not empty
                const hasSelectedServices = "${requestScope.serviceNames}" !== null && "${requestScope.serviceNames}" !== "";
                const hasSelectedPeople = document.getElementById("numPeople").value !== "";
                const hasSelectedDate = bookingDate.value !== "";

                if (hasSelectedBranch && hasSelectedTime && hasSelectedStaff && hasSelectedServices && hasSelectedPeople && hasSelectedDate) {
                    confirmBtn.disabled = false;
                } else {
                    confirmBtn.disabled = true;
                }
            }

            // Xử lý sự kiện thay đổi ngày
            bookingDate.addEventListener("change", () => {
                selectedDate = bookingDate.value;
                const selectedDateObj = new Date(bookingDate.value);
                const selectedDateMidnight = new Date(selectedDateObj);
                selectedDateMidnight.setHours(0, 0, 0, 0);

                if (selectedDateMidnight >= today && selectedDateMidnight <= maxDate) {
                    showAvailableTimes(selectedDateObj);
                } else {
                    alert("Vui lòng chọn ngày trong phạm vi từ hôm nay đến 3 ngày tới.");
                    bookingDate.value = today.toISOString().split("T")[0];
                    selectedDate = today.toISOString().split("T")[0];
                    showAvailableTimes(new Date(today));
                }
            });

            // Toggle form số người
            togglePeopleForm.addEventListener("click", () => {
                peopleForm.style.display = peopleForm.style.display === "none" ? "block" : "none";
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
                    document.getElementById('noStaffMessage').style.display = 'block'; // Show "Please select branch" message
                }
            });

            // Cập nhật khi số người thay đổi
            document.getElementById("numPeople").addEventListener("change", () => {
                checkFormComplete();
            });

            // Xử lý xác nhận đặt lịch (gửi form)
            confirmBtn.addEventListener("click", (e) => {
                e.preventDefault();

                const form = document.getElementById('bookingForm');
                const selectedStaffRadio = document.querySelector('input[name="staffId"]:checked');
                const selectedStaffId = selectedStaffRadio ? selectedStaffRadio.value : '';

                // Gán giá trị vào hidden input
                document.getElementById('hiddenBranchId').value = selectedBranchId || ''; // Now selectedBranchId is updated when coming from ChooseBranchServlet
                document.getElementById('hiddenNumberOfPeople').value = document.getElementById('numPeople').value;
                document.getElementById('hiddenStaffId').value = selectedStaffId; // Ensure staff ID is set
                document.getElementById('hiddenAppointmentDate').value = selectedDate || bookingDate.value;
                document.getElementById('hiddenAppointmentTime').value = selectedTime;
                
                // Do NOT set serviceNames and totalPrice here directly from JSP elements
                // as they are now handled by session in BookingServlet doPost.
                // The current JSP code has them commented out, which is correct.

                console.log('Form Data to be sent to BookingServlet POST:');
                console.log('Branch ID (hidden):', document.getElementById('hiddenBranchId').value);
                console.log('Number of People (hidden):', document.getElementById('hiddenNumberOfPeople').value);
                console.log('Appointment Date (hidden):', document.getElementById('hiddenAppointmentDate').value);
                console.log('Appointment Time (hidden):', document.getElementById('hiddenAppointmentTime').value);
                console.log('Customer ID (hidden):', document.getElementById('hiddenCustomerId').value);
                console.log('Staff ID (hidden):', document.getElementById('hiddenStaffId').value);
                // serviceNames and totalPrice are implicitly handled by session in the backend
                // console.log('Service Names (Implicit via Session):', "N/A - handled by session");
                // console.log('Total Price (Implicit via Session):', "N/A - handled by session");


                form.submit();
            });
        </script>
    </body>
</html>
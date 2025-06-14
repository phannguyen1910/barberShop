let holidays = [];
let staffList = []; // sẽ được fetch từ API
let staffSchedules = {};
let currentDate = new Date();
let currentMonth = currentDate.getMonth();
let currentYear = currentDate.getFullYear();

// Gắn context path (nếu có)
const contextPath = window.location.pathname.split("/")[1] ? `/${window.location.pathname.split("/")[1]}` : "";

// Format lại ngày về yyyy-MM-dd
function formatDate(rawDate) {
    const d = new Date(rawDate);
    return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
}

// Tải danh sách nhân viên từ server
async function fetchStaffList() {
    try {
        const res = await fetch(`${contextPath}/api/staff`);
        staffList = await res.json();
        populateStaffSelect();
    } catch (err) {
        console.error("Lỗi khi tải danh sách nhân viên:", err);
    }
}

// Tải danh sách ngày lễ từ server
async function fetchHolidays() {
    try {
        const res = await fetch(`${contextPath}/api/holidays`);
        holidays = await res.json();
        console.log("Dữ liệu ngày lễ:", holidays); // debug
        renderCalendar();
        renderHolidayList();
        updateInfoCards();
    } catch (err) {
        console.error("Lỗi khi tải danh sách ngày lễ:", err);
    }
    console.log("📅 Dữ liệu ngày lễ:", holidays.map(h => formatDate(h.date)), holidays);


}

// Đảm bảo khi trang load, dữ liệu được gọi theo thứ tự hợp lý
window.addEventListener("DOMContentLoaded", async () => {
    await fetchHolidays();
    await fetchStaffList();
});

// Hiển thị lịch theo tháng và ngày lễ
function renderCalendar() {
    const calendarGrid = document.getElementById('calendarGrid');
    if (!calendarGrid)
        return;

    calendarGrid.innerHTML = '';

    const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
    const firstDay = new Date(currentYear, currentMonth, 1).getDay();

    document.getElementById('monthYear').textContent = `Tháng ${currentMonth + 1}, ${currentYear}`;
    document.getElementById('currentMonthDisplay').textContent = `Tháng ${currentMonth + 1}, ${currentYear}`;

    const weekDays = ['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy'];
    weekDays.forEach(day => {
        const header = document.createElement('div');
        header.className = 'calendar-header';
        header.textContent = day;
        calendarGrid.appendChild(header);
    });

    let lockedCount = 0;

    for (let i = 0; i < firstDay; i++) {
        const pad = document.createElement('div');
        pad.className = 'calendar-day other-month';
        calendarGrid.appendChild(pad);
    }

    for (let day = 1; day <= daysInMonth; day++) {
        const div = document.createElement('div');
        div.className = 'calendar-day';
        div.textContent = day;

        const dateStr = `${currentYear}-${String(currentMonth + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
        const holiday = holidays.find(h => formatDate(h.date) === dateStr);

        if (holiday) {
            if (holiday.status === 'locked')
                lockedCount++;
            div.classList.add(holiday.status === 'locked' ? 'holiday-locked' : 'holiday-unlocked');
            div.setAttribute('aria-label', `${holiday.name} (${holiday.status === 'locked' ? 'Đã khóa' : 'Mở khóa'})`);
            div.title = `${holiday.name} (${holiday.status === 'locked' ? 'Đã khóa' : 'Mở khóa'})`;
        }

// Gán sự kiện click cho mọi ngày trong tháng hiện tại
        div.addEventListener('click', () => {
            document.getElementById('holidayDate').value = dateStr;
            document.getElementById('holidayName').value = holiday ? holiday.name : '';
            document.getElementById('holidayStatus').value = holiday ? holiday.status : 'locked';
            const modal = new bootstrap.Modal(document.getElementById('addHolidayModal'));
            modal.show();
            // Nếu là ngày lễ thì thêm nút xóa
            const deleteButton = document.createElement('button');
            deleteButton.className = 'btn btn-danger';
            deleteButton.innerHTML = '<i class="fas fa-trash-alt"></i> Xóa Ngày Lễ';
            deleteButton.onclick = () => {
                if (confirm('Bạn có chắc chắn muốn xóa ngày lễ này?')) {
                    deleteHoliday(dateStr);
                    modal.hide();
                }
        };
        const modalFooter = document.querySelector('#addHolidayModal .modal-footer');
            const existingDeleteBtn = modalFooter.querySelector('.btn-danger');
            if (existingDeleteBtn) existingDeleteBtn.remove();
            if (holiday) modalFooter.insertBefore(deleteButton, modalFooter.firstChild);
        });

        // Fade-in effect
        div.style.opacity = 0;
        div.style.transition = 'opacity 0.3s';
        calendarGrid.appendChild(div);
        requestAnimationFrame(() => {
            div.style.opacity = 1;
        });

        calendarGrid.appendChild(div);
    }

    const lockedCountElement = document.getElementById('lockedHolidaysCount');
    if (lockedCountElement)
        lockedCountElement.textContent = lockedCount;
}

function previousMonth() {
    currentMonth--;
    if (currentMonth < 0) {
        currentMonth = 11;
        currentYear--;
    }
    renderCalendar();
}

function nextMonth() {
    currentMonth++;
    if (currentMonth > 11) {
        currentMonth = 0;
        currentYear++;
    }
    renderCalendar();
}


// Thêm hoặc cập nhật ngày lễ
async function saveHoliday() {
    const date = document.getElementById('holidayDate').value;
    const name = document.getElementById('holidayName').value;
    const status = document.getElementById('holidayStatus').value;

    if (!date || !name) {
        showToast('Vui lòng nhập đầy đủ thông tin ngày lễ!');
        return;
    }

    const holiday = {date, name, status};

    try {
        await fetch(`${contextPath}/api/holidays`, {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(holiday)
        });

        showToast('Đã lưu ngày lễ thành công!');

        // Reset lại form
        document.getElementById('holidayDate').value = '';
        document.getElementById('holidayName').value = '';
        document.getElementById('holidayStatus').value = 'locked';

        // Ẩn modal
        bootstrap.Modal.getInstance(document.getElementById('addHolidayModal')).hide();

        // Tải lại danh sách
        await fetchHolidays();
        await fetchHolidays();

    } catch (err) {
        console.error("Lỗi khi lưu ngày lễ:", err);
        showToast('Lỗi khi lưu ngày lễ!');
    }
}


// Xoá ngày lễ
async function deleteHoliday(date) {
    try {
        await fetch(`${contextPath}/api/holidays?date=${encodeURIComponent(date)}`, {
            method: 'DELETE'
        });
        showToast('Đã xóa ngày lễ!');
        await fetchHolidays();
    } catch (err) {
        console.error("Lỗi khi xoá ngày lễ:", err);
        showToast('Lỗi khi xoá ngày lễ!');
    }
}

// Tải lịch làm việc của nhân viên từ server
async function loadStaffSchedule() {
    const date = document.getElementById('staffScheduleDate').value;
    const staffId = document.getElementById('staffSelect').value;
    if (!date || !staffId)
        return;

    try {
        const res = await fetch(`${contextPath}/api/staff-schedule?staffId=${staffId}&date=${date}`);
        const data = await res.json();
        staffSchedules[`${staffId}_${date}`] = data;
        renderStaffSchedule(staffId, date);
        updateInfoCards();
    } catch (err) {
        console.error("Lỗi khi tải lịch làm việc:", err);
    }
}

// Gửi lịch làm việc mới lên server
async function saveStaffSchedule(staffId, date) {
    const data = staffSchedules[`${staffId}_${date}`];
    try {
        await fetch(`${contextPath}/api/staff-schedule`, {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({staffId, date, schedules: data})
        });
        showToast('Đã lưu lịch làm việc!');
    } catch (err) {
        console.error("Lỗi khi lưu lịch làm việc:", err);
        showToast('Lỗi khi lưu lịch làm việc!');
    }
}

// Hiển thị lịch làm việc nhân viên
function renderStaffSchedule(staffId, date) {
    const staffScheduleList = document.getElementById('staffScheduleList');
    const schedules = staffSchedules[`${staffId}_${date}`] || [];
    const html = schedules.map(slot => `
        <div class="time-slot ${slot.status}" onclick="toggleSlotStatus(${staffId}, '${date}', '${slot.time}')">
            ${slot.time}
        </div>
    `).join('');
    staffScheduleList.innerHTML = html;
}

function toggleSlotStatus(staffId, date, time) {
    const key = `${staffId}_${date}`;
    const slots = staffSchedules[key];
    const slot = slots.find(s => s.time === time);
    slot.status = slot.status === 'booked' ? 'available' : 'booked';
    renderStaffSchedule(staffId, date);
    updateInfoCards();
}

// Đổ danh sách nhân viên vào select
function populateStaffSelect() {
    const staffSelect = document.getElementById('staffSelect');
    staffSelect.innerHTML = '<option value="">-- Chọn nhân viên --</option>';
    staffList.forEach(staff => {
        const option = document.createElement('option');
        option.value = staff.id;
        option.textContent = staff.name;
        staffSelect.appendChild(option);
    });
}
function showToast(message) {
    const toast = document.getElementById('toastNotification');
    const toastMessage = document.getElementById('toastMessage');
    toastMessage.textContent = message;

    toast.classList.add('show');
    setTimeout(() => {
        toast.classList.remove('show');
    }, 3000);
}


// Gọi khi trang load
document.addEventListener('DOMContentLoaded', () => {
    fetchHolidays();
    fetchStaffList();
    document.getElementById('staffScheduleDate').addEventListener('change', loadStaffSchedule);
    document.getElementById('staffSelect').addEventListener('change', loadStaffSchedule);
});
function renderHolidayList() {
    const container = document.getElementById("holidayList");
    container.innerHTML = "";

    if (holidays.length === 0) {
        container.innerHTML = "<p class='text-light'>Không có ngày lễ nào.</p>";
        return;
    }

    holidays.forEach(h => {
        const item = document.createElement("div");
        item.className = "holiday-item";

        const statusText = h.status === "locked" ? "Đã khóa" : "Đã mở";

        item.innerHTML = `
            <div>
                <strong>${formatDate(h.date)}</strong> - ${h.name} (${statusText})
            </div>
            <button class="btn btn-danger btn-sm" onclick="confirmDeleteHoliday('${h.date}')">
                <i class="fas fa-trash-alt"></i>
            </button>
        `;

        container.appendChild(item);
    });
}
function switchTab(tabName) {
    const tabs = ['holidays', 'staff'];
    tabs.forEach(tab => {
        const btn = document.getElementById(`${tab}Tab`);
        const content = document.getElementById(`${tab}Content`);
        if (tab === tabName) {
            btn.classList.add('active');
            content.classList.add('active');
        } else {
            btn.classList.remove('active');
            content.classList.remove('active');
        }
    });
}

function confirmDeleteHoliday(date) {
    if (confirm("Bạn có chắc chắn muốn xóa ngày lễ này?")) {
        deleteHoliday(date);
    }
}
// Ghi nhớ tab active khi reload
window.addEventListener('beforeunload', () => {
    const activeTab = document.querySelector('.tab-btn.active')?.id;
    if (activeTab)
        localStorage.setItem('activeTab', activeTab);
});

window.addEventListener('DOMContentLoaded', () => {
    const savedTab = localStorage.getItem('activeTab');
    if (savedTab)
        switchTab(savedTab.replace('Tab', ''));
});


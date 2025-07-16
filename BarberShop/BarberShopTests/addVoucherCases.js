const { Builder, By, until } = require('selenium-webdriver');

const BASE_URL = 'http://localhost:8080/Cut_StyleBarber/views/admin/voucherManagement.jsp';

const testCases = [
  // Th1: Tên voucher trống
  {
    name: 'Th1: voucherName trống',
    data: { voucherName: '', code: 'VCODE1', expiryDate: '2025-12-31', value: '10' },
  },
  // Th2: Mã voucher trống
  {
    name: 'Th2: code trống',
    data: { voucherName: 'Voucher Test', code: '', expiryDate: '2025-12-31', value: '10' },
  },
  // Th3: Ngày hết hạn trống
  {
    name: 'Th3: expiryDate trống',
    data: { voucherName: 'Voucher Test', code: 'VCODE2', expiryDate: '', value: '10' },
  },
  // Th4: Giá trị giảm giá trống
  {
    name: 'Th4: value trống',
    data: { voucherName: 'Voucher Test', code: 'VCODE3', expiryDate: '2025-12-31', value: '' },
  },
  // Th5: Giá trị giảm giá vượt quá 100
  {
    name: 'Th5: value > 100',
    data: { voucherName: 'Voucher Test', code: 'VCODE4', expiryDate: '2025-12-31', value: '150' },
  },
  // Th6: Thêm voucher hợp lệ
  {
    name: 'Th6: Thêm voucher hợp lệ',
    data: { voucherName: 'Voucher UI Test', code: 'VCODE5', expiryDate: '2025-12-31', value: '20' },
  },
];


// Hàm sleep tiện dụng
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

(async () => {
  let lastDriver = null;
  for (const tc of testCases) {
    const driver = await new Builder().forBrowser('chrome').build();
    lastDriver = driver;
    try {
      console.log(`\n--- ${tc.name} ---`);
      await driver.get(BASE_URL);
      await sleep(1200);

      // Nhấn nút Thêm voucher
      await driver.findElement(By.css('button[data-bs-target="#addVoucherModal"]')).click();
      await sleep(1000);
      await driver.wait(until.elementLocated(By.id('addVoucherForm')), 5000);
      await sleep(800);

      // Điền thông tin vào form
      await driver.findElement(By.id('addVoucherName')).clear();
      await sleep(500);
      await driver.findElement(By.id('addVoucherName')).sendKeys(tc.data.voucherName);
      await sleep(500);
      await driver.findElement(By.id('addCode')).clear();
      await sleep(500);
      await driver.findElement(By.id('addCode')).sendKeys(tc.data.code);
      await sleep(500);
      await driver.findElement(By.id('addExpiryDate')).clear();
      await sleep(500);
          if (tc.data.expiryDate) {
            await driver.executeScript("document.getElementById('addExpiryDate').value = arguments[0]", tc.data.expiryDate);
            await sleep(500);
      }
      await driver.findElement(By.id('addValue')).clear();
      await sleep(500);
      await driver.findElement(By.id('addValue')).sendKeys(tc.data.value);
      await sleep(700);

      // Gửi form
      await driver.findElement(By.css('#addVoucherForm button[type="submit"]')).click();
      await sleep(2000);

      // Lấy thông báo lỗi (nếu có)
      let alertMsg = '';
      try {
        alertMsg = await driver.findElement(By.css('.alert-danger')).getText();
      } catch (e) {
        alertMsg = '';
      }
      if (alertMsg) {
        console.log('❌ Lỗi:', alertMsg);
      } else {
        // Kiểm tra voucher mới xuất hiện trong bảng nếu là case hợp lệ
        if (tc.name.includes('hợp lệ')) {
          const pageSource = await driver.getPageSource();
          if (pageSource.includes(tc.data.code) && pageSource.includes(tc.data.voucherName)) {
            console.log('✅ Thêm voucher thành công');
          } else {
            console.log('❌ Không tìm thấy voucher mới trong bảng');
          }
        } else {
          console.log('✅ Không có lỗi, có thể đã qua được kiểm tra');
        }
      }
      // Đợi tester nhấn Enter để tiếp tục
      const readline = require('readline');
      const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
      await new Promise(resolve => rl.question('Nhấn Enter để tiếp tục trường hợp tiếp theo...', () => { rl.close(); resolve(); }));
    } finally {
      await driver.quit();
      await sleep(500);
    }
  }
  // Sau khi chạy xong tất cả test, giữ màn hình lại
  if (lastDriver) {
    console.log('\nĐã chạy xong tất cả test. Trình duyệt cuối cùng sẽ giữ lại cho đến khi bạn nhấn Enter để đóng.');
    const driver = await new Builder().forBrowser('chrome').build();
    await driver.get(BASE_URL);
    const readline = require('readline');
    const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
    await new Promise(resolve => rl.question('Nhấn Enter để đóng trình duyệt cuối cùng...', () => { rl.close(); resolve(); }));
    await driver.quit();
  }
})();

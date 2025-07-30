const { Builder, By, until } = require('selenium-webdriver');

const BASE_URL = 'http://localhost:8080/Cut_StyleBarber/views/admin/voucherManagement.jsp';



const editCases = [
  // Th1: Sửa tên voucher thành rỗng
  {
    name: 'Th1: Sửa voucherName thành rỗng',
    newData: { voucherName: '', code: 'EDITVCODE', expiryDate: '2025-12-31', value: '10' },
    expectSuccess: false
  },
  // Th2: Sửa giá trị giảm giá vượt quá 100
  {
    name: 'Th2: Sửa value > 100',
    newData: { voucherName: 'Voucher Edit Test', code: 'EDITVCODE', expiryDate: '2025-12-31', value: '150' },
    expectSuccess: false
  },
  // Th3: Sửa hợp lệ
  {
    name: 'Th3: Sửa hợp lệ',
    newData: { voucherName: 'Voucher Đã Sửa', code: 'EDITVCODE', expiryDate: '2026-01-01', value: '25' },
    expectSuccess: true
  },
];

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}



(async () => {
  let lastDriver = null;
  let currentCode = 'EDITVCODE';
  for (const tc of editCases) {
    const driver = await new Builder().forBrowser('chrome').build();
    lastDriver = driver;
    try {
      console.log(`\n--- ${tc.name} ---`);
      await driver.get(BASE_URL);
      await sleep(1200);
      // Tìm dòng voucher theo code hiện tại
      let voucherRow = null;
      try {
        voucherRow = await driver.findElement(By.xpath(`//td[contains(@class,'voucher-code') and text()='${currentCode}']/parent::tr`));
      } catch (e) {
        voucherRow = null;
      }
      if (!voucherRow) {
        console.log('❌ Không tìm thấy voucher để edit! (Bỏ qua case này)');
        // Đợi tester nhấn Enter để tiếp tục
        const readline = require('readline');
        const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
        await new Promise(resolve => rl.question('Nhấn Enter để tiếp tục trường hợp tiếp theo...', () => { rl.close(); resolve(); }));
        continue;
      } else {
        // Nhấn nút edit (scroll vào giữa và fallback click JS nếu bị chặn)
        const editBtn = await voucherRow.findElement(By.css('button.btn-edit'));
        await driver.executeScript("arguments[0].scrollIntoView({block: 'center'});", editBtn);
        await sleep(300);
        try {
          await editBtn.click();
        } catch (e) {
          await driver.executeScript("arguments[0].click();", editBtn);
        }
        await sleep(1000);
        await driver.wait(until.elementLocated(By.id('editVoucherForm')), 5000);
        await sleep(800);
        // Sửa các trường
        await driver.findElement(By.id('editVoucherName')).clear();
        await sleep(500);
        await driver.findElement(By.id('editVoucherName')).sendKeys(tc.newData.voucherName);
        await sleep(500);
        await driver.findElement(By.id('editCode')).clear();
        await sleep(500);
        await driver.findElement(By.id('editCode')).sendKeys(tc.newData.code);
        await sleep(500);
        await driver.executeScript("document.getElementById('editExpiryDate').value = arguments[0]", tc.newData.expiryDate);
        await sleep(500);
        await driver.findElement(By.id('editValue')).clear();
        await sleep(500);
        await driver.findElement(By.id('editValue')).sendKeys(tc.newData.value);
        await sleep(700);
        // Gửi form
        await driver.findElement(By.css('#editVoucherForm button[type="submit"]')).click();
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
          // Kiểm tra voucher đã được sửa nếu là case hợp lệ
          if (tc.expectSuccess) {
            const pageSource = await driver.getPageSource();
            if (pageSource.includes(tc.newData.voucherName) && pageSource.includes(tc.newData.code)) {
              console.log('✅ Sửa voucher thành công');
              // Nếu sửa thành công, cập nhật code hiện tại cho lần test tiếp theo
              currentCode = tc.newData.code;
            } else {
              console.log('❌ Không tìm thấy voucher đã sửa trong bảng');
            }
          } else {
            console.log('✅ Không có lỗi, có thể đã qua được kiểm tra');
          }
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

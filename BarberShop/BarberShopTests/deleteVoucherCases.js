const { Builder, By, until } = require('selenium-webdriver');

const BASE_URL = 'http://localhost:8080/Cut_StyleBarber/views/admin/voucherManagement.jsp';

const testCases = [
  // Th1: Xóa voucher không tồn tại
  {
    name: 'Th1: Xóa voucher không tồn tại',
    code: 'NOT_EXIST_CODE',
    expectSuccess: false
  },
  // Th2: Xóa voucher hợp lệ (voucher vừa tạo)
  {
    name: 'Th2: Xóa voucher hợp lệ',
    code: 'EDITVCODE', // Voucher này nên tồn tại từ test thêm voucher
    expectSuccess: true
  },
];

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

      // Tìm dòng voucher theo code
      let voucherRow = null;
      try {
        voucherRow = await driver.findElement(By.xpath(`//td[contains(@class,'voucher-code') and text()='${tc.code}']/parent::tr`));
      } catch (e) {
        voucherRow = null;
      }
      if (!voucherRow) {
        console.log('Voucher không tồn tại trên bảng.');
        if (!tc.expectSuccess) {
          console.log('✅ Đúng, không thể xóa voucher không tồn tại.');
        } else {
          console.log('❌ Không tìm thấy voucher cần xóa!');
        }
      } else {
        // Nhấn nút xóa
        const deleteBtn = await voucherRow.findElement(By.css('button.btn-delete'));
        await deleteBtn.click();
        await sleep(800);
        // Xác nhận popup confirm
        try {
          const alert = await driver.switchTo().alert();
          await sleep(800);
          await alert.accept();
          await sleep(2000);
        } catch (e) {
          // Có thể không có alert confirm
        }
        // Kiểm tra voucher đã bị xóa khỏi bảng
        let stillExists = true;
        try {
          await driver.findElement(By.xpath(`//td[contains(@class,'voucher-code') and text()='${tc.code}']`));
          stillExists = true;
        } catch (e) {
          stillExists = false;
        }
        if (!stillExists && tc.expectSuccess) {
          console.log('✅ Xóa voucher thành công, không còn trên bảng.');
        } else if (stillExists && tc.expectSuccess) {
          console.log('❌ Voucher vẫn còn trên bảng, xóa thất bại.');
        } else if (stillExists && !tc.expectSuccess) {
          console.log('✅ Voucher không bị xóa vì không tồn tại.');
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

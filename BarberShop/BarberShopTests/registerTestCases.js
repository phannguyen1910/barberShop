const { Builder, By } = require("selenium-webdriver");

const BASE_URL = "http://localhost:8080/Cut_StyleBarber/views/auth/register.jsp";

const testCases = [
  // Th1: firstName trống
  {
    name: "Th1: firstName trống",
    data: { firstName: "", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "0912345678", password: "Test1234" },
  },
  // Th2: firstName có số
  {
    name: "Th2: firstName có số",
    data: { firstName: "Nguyen123", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "0912345678", password: "Test1234" },
  },
  // Th3: firstName có ký tự đặc biệt
  {
    name: "Th3: firstName có ký tự đặc biệt",
    data: { firstName: "Nguy#en", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "0912345678", password: "Test1234" },
  },
  // Th4: firstName quá ngắn
  {
    name: "Th4: firstName quá ngắn",
    data: { firstName: "A", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "0912345678", password: "Test1234" },
  },
  // Th5: lastName trống
  {
    name: "Th5: lastName trống",
    data: { firstName: "Nguyen", lastName: "", email: `testuser_${Date.now()}@example.com`, phone: "0912345678", password: "Test1234" },
  },
  // Th6: lastName có số
  {
    name: "Th6: lastName có số",
    data: { firstName: "Nguyen", lastName: "Van123", email: `testuser_${Date.now()}@example.com`, phone: "0912345678", password: "Test1234" },
  },
  // Th7: lastName có ký tự đặc biệt
  {
    name: "Th7: lastName có ký tự đặc biệt",
    data: { firstName: "Nguyen", lastName: "Van@A", email: `testuser_${Date.now()}@example.com`, phone: "0912345678", password: "Test1234" },
  },
  // Th8: email trống
  {
    name: "Th8: email trống",
    data: { firstName: "Nguyen", lastName: "Van A", email: "", phone: "0912345678", password: "Test1234" },
  },
  // Th9: email thiếu @
  {
    name: "Th9: email thiếu @",
    data: { firstName: "Nguyen", lastName: "Van A", email: "testuser.example.com", phone: "0912345678", password: "Test1234" },
  },
  // Th10: email thiếu domain
  {
    name: "Th10: email thiếu domain",
    data: { firstName: "Nguyen", lastName: "Van A", email: "testuser@", phone: "0912345678", password: "Test1234" },
  },
  // Th11: email có ký tự đặc biệt sai
  {
    name: "Th11: email có ký tự đặc biệt sai",
    data: { firstName: "Nguyen", lastName: "Van A", email: "test!user@example.com", phone: "0912345678", password: "Test1234" },
  },
  // Th12: phone trống
  {
    name: "Th12: phone trống",
    data: { firstName: "Nguyen", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "", password: "Test1234" },
  },
  // Th13: phone chứa chữ
  {
    name: "Th13: phone chứa chữ",
    data: { firstName: "Nguyen", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "abc123", password: "Test1234" },
  },
  // Th14: phone quá ngắn
  {
    name: "Th14: phone quá ngắn",
    data: { firstName: "Nguyen", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "01234", password: "Test1234" },
  },
  // Th15: phone quá dài
  {
    name: "Th15: phone quá dài",
    data: { firstName: "Nguyen", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "01234567890123", password: "Test1234" },
  },
  // Th16: phone có ký tự đặc biệt
  {
    name: "Th16: phone có ký tự đặc biệt",
    data: { firstName: "Nguyen", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "0123-4567", password: "Test1234" },
  },
  // Th17: password trống
  {
    name: "Th17: password trống",
    data: { firstName: "Nguyen", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "0912345678", password: "" },
  },
  // Th18: password quá ngắn
  {
    name: "Th18: password quá ngắn",
    data: { firstName: "Nguyen", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "0912345678", password: "123" },
  },
  // Th19: password không có chữ in hoa
  {
    name: "Th19: password không có chữ in hoa",
    data: { firstName: "Nguyen", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "0912345678", password: "test1234" },
  },
  // Th20: password không có chữ thường
  {
    name: "Th20: password không có chữ thường",
    data: { firstName: "Nguyen", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "0912345678", password: "TEST1234" },
  },
  // Th21: password không có số
  {
    name: "Th21: password không có số",
    data: { firstName: "Nguyen", lastName: "Van A", email: `testuser_${Date.now()}@example.com`, phone: "0912345678", password: "TestTest" },
  },
];

(async () => {
  for (const tc of testCases) {
    const driver = await new Builder().forBrowser("chrome").build();
    try {
      console.log(`\n--- ${tc.name} ---`);
      await driver.get(BASE_URL);

      // Điền thông tin vào form
      await driver.findElement(By.id("firstName")).clear();
      await driver.findElement(By.id("firstName")).sendKeys(tc.data.firstName);
      await driver.findElement(By.id("lastName")).clear();
      await driver.findElement(By.id("lastName")).sendKeys(tc.data.lastName);
      await driver.findElement(By.id("phone")).clear();
      await driver.findElement(By.id("phone")).sendKeys(tc.data.phone);
      await driver.findElement(By.id("email")).clear();
      await driver.findElement(By.id("email")).sendKeys(tc.data.email);
      await driver.findElement(By.id("password")).clear();
      await driver.findElement(By.id("password")).sendKeys(tc.data.password);
      await driver.findElement(By.id("confirmPassword")).clear();
      await driver.findElement(By.id("confirmPassword")).sendKeys(tc.data.password);

      // Tick checkbox điều khoản nếu có
      const terms = await driver.findElement(By.id("terms"));
      const checked = await terms.isSelected();
      if (!checked) await terms.click();

      // Submit form
      await driver.findElement(By.id("registerBtn")).click();

      // Chờ trang kết quả hiển thị
      await driver.sleep(2000);

      // Lấy thông báo lỗi (nếu có)
      let alertMsg = "";
      try {
        alertMsg = await driver.findElement(By.css(".alert-danger")).getText();
      } catch (e) {
        alertMsg = "";
      }
      if (alertMsg) {
        console.log("❌ Lỗi:", alertMsg);
      } else {
        console.log("✅ Không có lỗi, đăng ký thành công hoặc qua được kiểm tra");
      }
      // Đợi tester nhấn Enter để tiếp tục
      const readline = require('readline');
      const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
      await new Promise(resolve => rl.question("Nhấn Enter để tiếp tục trường hợp tiếp theo...", () => { rl.close(); resolve(); }));
    } finally {
      await driver.quit();
    }
  }
})();

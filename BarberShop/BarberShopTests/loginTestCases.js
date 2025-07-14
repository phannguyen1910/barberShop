const { Builder, By } = require("selenium-webdriver");

const BASE_URL = "http://localhost:8080/Cut_StyleBarber/login.jsp";

const testCases = [
  {
    name: "Th1: Tài khoản trống",
    data: { username: "", password: "Linh1234" },
  },
  {
    name: "Th2: Mật khẩu trống",
    data: { username: "Linh123@gmail.com", password: "" },
  },
  {
    name: "Th3: Email sai mật khẩu đúng",
    data: { username: "Linh@gmail.com", password: "Linh1234" },
  },
  {
    name: "Th4: Email đúng mật khẩu sai",
    data: { username: "Linh123@gmail.com", password: "linh1234" },
  },
  {
    name: "Th5: Email đúng mật khẩu đúng",
    data: { username: "Linh123@gmail.com", password: "Linh1234" },
  },
];

(async () => {
  for (const tc of testCases) {
    const driver = await new Builder().forBrowser("chrome").build();
    try {
      console.log(`\n--- ${tc.name} ---`);
      await driver.get(BASE_URL);

      // Điền thông tin vào form
      await driver.findElement(By.id("username")).clear();
      await driver.findElement(By.id("username")).sendKeys(tc.data.username);
      await driver.findElement(By.id("password")).clear();
      await driver.findElement(By.id("password")).sendKeys(tc.data.password);

      // Submit form
      await driver.findElement(By.id("loginBtn")).click();

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
        console.log(
          "✅ Không có lỗi, đăng nhập thành công hoặc qua được kiểm tra"
        );
      }
      // Đợi tester nhấn Enter để tiếp tục
      const readline = require("readline");
      const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
      });
      await new Promise((resolve) =>
        rl.question("Nhấn Enter để tiếp tục trường hợp tiếp theo...", () => {
          rl.close();
          resolve();
        })
      );
    } finally {
      await driver.quit();
    }
  }
})();

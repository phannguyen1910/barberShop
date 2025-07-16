const { Builder, By } = require("selenium-webdriver");

const BASE_URL = "http://localhost:8080/Cut_StyleBarber/login.jsp";
const HOME_URL = "http://localhost:8080/Cut_StyleBarber/views/common/home.jsp";

(async () => {
  const driver = await new Builder().forBrowser("chrome").build();
  try {
    // Đăng nhập trước
    await driver.get(BASE_URL);
    await driver.findElement(By.id("username")).clear();
    await driver
      .findElement(By.id("username"))
      .sendKeys("kanekitv171@gmail.com"); // Sửa lại tài khoản thực tế
    await driver.findElement(By.id("password")).clear();
    await driver.findElement(By.id("password")).sendKeys("linh1234@"); // Sửa lại mật khẩu thực tế
    await driver.findElement(By.css(".login-btn")).click();

    // Chờ chuyển về trang chủ
    await driver.sleep(2000);
    await driver.get(HOME_URL);

    // Mở dropdown user
    await driver.findElement(By.id("userDropdown")).click();

    // Click vào nút Logout
    await driver.findElement(By.css("a[href$='/logout']")).click();

    // Chờ chuyển trang
    await driver.sleep(2000);

    // Kiểm tra đã logout thành công (nút Đăng nhập xuất hiện)
    let isLoggedOut = false;
    try {
      await driver.findElement(By.css("a[href$='login.jsp']"));
      isLoggedOut = true;
    } catch (e) {
      isLoggedOut = false;
    }

    if (isLoggedOut) {
      console.log(
        "✅ Logout thành công, đã quay về trạng thái chưa đăng nhập."
      );
    } else {
      console.log(
        "❌ Logout thất bại hoặc chưa chuyển về trạng thái chưa đăng nhập."
      );
    }

    // Đợi tester nhấn Enter để đóng trình duyệt
    const readline = require("readline");
    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout,
    });
    await new Promise((resolve) =>
      rl.question("Nhấn Enter để tắt trình duyệt...", () => {
        rl.close();
        resolve();
      })
    );

    await driver.quit();
  } catch (e) {
    console.error(e);
    await driver.quit();
  }
})();

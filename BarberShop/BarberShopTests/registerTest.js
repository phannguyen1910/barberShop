const chai = require("chai");
const expect = chai.expect;
const request = require("supertest");
const { Builder, By } = require("selenium-webdriver");

// Đúng context path của app
const BASE_URL = "http://localhost:8080/Cut_StyleBarber";

async function testRegisterSuccess() {
  const res = await request(BASE_URL)
    .post("/RegisterServlet")
    .type("form")
    .send({
      firstName: "Nguyen",
      lastName: "Van A",
      email: `testuser_${Date.now()}@example.com`,
      phone: "0123456789",
      password: "Test1234",
    });
  console.log("Status:", res.status);
  if (/Register successfully|Đăng ký thành công/i.test(res.text)) {
    console.log("✅ Đăng ký thành công");
  } else {
    console.log("❌ Không thấy thông báo thành công. Nội dung:", res.text);
  }
}

async function testRegisterFail() {
  const res = await request(BASE_URL)
    .post("/RegisterServlet")
    .type("form")
    .send({
      firstName: "",
      lastName: "",
      email: "",
      phone: "",
      password: "",
    });
  console.log("Status:", res.status);
  if (/error|lỗi|invalid|không hợp lệ/i.test(res.text)) {
    console.log("✅ Test lỗi thành công, có thông báo lỗi");
  } else {
    console.log("❌ Không thấy thông báo lỗi. Nội dung:", res.text);
  }
}

(async () => {
  console.log("--- Test đăng ký hợp lệ ---");
  await testRegisterSuccess();
  console.log("\n--- Test đăng ký thiếu dữ liệu ---");
  await testRegisterFail();
})();

(async function testRegister() {
  const driver = await new Builder().forBrowser("chrome").build();

  try {
    // Mở trang đăng ký
    await driver.get(
      "http://localhost:8080/Cut_StyleBarber/views/auth/register.jsp"
    );

    // Điền thông tin vào form
    await driver.findElement(By.id("firstName")).sendKeys("Nguyen");
    await driver.findElement(By.id("lastName")).sendKeys("Van A");
    await driver.findElement(By.id("phone")).sendKeys("0123456789");
    await driver
      .findElement(By.id("email"))
      .sendKeys(`testuser_${Date.now()}@example.com`);
    await driver.findElement(By.id("password")).sendKeys("Test1234");
    await driver.findElement(By.id("confirmPassword")).sendKeys("Test1234");
    await driver.findElement(By.id("terms")).click();

    // Submit form
    await driver.findElement(By.id("registerBtn")).click();

    // Chờ trang kết quả hiển thị
    await driver.sleep(2000);

    // Hiển thị HTML trang kết quả
    const pageSource = await driver.getPageSource();
    console.log(pageSource);

    // Bạn có thể kiểm tra hoặc lưu lại file HTML nếu muốn
  } finally {
    await driver.quit();
  }
})();

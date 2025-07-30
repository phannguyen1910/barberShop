// test/register.test.js

const chai = require("chai");
const expect = chai.expect;
const request = require("supertest");

const app = "http://localhost:8080/Cut_StyleBarber";

describe("Đăng ký khách hàng (Customer Registration)", () => {
  it("nên đăng ký thành công với dữ liệu hợp lệ", async () => {
    const res = await request(app)
      .post("/RegisterServlet") // ✅ sửa lại đúng
      .type("form")
      .send({
        firstName: "Nguyen",
        lastName: "Van A",
        email: `test${Date.now()}@example.com`,
        phoneNumber: "0123456789",
        password: "123456",
      });

    // Vì servlet dùng forward chứ không phải redirect, nên status có thể là 200
    expect(res.status).to.equal(200);
    expect(res.text).to.include("Register successfully");
  });

  it("nên thất bại nếu thiếu dữ liệu", async () => {
    const res = await request(app)
      .post("/RegisterServlet") // ✅ sửa lại đúng
      .type("form")
      .send({
        firstName: "",
        lastName: "",
        email: "",
        phoneNumber: "",
        password: "",
      });

    expect(res.status).to.equal(200); // vẫn trả 200 vì forward tới cùng trang form
    expect(res.text).to.include("error"); // hoặc check thông báo lỗi cụ thể
  });
});

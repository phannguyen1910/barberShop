// Test for add voucher functionality in voucherManagement.jsp
// Using Mocha + Chai + Supertest for API testing
// This test assumes the backend endpoint for adding voucher is /VoucherServlet with POST method

const request = require('supertest');
const expect = require('chai').expect;
const { Builder, By, until } = require('selenium-webdriver');

// Change this to your actual server URL or use localhost if running locally
const serverUrl = 'http://localhost:8080/BarberShop';

describe('Voucher Management - Add Voucher', function() {
    it('should add a new voucher successfully', async function() {
        const newVoucher = {
            action: 'add',
            voucherName: 'Test Voucher',
            code: 'TEST2025',
            expiryDate: '2025-12-31',
            value: 20
        };
        const res = await request(serverUrl)
            .post('/VoucherServlet')
            .type('form')
            .send(newVoucher);
        expect(res.status).to.equal(200);
        expect(res.body).to.have.property('success', true);
        expect(res.body).to.have.property('message');
    });

    it('should fail to add voucher with missing required fields', async function() {
        const incompleteVoucher = {
            action: 'add',
            code: '',
            expiryDate: '',
            value: ''
        };
        const res = await request(serverUrl)
            .post('/VoucherServlet')
            .type('form')
            .send(incompleteVoucher);
        expect(res.status).to.equal(200);
        expect(res.body).to.have.property('success', false);
    });
});

describe('UI Test - Add Voucher', function() {
    this.timeout(30000); // Tăng timeout cho thao tác UI

    let driver;
    before(async () => {
        driver = await new Builder().forBrowser('chrome').build();
    });

    after(async () => {
        await driver.quit();
    });

    it('should add a new voucher via UI', async () => {
        // Truy cập trang quản lý voucher
        await driver.get('http://localhost:8080/BarberShop/views/admin/voucherManagement.jsp');

        // Nhấn nút Thêm voucher
        await driver.findElement(By.css('button[data-bs-target="#addVoucherModal"]')).click();

        // Đợi modal hiện ra
        await driver.wait(until.elementLocated(By.id('addVoucherForm')), 5000);

        // Điền thông tin voucher
        await driver.findElement(By.id('addVoucherName')).sendKeys('Voucher UI Test');
        await driver.findElement(By.id('addCode')).sendKeys('UITEST2025');
        await driver.findElement(By.id('addExpiryDate')).sendKeys('2025-12-31');
        await driver.findElement(By.id('addValue')).sendKeys('15');

        // Gửi form
        await driver.findElement(By.css('#addVoucherForm button[type="submit"]')).click();

        // Đợi reload hoặc thông báo thành công (tùy logic trang)
        await driver.sleep(2000);

        // Kiểm tra voucher mới xuất hiện trong bảng
        const pageSource = await driver.getPageSource();
        expect(pageSource).to.include('UITEST2025');
        expect(pageSource).to.include('Voucher UI Test');
    });
});

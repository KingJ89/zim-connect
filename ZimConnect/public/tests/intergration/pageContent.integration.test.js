const puppeteer = require('puppeteer');

describe('Page Content Integration Test', () => {
    let browser;
    let page;

    beforeAll(async () => {
        browser = await puppeteer.launch();
        page = await browser.newPage();
    });

    afterAll(async () => {
        await browser.close();
    });

    it('should display the correct content on the Home page', async () => {
        await page.goto('file://' + process.cwd() + '/public/index.html');
        const headerText = await page.$eval('h1', (el) => el.textContent);
        expect(headerText).toBe('Welcome to ZimConnect');
    });

    it('should display the correct content on the Contact page', async () => {
        await page.goto('file://' + process.cwd() + '/public/contact.html');
        const headerText = await page.$eval('h1', (el) => el.textContent);
        expect(headerText).toBe('Contact Us');
    });
});

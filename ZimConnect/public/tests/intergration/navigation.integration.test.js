const puppeteer = require('puppeteer');

describe('Navigation Integration Test', () => {
    let browser;
    let page;

    beforeAll(async () => {
        browser = await puppeteer.launch();
        page = await browser.newPage();
    });

    afterAll(async () => {
        await browser.close();
    });

    it('should navigate to the Shop page', async () => {
        await page.goto('file://' + process.cwd() + '/public/index.html');
        await page.click('a[href="shop.html"]');
        await page.waitForNavigation({ waitUntil: 'load' });
        expect(await page.title()).toBe('Shop - ZimConnect');
    });

    it('should navigate to the About page', async () => {
        await page.goto('file://' + process.cwd() + '/public/index.html');
        await page.click('a[href="about.html"]');
        await page.waitForNavigation({ waitUntil: 'load' });
        expect(await page.title()).toBe('About - ZimConnect');
    });
});

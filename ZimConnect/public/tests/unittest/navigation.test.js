/**
 * @jest-environment jsdom
 */

const fs = require('fs');
const path = require('path');

const html = fs.readFileSync(path.resolve(__dirname, '../../public/index.html'), 'utf8');

describe('Navigation Links', () => {
    beforeEach(() => {
        document.documentElement.innerHTML = html.toString();
    });

    it('should navigate to Shop page when Shop link is clicked', () => {
        const shopLink = document.querySelector('a[href="shop.html"]');
        expect(shopLink.getAttribute('href')).toBe('shop.html');
    });

    it('should navigate to About page when About link is clicked', () => {
        const aboutLink = document.querySelector('a[href="about.html"]');
        expect(aboutLink.getAttribute('href')).toBe('about.html');
    });
});

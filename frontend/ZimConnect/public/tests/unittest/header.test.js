/**
 * @jest-environment jsdom
 */

const fs = require('fs');
const path = require('path');

const html = fs.readFileSync(path.resolve(__dirname, '../../public/index.html'), 'utf8');

describe('Header Navigation', () => {
    beforeEach(() => {
        document.documentElement.innerHTML = html.toString();
    });

    it('should have a navigation bar', () => {
        const nav = document.querySelector('nav');
        expect(nav).not.toBeNull();
    });

    it('should have all navigation links', () => {
        const links = document.querySelectorAll('nav ul li a');
        expect(links.length).toBe(6);
        expect(links[0].textContent).toBe('Home');
        expect(links[1].textContent).toBe('Shop');
        expect(links[2].textContent).toBe('About');
        expect(links[3].textContent).toBe('Contact');
        expect(links[4].textContent).toBe('Login');
        expect(links[5].textContent).toBe('Logout');
    });
});

/**
 * @jest-environment jsdom
 */

const fs = require('fs');
const path = require('path');

const html = fs.readFileSync(path.resolve(__dirname, '../../public/index.html'), 'utf8');

describe('Footer Section', () => {
    beforeEach(() => {
        document.documentElement.innerHTML = html.toString();
    });

    it('should have a footer element', () => {
        const footer = document.querySelector('footer');
        expect(footer).not.toBeNull();
    });

    it('should display copyright information', () => {
        const footer = document.querySelector('footer p');
        expect(footer.textContent).toContain('© 2025 ZimConnect');
    });
});

const request = require('supertest');
const express = require('express');

const app = express();
app.get('/', (req, res) => {
    res.send('Welcome to ZimConnect!');
});

describe('GET /', () => {
    it('should return Welcome to ZimConnect!', async () => {
        const res = await request(app).get('/');
        expect(res.statusCode).toBe(200);
        expect(res.text).toBe('Welcome to ZimConnect!');
    });
});

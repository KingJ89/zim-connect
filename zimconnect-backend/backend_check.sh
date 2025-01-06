#!/bin/bash

# Define project directories
BACKEND_DIR="./zimconnect-backend"
FRONTEND_DIR="./zimconnect-frontend"
TEST_DIR="$BACKEND_DIR/tests"
ENV_FILE="$BACKEND_DIR/.env"

# Create necessary directories
mkdir -p $BACKEND_DIR $FRONTEND_DIR $TEST_DIR

# Backend server.js
cat > $BACKEND_DIR/server.js << 'EOF'
const express = require('express');
const mysql = require('mysql2');
const dotenv = require('dotenv');
dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

db.connect((err) => {
    if (err) {
        console.error('Database connection failed:', err);
        process.exit(1);
    }
    console.log('Connected to the database');
});

app.use(express.json());

// Example route
app.get('/', (req, res) => {
    res.send('Welcome to ZimConnect!');
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
EOF

# Backend package.json
cat > $BACKEND_DIR/package.json << 'EOF'
{
  "name": "zimconnect-backend",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "test": "jest"
  },
  "dependencies": {
    "dotenv": "^16.0.0",
    "express": "^4.18.0",
    "mysql2": "^2.3.0"
  },
  "devDependencies": {
    "jest": "^29.0.0",
    "supertest": "^6.0.0"
  }
}
EOF

# .env file
cat > $ENV_FILE << EOF
DB_HOST=localhost
DB_USER=zimconnect
DB_PASSWORD=Jmutewera27
DB_NAME=zimconnect
PORT=3000
EOF

# Unit test example
cat > $TEST_DIR/server.test.js << 'EOF'
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
EOF

# Install dependencies
cd $BACKEND_DIR
npm install

# Instructions
cat << EOF
Setup complete!

To run the backend server:
1. Navigate to $BACKEND_DIR
2. Run 'npm start'

To run tests:
1. Navigate to $BACKEND_DIR
2. Run 'npm test'
EOF


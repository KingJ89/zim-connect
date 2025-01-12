// Load environment variables
require('dotenv').config();

const express = require('express');
const mysql = require('mysql2');
const app = express();
const frontendRoutes = require('./routes/frontend');
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use('/', frontendRoutes);

// Create MySQL connection
const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME
});

// Connect to MySQL database
connection.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL:', err.message);
    process.exit(1);
  }
  console.log('Connected to MySQL database');
});

// Sample route for testing
app.get('/', (req, res) => {
  res.send('ZimConnect Backend is Running!');
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});


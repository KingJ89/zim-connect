const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const productRoutes = require('./routes/productRoutes');
const additiveRoutes = require('./routes/additiveRoutes');
const locationRoutes = require('./routes/locationRoutes');

const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Routes
app.use('/api/products', productRoutes);
app.use('/api/additives', additiveRoutes);
app.use('/api/locations', locationRoutes);

module.exports = app;


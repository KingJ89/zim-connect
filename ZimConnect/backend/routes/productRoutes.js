const express = require('express');
const router = express.Router();
const { trackProduct } = require('../controllers/productController');

// Track a product
router.get('/track', trackProduct);

module.exports = router;

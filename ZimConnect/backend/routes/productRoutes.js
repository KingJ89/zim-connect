const express = require('express');
const router = express.Router();
const { trackProduct } = require('../controllers/productController');

// Track a product
router.get('/track', trackProduct);

module.exports = router;

router.get('/search', (req, res) => {
  const { query } = req.query; // example: /search?query=laptop
  const filteredProducts = products.filter((product) =>
    product.name.toLowerCase().includes(query.toLowerCase())
  );
  res.json(filteredProducts);
});


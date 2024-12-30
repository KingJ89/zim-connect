const db = require('../config/db');

exports.getAllProducts = (req, res) => {
  db.query('SELECT * FROM products', (err, results) => {
    if (err) return res.status(500).json({ error: 'Failed to fetch products' });
    res.status(200).json(results);
  });
};

exports.createProduct = (req, res) => {
  const { name, price, description, stock } = req.body;
  db.query(
    'INSERT INTO products (name, price, description, stock) VALUES (?, ?, ?, ?)',
    [name, price, description, stock],
    (err) => {
      if (err) return res.status(500).json({ error: 'Failed to create product' });
      res.status(201).json({ message: 'Product created successfully' });
    }
  );
};

// More CRUD functions...

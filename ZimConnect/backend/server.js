const express = require('express');
const mongoose = require('mongoose');
const Product = require('./models/Product');

const app = express();
app.use(express.json());

// CRUD Routes

// Create Product
app.post('/products', async (req, res) => {
    const { name, price, description } = req.body;
    const product = new Product({ name, price, description });
    await product.save();
    res.status(201).json(product);
});

// Read Products
app.get('/products', async (req, res) => {
    const products = await Product.find();
    res.json(products);
});

// Update Product
app.put('/products/:id', async (req, res) => {
    const { id } = req.params;
    const { name, price, description } = req.body;
    const product = await Product.findByIdAndUpdate(id, { name, price, description }, { new: true });
    res.json(product);
});

// Delete Product
app.delete('/products/:id', async (req, res) => {
    const { id } = req.params;
    await Product.findByIdAndDelete(id);
    res.status(204).end();
});

// Start Server
const PORT = process.env.PORT || 5000;
mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`)))
    .catch((err) => console.error(err));


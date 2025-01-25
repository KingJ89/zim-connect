const express = require('express');
const mongoose = require('mongoose');
const Product = require('./models/Product');
const port = 3001;
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
const PORT = process.env.PORT || 3001;
mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`)))
    .catch((err) => console.error(err));

const app = express();

// Middleware
app.use(express.json());

// Routes
app.get('/', (req, res) => {
    res.send('ZimConnect Backend Running');
});

// Connect to MongoDB
mongoose
    .connect('mongodb://localhost:27017/zimconnect', { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => {
        console.log('Connected to MongoDB');
    })
    .catch((err) => {
        console.error('MongoDB connection error:', err);
    });

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});


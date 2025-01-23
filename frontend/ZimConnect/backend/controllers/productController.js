const products = [
    { id: 1, name: 'Product 1', status: 'In Stock' },
    { id: 2, name: 'Product 2', status: 'Out of Stock' },
    { id: 3, name: 'Product 3', status: 'Low Stock' }
];

exports.trackProduct = (req, res) => {
    const { name } = req.query;
    const product = products.find(p => p.name.toLowerCase() === name.toLowerCase());
    if (product) {
        res.json({ success: true, status: product.status });
    } else {
        res.json({ success: false, message: 'Product not found.' });
    }
};

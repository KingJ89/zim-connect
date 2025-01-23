document.getElementById('track-product').addEventListener('click', () => {
    const productName = document.getElementById('product-name').value.trim();

    if (!productName) {
        alert('Please enter a product name.');
        return;
    }

    // Mock product data (replace with API integration if needed)
    const products = {
        'Product 1': 'In Stock',
        'Product 2': 'Out of Stock',
        'Product 3': 'Low Stock'
    };

    const result = products[productName] || 'Product not found.';
    document.getElementById('tracker-results').textContent = `${productName}: ${result}`;
});

document.getElementById('track-product').addEventListener('click', async () => {
    const productName = document.getElementById('product-name').value.trim();

    if (!productName) {
        alert('Please enter a product name.');
        return;
    }

    try {
        const response = await fetch(`http://localhost:3000/api/products/track?name=${productName}`);
        const data = await response.json();

        if (data.success) {
            document.getElementById('tracker-results').textContent = `${productName}: ${data.status}`;
        } else {
            document.getElementById('tracker-results').textContent = data.message;
        }
    } catch (error) {
        console.error('Error fetching product data:', error);
    }
});

const apiUrl = 'http://localhost:5000/products'; // Backend API URL

// Fetch and display products
async function fetchProducts() {
    const res = await fetch(apiUrl);
    const products = await res.json();
    const productList = document.getElementById('product-list');
    productList.innerHTML = '';
    products.forEach((product) => {
        const li = document.createElement('li');
        li.innerHTML = `
            ${product.name} - $${product.price}
            <button onclick="deleteProduct('${product._id}')">Delete</button>
            <button onclick="editProduct('${product._id}', '${product.name}', ${product.price}, '${product.description}')">Edit</button>
        `;
        productList.appendChild(li);
    });
}

// Add Product
document.getElementById('product-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    const name = document.getElementById('name').value;
    const price = document.getElementById('price').value;
    const description = document.getElementById('description').value;
    await fetch(apiUrl, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name, price, description }),
    });
    fetchProducts();
});

// Delete Product
async function deleteProduct(id) {
    await fetch(`${apiUrl}/${id}`, { method: 'DELETE' });
    fetchProducts();
}

// Edit Product
async function editProduct(id, name, price, description) {
    const newName = prompt('Edit Name:', name);
    const newPrice = prompt('Edit Price:', price);
    const newDescription = prompt('Edit Description:', description);
    if (newName && newPrice && newDescription) {
        await fetch(`${apiUrl}/${id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ name: newName, price: newPrice, description: newDescription }),
        });
        fetchProducts();
    }
}

// Load products on page load
fetchProducts();


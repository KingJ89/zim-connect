#!/bin/bash

# Define the paths for your files
ROOT_DIR=$(pwd)
JS_FILE="$ROOT_DIR/js/cart.js"
CSS_FILE="$ROOT_DIR/css/styles.css"

# Create or update cart.js
echo "Updating cart.js..."
cat > "$JS_FILE" << 'EOF'
let cart = []; // Local cart storage
const apiUrl = 'http://localhost:5000'; // Backend API endpoint

// Fetch and display cart items
function displayCart() {
    const cartItemsContainer = document.getElementById('cart-items');
    const totalItems = document.getElementById('total-items');
    const totalPrice = document.getElementById('total-price');
    cartItemsContainer.innerHTML = '';

    if (cart.length === 0) {
        cartItemsContainer.innerHTML = '<p>Your cart is empty.</p>';
        totalItems.textContent = 0;
        totalPrice.textContent = '0.00';
        return;
    }

    let total = 0;
    cart.forEach((item, index) => {
        total += item.price * item.quantity;
        const itemDiv = document.createElement('div');
        itemDiv.className = 'cart-item';
        itemDiv.innerHTML = `
            <div class="cart-item-details">
                <p>${item.name}</p>
                <p>Price: $${item.price}</p>
                <p>Quantity: ${item.quantity}</p>
            </div>
            <div class="cart-item-actions">
                <button onclick="increaseQuantity(${index})">+</button>
                <button onclick="decreaseQuantity(${index})">-</button>
                <button onclick="removeFromCart(${index})">Remove</button>
            </div>
        `;
        cartItemsContainer.appendChild(itemDiv);
    });

    totalItems.textContent = cart.reduce((acc, item) => acc + item.quantity, 0);
    totalPrice.textContent = total.toFixed(2);
}

// Add item to cart
function addToCart(id) {
    fetch(`${apiUrl}/products/${id}`)
        .then((res) => res.json())
        .then((product) => {
            const existingItem = cart.find((item) => item.id === id);
            if (existingItem) {
                existingItem.quantity += 1;
            } else {
                cart.push({
                    id: product._id,
                    name: product.name,
                    price: product.price,
                    quantity: 1,
                });
            }
            displayCart();
        })
        .catch((err) => console.error('Error fetching product:', err));
}

// Increase item quantity
function increaseQuantity(index) {
    cart[index].quantity += 1;
    displayCart();
}

// Decrease item quantity
function decreaseQuantity(index) {
    if (cart[index].quantity > 1) {
        cart[index].quantity -= 1;
    } else {
        cart.splice(index, 1); // Remove item if quantity reaches 0
    }
    displayCart();
}

// Remove item from cart
function removeFromCart(index) {
    cart.splice(index, 1);
    displayCart();
}

// Checkout cart
function checkoutCart() {
    if (cart.length === 0) {
        alert('Your cart is empty.');
        return;
    }

    const userEmail = prompt('Enter your email to receive the receipt:');
    if (!userEmail) return;

    fetch(`${apiUrl}/checkout`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ cart, email: userEmail }),
    })
        .then((res) => res.json())
        .then((data) => {
            alert(`Checkout successful! Receipt sent to ${userEmail}`);
            cart = []; // Clear cart after checkout
            displayCart();
        })
        .catch((err) => console.error('Error during checkout:', err));
}

// Fetch related items
function fetchRelatedItems() {
    fetch(`${apiUrl}/products/related`)
        .then((res) => res.json())
        .then((products) => {
            const suggestedProducts = document.getElementById('suggested-products');
            suggestedProducts.innerHTML = '';
            products.forEach((product) => {
                const productDiv = document.createElement('div');
                productDiv.className = 'related-product';
                productDiv.innerHTML = `
                    <p>${product.name}</p>
                    <p>Price: $${product.price}</p>
                    <button onclick="addToCart('${product._id}')">Add to Cart</button>
                `;
                suggestedProducts.appendChild(productDiv);
            });
        })
        .catch((err) => console.error('Error fetching related items:', err));
}

// Initialize cart
document.getElementById('checkout-btn').addEventListener('click', checkoutCart);
displayCart();
fetchRelatedItems();
EOF

echo "cart.js updated successfully."

# Create or update styles.css
echo "Updating styles.css..."
cat > "$CSS_FILE" << 'EOF'
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f9f9f9;
}

header {
    background-color: #4CAF50;
    color: white;
    padding: 10px 20px;
}

header .logo {
    font-size: 24px;
    font-weight: bold;
}

header nav ul {
    list-style-type: none;
    padding: 0;
}

header nav ul li {
    display: inline;
    margin: 0 10px;
}

#cart-section, #related-items {
    padding: 20px;
    background: white;
    margin: 20px auto;
    max-width: 800px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.cart-item, .related-product {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 10px 0;
}

.cart-item-actions button {
    margin: 0 5px;
    padding: 5px 10px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.cart-item-actions button:hover {
    background-color: #45a049;
}
EOF

echo "styles.css updated successfully."

# Notify the user
echo "All updates have been applied successfully!"


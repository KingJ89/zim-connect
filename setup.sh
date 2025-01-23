#!/bin/bash

# Create a directory for the ZimConnect project
mkdir -p ZimConnect && cd ZimConnect

# Create necessary folders
mkdir -p css js images

# Create the main HTML file
cat << 'EOF' > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ZimConnect Frontend</title>
    <link rel="stylesheet" href="css/styles.css">
    <script src="js/scripts.js" defer></script>
</head>

<body>
    <header>
        <div class="logo">ZimConnect</div>
        <nav>
            <ul>
                <li><a href="#">Home</a></li>
                <li><a href="#shop">Shop</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
                <li><a href="#login" id="login-btn">Login</a></li>
                <li><a href="#logout" id="logout-btn" style="display:none;">Logout</a></li>
            </ul>
        </nav>
        <div class="theme-toggle">
            <button id="toggle-darkmode">Dark Mode</button>
        </div>
        <div class="currency-switcher">
            <label for="currency">Currency:</label>
            <select id="currency">
                <option value="ZAR" selected>ZAR</option>
                <option value="USD">USD</option>
            </select>
        </div>
    </header>

    <main>
        <section id="shop">
            <h1>Welcome to ZimConnect</h1>
            <div class="products">
                <div class="product-item">
                    <img src="images/product1.jpg" alt="Product 1">
                    <h2>Product 1</h2>
                    <p class="price">R100.00</p>
                    <button onclick="addToCart('Product 1', 100)">Add to Cart</button>
                </div>
                <div class="product-item">
                    <img src="images/product2.jpg" alt="Product 2">
                    <h2>Product 2</h2>
                    <p class="price">R150.00</p>
                    <button onclick="addToCart('Product 2', 150)">Add to Cart</button>
                </div>
            </div>
        </section>

        <section id="cart">
            <h2>Shopping Cart</h2>
            <div id="cart-items"></div>
            <button id="checkout" onclick="checkout()">Checkout</button>
        </section>

        <section id="map">
            <h2>Find Us</h2>
            <div id="google-map" style="width: 100%; height: 400px;"></div>
        </section>
    </main>

    <footer>
        <p>&copy; 2025 ZimConnect. All rights reserved.</p>
    </footer>
</body>
</html>
EOF

# Create a basic CSS file
cat << 'EOF' > css/style.css
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}
header {
    background-color: #333;
    color: #fff;
    padding: 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
header a {
    color: #fff;
    text-decoration: none;
    margin: 0 10px;
}
.products {
    display: flex;
    gap: 20px;
    padding: 20px;
}
.product-item {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: center;
}
EOF

# Create a basic JavaScript file
cat << 'EOF' > js/scripts.js
let cart = [];

function addToCart(product, price) {
    cart.push({ product, price });
    updateCartUI();
}

function updateCartUI() {
    const cartItemsDiv = document.getElementById('cart-items');
    cartItemsDiv.innerHTML = cart.map(item => `<p>${item.product}: R${item.price}</p>`).join('');
}

function checkout() {
    if (cart.length === 0) {
        alert('Cart is empty!');
    } else {
        alert('Checkout successful!');
        cart = [];
        updateCartUI();
    }
}

// Toggle dark mode
document.getElementById('toggle-darkmode').addEventListener('click', () => {
    document.body.classList.toggle('darkmode');
});
EOF

# Initialize a Node.js project and install Express
npm init -y
npm install express

# Create the server file
cat << 'EOF' > server.js
const express = require('express');
const app = express();
const PORT = 3000;

app.use(express.static('frontend'));

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
EOF

# Print instructions
echo "Setup complete!"
echo "Run the following commands to start your server:"
echo "1. cd ZimConnect"
echo "2. node server.js"
echo "Visit http://localhost:3000 in your browser to view the app."


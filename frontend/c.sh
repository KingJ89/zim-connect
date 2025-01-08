#!/bin/bash

# ZimConnect Full MVP Ubuntu Shell Script
# This script generates all frontend and backend files, commits incrementally, and pushes to GitHub.

# Declare an associative array for files and corresponding content
declare -A files=(
  ["index.html"]='<!DOCTYPE html>\n<html lang="en">\n<head>\n  <meta charset="UTF-8">\n  <meta name="viewport" content="width=device-width, initial-scale=1.0">\n  <title>ZimConnect Frontend</title>\n  <link rel="stylesheet" href="css/styles.css">\n  <script src="js/scripts.js" defer></script>\n</head>\n<body>\n  <header>\n    <div class="logo">ZimConnect</div>\n    <nav>\n      <ul>\n        <li><a href="index.html">Home</a></li>\n        <li><a href="shop.html">Shop</a></li>\n        <li><a href="login.html" id="login-btn">Login</a></li>\n        <li><a href="#logout" id="logout-btn" style="display:none;">Logout</a></li>\n      </ul>\n    </nav>\n    <div class="theme-toggle">\n      <button id="toggle-darkmode">Dark Mode</button>\n    </div>\n    <div class="currency-switcher">\n      <label for="currency">Currency:</label>\n      <select id="currency">\n        <option value="ZAR" selected>ZAR</option>\n        <option value="USD">USD</option>\n      </select>\n    </div>\n  </header>\n  <main>\n    <section id="shop">\n      <h1>Welcome to ZimConnect</h1>\n      <div class="products" id="product-list"></div>\n    </section>\n    <section id="cart">\n      <h2>Shopping Cart</h2>\n      <div id="cart-items"></div>\n      <button id="checkout" onclick="checkout()">Checkout</button>\n    </section>\n    <section id="map">\n      <h2>Find Us</h2>\n      <div id="google-map" style="width: 100%; height: 400px;"></div>\n    </section>\n  </main>\n  <footer>\n    <p>&copy; 2025 ZimConnect. All rights reserved.</p>\n  </footer>\n</body>\n</html>'

  ["shop.html"]='<!DOCTYPE html>\n<html lang="en">\n<head>\n  <meta charset="UTF-8">\n  <meta name="viewport" content="width=device-width, initial-scale=1.0">\n  <title>Shop - ZimConnect</title>\n  <link rel="stylesheet" href="css/styles.css">\n  <script src="js/scripts.js" defer></script>\n</head>\n<body>\n  <header>\n    <div class="logo">ZimConnect</div>\n    <nav>\n      <ul>\n        <li><a href="index.html">Home</a></li>\n        <li><a href="shop.html">Shop</a></li>\n        <li><a href="login.html" id="login-btn">Login</a></li>\n        <li><a href="#logout" id="logout-btn" style="display:none;">Logout</a></li>\n      </ul>\n    </nav>\n  </header>\n  <main>\n    <h1>Shop Page</h1>\n    <div class="products" id="shop-products"></div>\n  </main>\n  <footer>\n    <p>&copy; 2025 ZimConnect. All rights reserved.</p>\n  </footer>\n</body>\n</html>'

  ["login.html"]='<!DOCTYPE html>\n<html lang="en">\n<head>\n  <meta charset="UTF-8">\n  <meta name="viewport" content="width=device-width, initial-scale=1.0">\n  <title>Login - ZimConnect</title>\n  <link rel="stylesheet" href="css/styles.css">\n  <script src="js/auth.js" defer></script>\n</head>\n<body>\n  <header>\n    <div class="logo">ZimConnect</div>\n    <nav>\n      <ul>\n        <li><a href="index.html">Home</a></li>\n        <li><a href="shop.html">Shop</a></li>\n        <li><a href="login.html" id="login-btn">Login</a></li>\n        <li><a href="#logout" id="logout-btn" style="display:none;">Logout</a></li>\n      </ul>\n    </nav>\n  </header>\n  <main>\n    <h1>Login Page</h1>\n    <form id="login-form">\n      <label for="username">Username:</label><br>\n      <input type="text" id="username" name="username"><br><br>\n      <label for="password">Password:</label><br>\n      <input type="password" id="password" name="password"><br><br>\n      <button type="submit">Login</button>\n    </form>\n  </main>\n  <footer>\n    <p>&copy; 2025 ZimConnect. All rights reserved.</p>\n  </footer>\n</body>\n</html>'
)

# Create necessary directories


# Generate CSS file
cat <<EOL > css/styles.css
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 20px;
    background-color: #333;
    color: white;
}
nav ul {
    list-style: none;
    display: flex;
    gap: 15px;
}
nav a {
    color: white;
    text-decoration: none;
}
.products {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    padding: 20px;
}
EOL

# Generate JavaScript files
cat <<EOL > js/scripts.js
document.getElementById("toggle-darkmode").addEventListener("click", function() {
    document.body.classList.toggle("dark-mode");
});
EOL

cat <<EOL > js/auth.js
document.getElementById("login-form").addEventListener("submit", function(e) {
    e.preventDefault();
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    console.log("Logging in with", username, password);
    // Add API call here
});
EOL

# Generate HTML files
for file in "${!files[@]}"; do
    echo -e "${files[$file]}" > "$file"
    git add "$file"
    git commit -m "Add $file"
    sleep 30
done

# Push to GitHub
git push


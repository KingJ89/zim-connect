#!/bin/bash

# Function to create a basic frontend for the Express.js backend
echo "Setting up frontend files..."
mkdir -p public/{css,js,images} views

# HTML for main page (views/index.ejs)
cat <<EOL > views/index.ejs
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ZimConnect E-commerce</title>
  <link rel="stylesheet" href="/css/styles.css">
  <script src="/js/scripts.js" defer></script>
</head>
<body>
  <header>
    <h1>Welcome to ZimConnect</h1>
    <nav>
      <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/shop">Shop</a></li>
        <li><a href="/cart">Cart</a></li>
        <li><a href="/login">Login</a></li>
      </ul>
    </nav>
  </header>
  <main>
    <h2>Our Products</h2>
    <div id="product-list"></div>
  </main>
  <footer>
    <p>&copy; 2025 ZimConnect. All rights reserved.</p>
  </footer>
</body>
</html>
EOL

# CSS file (public/css/styles.css)
cat <<EOL > public/css/styles.css
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}
header {
  background-color: #009e60;
  color: white;
  padding: 10px;
  text-align: center;
}
nav ul {
  list-style-type: none;
  padding: 0;
}
nav ul li {
  display: inline;
  margin: 0 15px;
}
EOL

# JavaScript file (public/js/scripts.js)
cat <<EOL > public/js/scripts.js
window.addEventListener('DOMContentLoaded', () => {
  console.log('ZimConnect frontend is up and running');
});
EOL

# Express.js route setup (routes/frontend.js)
cat <<EOL > routes/frontend.js
const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.render('index');
});

module.exports = router;
EOL

# Add route in server.js
if ! grep -q "frontend" server.js; then
  sed -i "/const app/a const frontendRoutes = require('./routes/frontend');" server.js
  sed -i "/app.use/a app.use('/', frontendRoutes);" server.js
fi

# Install dependencies and start the server
echo "Installing dependencies..."
npm install express ejs

echo "Starting the server..."
npm start &

# Git automation with incremental commits
echo "Automating git commits..."
FILES=("views/index.ejs" "public/css/styles.css" "public/js/scripts.js" "routes/frontend.js" "server.js")
INTERVALS=(7 8 9 10)

for i in "${!FILES[@]}"; do
  git add "${FILES[$i]}"
  git commit -m "Added ${FILES[$i]}"
  git push
  sleep ${INTERVALS[$((i % ${#INTERVALS[@]}))]}m
done

echo "Setup and deployment complete."


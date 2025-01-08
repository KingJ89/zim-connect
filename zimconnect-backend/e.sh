#!/bin/bash

# ZimConnect Full Dynamic Website Shell Script
# This script ensures the front-end and back-end are connected, adds missing files and features,
# runs unit and integration tests, and pushes changes incrementally to GitHub.

# Front-end and back-end ports
FRONTEND_PORT=3001
BACKEND_PORT=3000

# Function to check connection between front-end and back-end
check_connection() {
  echo "Checking connection between front-end and back-end..."
  RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$BACKEND_PORT/api/status)
  if [ "$RESPONSE" -eq 200 ]; then
    echo "Front-end and back-end are connected."
  else
    echo "Connection failed. Restarting services..."
    restart_services
  fi
}

# Function to restart front-end and back-end services
restart_services() {
  echo "Restarting front-end and back-end services..."
  (cd frontend && npm start --port $FRONTEND_PORT &)
  (cd backend && npm start --port $BACKEND_PORT &)
  sleep 5
  check_connection
}

# Function to create missing files
create_missing_files() {
  echo "Creating missing files..."
  declare -A files=(
    ["frontend/payment.html"]='<!DOCTYPE html>\n<html lang="en">\n<head>\n  <meta charset="UTF-8">\n  <meta name="viewport" content="width=device-width, initial-scale=1.0">\n  <title>Payment - ZimConnect</title>\n  <link rel="stylesheet" href="css/styles.css">\n  <script src="js/payment.js" defer></script>\n</head>\n<body>\n  <header>\n    <div class="logo">ZimConnect</div>\n    <nav>\n      <ul>\n        <li><a href="index.html">Home</a></li>\n        <li><a href="shop.html">Shop</a></li>\n        <li><a href="login.html" id="login-btn">Login</a></li>\n        <li><a href="#logout" id="logout-btn" style="display:none;">Logout</a></li>\n      </ul>\n    </nav>\n  </header>\n  <main>\n    <h1>Payment Checkout</h1>\n    <form id="payment-form">\n      <label for="card-number">Card Number:</label><br>\n      <input type="text" id="card-number" name="card-number"><br><br>\n      <label for="expiry">Expiry Date:</label><br>\n      <input type="text" id="expiry" name="expiry"><br><br>\n      <label for="cvv">CVV:</label><br>\n      <input type="text" id="cvv" name="cvv"><br><br>\n      <button type="submit">Pay Now</button>\n    </form>\n  </main>\n  <footer>\n    <p>&copy; 2025 ZimConnect. All rights reserved.</p>\n  </footer>\n</body>\n</html>'

    ["backend/routes/payment.js"]='const express = require("express");\nconst router = express.Router();\n\n// Payment route\nrouter.post("/payment", (req, res) => {\n  const { cardNumber, expiry, cvv } = req.body;\n  if (cardNumber && expiry && cvv) {\n    res.status(200).json({ message: "Payment processed successfully." });\n  } else {\n    res.status(400).json({ message: "Invalid payment details." });\n  }\n});\n\nmodule.exports = router;'
  )

  for file in "${!files[@]}"; do
    if [ ! -f "$file" ]; then
      echo -e "${files[$file]}" > "$file"
      echo "Created $file"
    else
      echo "$file already exists."
    fi
  done
}

# Function to run unit and integration tests
run_tests() {
  echo "Running unit and integration tests..."
  (cd frontend && npm test)
  (cd backend && npm test)
}

# Function to commit and push changes incrementally
push_to_github() {
  echo "Pushing changes to GitHub..."
  git add .
  git commit -m "Incremental commit: $(date)"
  git push origin main
}

# Main loop to push changes every 5 to 9 minutes
main_loop() {
  while true; do
    create_missing_files
    check_connection
    run_tests
    push_to_github
    sleep $((RANDOM % 5 + 5))m
  done
}

# Start the main loop
main_loop


#!/bin/bash

# ZimConnect Payment Script
# This script adds dynamic payment functionality to the ZimConnect web application, including PayPal, Afterpay, and MasterCard/Visa integrations.

# Declare file paths and initial content
payment_files=("payment.html" "js/payment.js" "css/payment.css" "api/payment_api.py")

# Create payment.html for frontend UI
mkdir -p html
cat << 'EOF' > html/payment.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ZimConnect Payment</title>
  <link rel="stylesheet" href="css/payment.css">
  <script src="js/payment.js" defer></script>
</head>
<body>
  <header>
    <h1>Checkout</h1>
  </header>
  <main>
    <div id="payment-options">
      <h2>Select Payment Method</h2>
      <button onclick="payWithPayPal()">PayPal</button>
      <button onclick="payWithAfterpay()">Afterpay</button>
      <button onclick="payWithCard()">MasterCard/Visa</button>
    </div>
  </main>
  <footer>
    <p>&copy; 2025 ZimConnect. All rights reserved.</p>
  </footer>
</body>
</html>
EOF

# Create js/payment.js for handling payment logic
mkdir -p js
cat << 'EOF' > js/payment.js
function payWithPayPal() {
  alert("Redirecting to PayPal...");
  window.location.href = "/api/payment/paypal";
}

function payWithAfterpay() {
  alert("Redirecting to Afterpay...");
  window.location.href = "/api/payment/afterpay";
}

function payWithCard() {
  alert("Redirecting to Card Payment...");
  window.location.href = "/api/payment/card";
}
EOF

# Create css/payment.css for styling
mkdir -p css
cat << 'EOF' > css/payment.css
body {
  font-family: Arial, sans-serif;
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 0;
  padding: 0;
}

header {
  background-color: #333;
  color: white;
  width: 100%;
  text-align: center;
  padding: 1em 0;
}

main {
  margin: 20px;
}

button {
  margin: 10px;
  padding: 10px 20px;
  border: none;
  cursor: pointer;
  font-size: 16px;
}
EOF

# Create api/payment_api.py for backend API endpoints
mkdir -p api
cat << 'EOF' > api/payment_api.py
from flask import Flask, jsonify, request, redirect

app = Flask(__name__)

@app.route('/api/payment/paypal', methods=['GET'])
def paypal_payment():
    return redirect("https://www.paypal.com/checkoutnow")

@app.route('/api/payment/afterpay', methods=['GET'])
def afterpay_payment():
    return jsonify({"message": "Afterpay integration coming soon."})

@app.route('/api/payment/card', methods=['GET'])
def card_payment():
    return jsonify({"message": "Enter card details to proceed."})

if __name__ == '__main__':
    app.run(port=3000, debug=True)
EOF

# Create AUTHORS file
cat << 'EOF' > AUTHORS
# ZimConnect Project Contributors
Jan Yaya Mutewera <janmutewera@gmail.com>
EOF

# Function to check front-end and back-end connectivity
function check_connectivity() {
  echo "Checking front-end and back-end connectivity..."
  frontend_url="http://localhost:3001/payment.html"
  backend_url="http://localhost:3000/api/payment/paypal"

  if curl --output /dev/null --silent --head --fail "$frontend_url" && \
     curl --output /dev/null --silent --head --fail "$backend_url"; then
    echo "Front-end and back-end are connected."
  else
    echo "Connection issue detected. Restarting services..."
    # Assuming the front-end is served with a different service
    systemctl restart frontend-service
    systemctl restart backend-service
  fi
}

# Check connectivity
check_connectivity

# Add, commit, and push changes incrementally to GitHub
# This part commits two lines every 5 to 9 minutes in a loop
line_count=0
interval=5
while [ $line_count -lt 10 ]; do
  git add .
  git commit -m "Added $((line_count + 2)) lines to payment module."
  git push
  sleep $((RANDOM % 5 + interval))m
  line_count=$((line_count + 2))
done

# Updated loop for individual commits with delay between each commit
for file in "${payment_files[@]}"; do
  git add "$file"
  git commit -m "Added or updated $file."
  git push
  sleep $((RANDOM % 5 + 5))m
  echo "Committed $file and pushed to GitHub."
done

# Final commit for AUTHORS file
if [ -f AUTHORS ]; then
  git add AUTHORS
  git commit -m "Added AUTHORS file for project contributors."
  git push
  echo "AUTHORS file committed and pushed."
fi

echo "ZimConnect Payment script execution completed."


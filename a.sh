#!/bin/bash

# Set environment variables

export FRONTEND_PORT=3001
export BACKEND_PORT=3000

# Clone the repository if not already cloned
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Cloning the ZimConnect e-commerce repository..."
    git clone "$REPO_URL" "$PROJECT_DIR"
else
    echo "Repository already exists. Pulling latest changes..."
    cd "$PROJECT_DIR"
    git pull origin main
fi

# Navigate to the project directory
cd "$PROJECT_DIR"

# Create and implement today's features in the backend
echo "Creating and implementing backend features..."
mkdir -p backend
cd backend

cat <<EOF > server.js
// Backend Server Code
const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

// MongoDB connection
mongoose.connect('mongodb://localhost:27017/zimconnect', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error('Failed to connect to MongoDB:', err));

// User Schema
const userSchema = new mongoose.Schema({
  username: { type: String, required: true, unique: true },
  password: { type: String, required: true },
});

// Hash passwords before saving
userSchema.pre('save', async function(next) {
  if (!this.isModified('password')) return next();
  this.password = await bcrypt.hash(this.password, 10);
  next();
});

const User = mongoose.model('User', userSchema);

// Authentication Routes
app.post('/register', async (req, res) => {
  try {
    const user = new User(req.body);
    await user.save();
    res.status(201).json({ message: 'User registered successfully' });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

app.post('/login', async (req, res) => {
  try {
    const { username, password } = req.body;
    const user = await User.findOne({ username });
    if (!user || !(await bcrypt.compare(password, user.password))) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    const token = jwt.sign({ id: user._id }, 'secret', { expiresIn: '1h' });
    res.json({ token });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Start server
app.listen(${BACKEND_PORT}, () => console.log('Backend running on port ${BACKEND_PORT}'));
EOF

npm install express mongoose bcrypt jsonwebtoken cors
echo "Backend setup completed."

# Push backend changes to GitHub
git add server.js package.json package-lock.json
git commit -m "Added backend server code with authentication"
SLEEP_TIME=$((RANDOM % 5 + 5))
echo "Pushing backend changes to GitHub after $SLEEP_TIME minutes..."
sleep "${SLEEP_TIME}m"
git push origin main

# Create and implement today's features in the frontend
echo "Creating and implementing frontend features..."
cd ../
mkdir -p frontend
cd frontend

cat <<EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ZimConnect E-commerce</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <h1>Welcome to ZimConnect</h1>
  <div id="app"></div>
  <script src="app.js"></script>
</body>
</html>
EOF

cat <<EOF > styles.css
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  background-color: #f0f0f0;
}
h1 {
  text-align: center;
  margin-top: 20px;
}
EOF

cat <<EOF > app.js
const app = document.getElementById('app');

// Example: Dynamic product loading
fetch('http://localhost:${BACKEND_PORT}/products')
  .then(response => response.json())
  .then(products => {
    app.innerHTML = products.map(product => `
      <div class="product">
        <h2>${product.name}</h2>
        <p>${product.description}</p>
        <p>Price: \$${product.price}</p>
      </div>
    `).join('');
  })
  .catch(err => console.error('Failed to load products:', err));
EOF

npm install
echo "Frontend setup completed."

# Push frontend changes to GitHub
git add index.html styles.css app.js package.json package-lock.json
git commit -m "Added frontend with dynamic product loading"
SLEEP_TIME=$((RANDOM % 5 + 5))
echo "Pushing frontend changes to GitHub after $SLEEP_TIME minutes..."
sleep "${SLEEP_TIME}m"
git push origin main

# Final cleanup and deployment
echo "Finalizing and deploying the project..."
cd "$PROJECT_DIR"
npm run build
echo "Deployment completed. Visit http://localhost:$FRONTEND_PORT to view your site."


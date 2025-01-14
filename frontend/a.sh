#!/bin/bash

# Script to generate missing files, implement authentication, connect frontend and backend,
# and push changes to GitHub with a random delay between commits

# Function to check if dependencies are installed
check_dependencies() {
    echo "Checking required dependencies..."
    dependencies=(node npm git)
    for dep in "${dependencies[@]}"; do
        if ! command -v $dep &>/dev/null; then
            echo "$dep is not installed. Installing..."
            sudo apt update && sudo apt install -y $dep
        else
            echo "$dep is already installed."
        fi
    done
}

# Install required Node.js packages
install_node_packages() {
    echo "Installing required Node.js packages..."
    npm install express bcrypt jsonwebtoken cors body-parser dotenv --save
}

# Function to introduce a random delay between 5 to 9 minutes
random_delay() {
    delay=$((RANDOM % 5 + 5))
    echo "Delaying for $delay minutes..."
    sleep ${delay}m
}

# Create backend files for authentication
create_backend_files() {
    echo "Creating backend authentication files..."
    mkdir -p controllers routes middlewares models

    # User model
    cat > models/user.js <<EOL
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const UserSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true }
});

UserSchema.pre('save', async function (next) {
    if (!this.isModified('password')) return next();
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);
    next();
});

module.exports = mongoose.model('User', UserSchema);
EOL
    random_delay

    # Auth controller
    cat > controllers/authController.js <<EOL
const User = require('../models/user');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

exports.register = async (req, res) => {
    try {
        const { username, email, password } = req.body;
        const user = new User({ username, email, password });
        await user.save();
        res.status(201).json({ message: 'User registered successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Registration failed', error });
    }
};

exports.login = async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email });
        if (!user) return res.status(404).json({ message: 'User not found' });

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(400).json({ message: 'Invalid credentials' });

        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });
        res.status(200).json({ token });
    } catch (error) {
        res.status(500).json({ message: 'Login failed', error });
    }
};
EOL
    random_delay

    # Auth routes
    cat > routes/authRoutes.js <<EOL
const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

router.post('/register', authController.register);
router.post('/login', authController.login);

module.exports = router;
EOL
    random_delay

    echo "Backend files created successfully."
}

# Create frontend files for authentication
create_frontend_files() {
    echo "Creating frontend authentication files..."
    mkdir -p frontend/js frontend/css

    # Registration form
    cat > frontend/register.html <<EOL
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - ZimConnect</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <h1>Register</h1>
    <form id="register-form">
        <input type="text" id="username" placeholder="Username" required><br>
        <input type="email" id="email" placeholder="Email" required><br>
        <input type="password" id="password" placeholder="Password" required><br>
        <button type="submit">Register</button>
    </form>
    <script src="js/register.js"></script>
</body>
</html>
EOL
    random_delay

    # Registration script
    cat > frontend/js/register.js <<EOL
document.getElementById('register-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    const username = document.getElementById('username').value;
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    const response = await fetch('http://localhost:3000/api/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ username, email, password })
    });

    const result = await response.json();
    alert(result.message);
});
EOL
    random_delay

    echo "Frontend files created successfully."
}

# Git commit and push with random delay
commit_and_push() {
    echo "Committing and pushing changes to GitHub..."
    git add .
    git commit -m "Added authentication and frontend-backend connection with random delays"
    git push origin main
    random_delay
}

# Main script execution
check_dependencies
install_node_packages
create_backend_files
create_frontend_files
commit_and_push

echo "All tasks completed successfully."


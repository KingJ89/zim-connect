#!/bin/bash

# Check if git is initialized
if [ ! -d ".git" ]; then
  echo "This directory is not a Git repository. Please initialize Git first."
  exit 1
fi

# Base project structure
declare -A files_to_create=(
  ["frontend/index.html"]="<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <title>ZimConnect</title>
  <link rel='stylesheet' href='css/styles.css'>
  <script src='js/scripts.js' defer></script>
</head>
<body>
  <!-- Main HTML content -->
  <header>
    <h1>Welcome to ZimConnect</h1>
    <nav>
      <ul>
        <li><a href='/'>Home</a></li>
        <li><a href='/shop'>Shop</a></li>
        <li><a href='/auth'>Login</a></li>
      </ul>
    </nav>
  </header>
  <main>
    <div id='product-list'></div>
  </main>
  <footer>
    <p>&copy; 2025 ZimConnect</p>
  </footer>
</body>
</html>"
  
  ["frontend/css/styles.css"]="/* Dark mode styles */
body.dark-mode {
  background-color: #121212;
  color: #ffffff;
}

header {
  background-color: green;
  color: white;
}

footer {
  background-color: red;
  color: yellow;
}

/* Currency switcher */
.currency-switcher {
  display: flex;
  align-items: center;
  margin: 10px;
}"
  
  ["frontend/js/scripts.js"]="document.addEventListener('DOMContentLoaded', () => {
  // Dark mode toggle
  const darkModeToggle = document.getElementById('toggle-darkmode');
  darkModeToggle.addEventListener('click', () => {
    document.body.classList.toggle('dark-mode');
    localStorage.setItem('darkMode', document.body.classList.contains('dark-mode'));
  });

  // Currency switcher
  const currencySwitcher = document.getElementById('currency');
  currencySwitcher.addEventListener('change', (event) => {
    alert('Currency changed to: ' + event.target.value);
  });
});"

  ["backend/routes/auth.js"]="const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const User = require('../models/user');

// Register route
router.post('/register', async (req, res) => {
  const { username, password } = req.body;
  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    const user = new User({ username, password: hashedPassword });
    await user.save();
    res.status(201).json({ message: 'User registered successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Registration failed' });
  }
});

// Login route
router.post('/login', async (req, res) => {
  const { username, password } = req.body;
  try {
    const user = await User.findOne({ username });
    if (!user) return res.status(400).json({ error: 'Invalid credentials' });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ error: 'Invalid credentials' });

    res.status(200).json({ message: 'Login successful' });
  } catch (error) {
    res.status(500).json({ error: 'Login failed' });
  }
});

module.exports = router;"
)

# Function to create or overwrite files
create_or_amend_files() {
  for filepath in "${!files_to_create[@]}"; do
    mkdir -p "$(dirname "$filepath")" # Ensure the directory exists
    echo "${files_to_create[$filepath]}" > "$filepath"
    echo "Created/updated: $filepath"
  done
}

# Function to generate unique commit messages
generate_commit_message() {
  timestamp=$(date "+%Y-%m-%d %H:%M:%S")
  echo "Implemented changes for $1 at $timestamp"
}

# Commit and push each file individually
commit_and_push_files() {
  for filepath in "${!files_to_create[@]}"; do
    git add "$filepath"
    commit_message=$(generate_commit_message "$filepath")
    git commit -m "$commit_message"
    git push origin main
    echo "Committed and pushed: $filepath"
    
    # Random delay between 5 to 13 minutes
    delay=$((RANDOM % 9 + 5))
    echo "Waiting for $delay minutes before committing the next file..."
    sleep "${delay}m"
  done
}

# Main script execution
echo "Starting file creation and GitHub push process..."
create_or_amend_files
commit_and_push_files
echo "All files processed and pushed to GitHub."


#!/bin/bash

# Function to log messages with timestamps
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Function to commit and push changes to GitHub
git_commit_push() {
    git add .
    git commit -m "$1"
    git push
}

# Main script starts here
log_message "Initializing Git repository..."

# Step 1: Create project structure
log_message "Setting up project directories..."
mkdir -p frontend tests
echo -e "# ZimConnect\nA platform for e-commerce solutions between South Africa and Zimbabwe." > README.md
git_commit_push "Initialized ZimConnect project structure and README"

# Step 2: Create .env file
log_message "Creating .env file..."
cat <<EOT > .env
PORT=3000
API_URL=http://localhost:3000/api
GOOGLE_MAPS_API_KEY=YOUR_GOOGLE_MAPS_API_KEY
DB_USER=zimconnect
DB_PASSWORD=Jmutewera27
DB_NAME=zimconnect_db
EOT
git_commit_push "Added .env file with project configuration"

# Step 3: Set up backend server
log_message "Setting up backend server files..."
cat <<EOT > backend/server.js
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use('/api', (req, res) => {
    res.json({ message: 'Welcome to the ZimConnect API!' });
});

app.listen(PORT, () => {
    console.log(\`Backend server running on port \${PORT}\`);
});
EOT

cat <<EOT > backend/package.json
{
  "name": "zimconnect-backend",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.2"
  }
}
EOT

cd backend && npm install && cd ../..
git_commit_push "Set up backend server with Express"

# Step 4: Set up frontend server
log_message "Setting up frontend files..."
cat <<EOT > frontend/index.html
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
        <h1>Welcome to ZimConnect</h1>
    </header>
    <main>
        <p>Connecting South Africa and Zimbabwe with seamless e-commerce.</p>
    </main>
</body>
</html>
EOT

mkdir -p frontend/css zimconnect/frontend/js
cat <<EOT > frontend/css/styles.css
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
    color: #333;
}
header {
    background-color: #00843D;
    color: white;
    padding: 1rem;
    text-align: center;
}
EOT

cat <<EOT > frontend/js/scripts.js
console.log("ZimConnect Frontend Loaded");
EOT

# Configure frontend server (Optional: for development, Next.js or static file hosting)
cat <<EOT > frontend/package.json
{
  "name": "zimconnect-frontend",
  "version": "1.0.0",
  "main": "index.html",
  "scripts": {
    "start": "http-server -p 3001"
  },
  "dependencies": {
    "http-server": "^14.1.1"
  }
}
EOT

cd frontend && npm install http-server && cd ../..
git_commit_push "Set up frontend files and server configuration"

# Summary message
log_message "Project setup complete. Backend is on port 3000, frontend is on port 3001."
log_message "You can run the backend using 'node zimconnect/backend/server.js' and the frontend using 'npm run start' in zimconnect/frontend."


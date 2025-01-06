#!/bin/bash

# Variables
DB_NAME="zimconnect"
DB_USER="zimconnect"
DB_PASS="Jmutewera27"
ENV_FILE=".env"

echo "Starting ZimConnect setup..."

# Step 1: Log in to MySQL and create database, user, and grant privileges
echo "Creating MySQL database and user..."

sudo mysql -u root -p <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

if [ $? -eq 0 ]; then
    echo "Database and user setup completed successfully."
else
    echo "Error setting up database or user. Please check MySQL logs."
    exit 1
fi

# Step 2: Update .env file with database credentials
echo "Updating .env file..."

cat <<EOL > $ENV_FILE
DB_HOST=localhost
DB_USER=$DB_USER
DB_PASS=$DB_PASS
DB_NAME=$DB_NAME
EOL

if [ $? -eq 0 ]; then
    echo ".env file updated successfully."
else
    echo "Error updating .env file."
    exit 1
fi

echo "ZimConnect setup completed successfully."


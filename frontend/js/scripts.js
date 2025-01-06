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

cd zimconnect/frontend && npm install http-server && cd ../..
git_commit_push "Set up frontend files and server configuration"

# Summary message
log_message "Project setup complete. Backend is on port 3000, frontend is on port 3001."
log_message "You can run the backend using 'node zimconnect/backend/server.js' and the frontend using 'npm run start' in zimconnect/frontend."
 <script src="js/scripts.js" defer></script>
    <script src="js/auth.js" defer></script>
    <script src="js/cart.js" defer></script>
    <script src="js/currency.js" defer></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap" defer></script>

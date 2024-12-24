const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();

// import routes
const productRoutes = require('./routes/productRoutes');

// initialize setup
const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Routes
app.use('/api/products' , productRoutes);

// Default route
app.get('/' , (req, res) =>  {res.send('ZimConnect Backend is running...');
});

// Start the server
const PORT = process.env.PORT || 4000; app.listen(PORT, () => {console.log('Server running on port ${PORT}');
});

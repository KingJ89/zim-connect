const express = require('express');
const router = express.Router();
const { getLocation } = require('../controllers/locationController');

// Get location
router.get('/', getLocation);

module.exports = router;

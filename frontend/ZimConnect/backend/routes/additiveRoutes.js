const express = require('express');
const router = express.Router();
const { getAdditives } = require('../controllers/additiveController');

// Get additives
router.get('/', getAdditives);

module.exports = router;

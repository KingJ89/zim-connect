const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { body, validationResult } = require('express-validator');

const router = express.Router();

// Mock database
const users = [];

// Register Route
router.post(
  '/register',
  body('email').isEmail(),
  body('password').isLength({ min: 6 }),
  (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { email, password } = req.body;
    const hashedPassword = bcrypt.hashSync(password, 10);

    users.push({ email, password: hashedPassword });
    res.status(201).json({ message: 'User registered!' });
  }
);

// Login Route
router.post('/login', (req, res) => {
  const { email, password } = req.body;
  const user = users.find((u) => u.email === email);

  if (!user || !bcrypt.compareSync(password, user.password)) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }

  const token = jwt.sign({ email }, 'secret', { expiresIn: '1h' });
  res.cookie('token', token, { httpOnly: true }).json({ message: 'Logged in!' });
});

module.exports = router;


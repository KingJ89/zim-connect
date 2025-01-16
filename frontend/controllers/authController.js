const bcrypt = require('bcrypt');
const User = require('../models/User');

exports.register = async (req, res) => {
  try {
    const { email, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);
    const user = new User({ email, password: hashedPassword });
    await user.save();
    res.json({ success: true, message: 'User registered successfully.' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: 'Registration failed.' });
  }
};

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (user && (await bcrypt.compare(password, user.password))) {
      res.json({ success: true, message: 'Login successful.' });
    } else {
      res.status(401).json({ success: false, message: 'Invalid credentials.' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: 'Login failed.' });
  }
};


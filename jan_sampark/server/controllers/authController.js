const User = require('../models/user');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

exports.register = async (req, res) => {
  console.log('Register route hit');
  console.log('Request body:', req.body);
  
  const { email, username, password, firstName, lastName, aadhar, phone, pincode, voterId } = req.body;
  
  if (!email || !username || !password || !firstName || !lastName || !aadhar || !phone || !pincode || !voterId) {
    return res.status(400).json({ error: 'All fields are required' });
  }
  
  try {
    let user = await User.findOne({ $or: [{ email }, { username }, { aadhar }, { voterId }] });
    if (user) {
      return res.status(400).json({ msg: 'User already exists' });
    }
    
    user = new User({
      email,
      username,
      password,
      firstName,
      lastName,
      aadhar,
      phone,
      pincode,
      voterId,
    });
    
    const salt = await bcrypt.genSalt(10);
    user.password = await bcrypt.hash(password, salt);
    
    await user.save();
    res.status(201).json({ msg: 'User registered successfully' });
  } catch (err) {
    console.error('Server error:', err);
    res.status(500).json({ error: 'Server Error', message: err.message });
  }
};
exports.login = async (req, res) => {
  console.log('Login route hit');
  console.log('Request body:', req.body);
  
  const { username, password } = req.body;
  
  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password are required' });
  }
  
  try {
    const user = await User.findOne({ username });
    if (!user) {
      return res.status(400).json({ msg: 'Invalid credentials' });
    }
    
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: 'Invalid credentials' });
    }
    
    const payload = {
      user: {
        id: user.id,
        username: user.username
      }
    };
    
    jwt.sign(
      payload,
      process.env.JWT_SECRET,
      { expiresIn: '1h' },
      (err, token) => {
        if (err) throw err;
        res.json({ token, msg: 'Login successful' });
      }
    );
  } catch (err) {
    console.error('Login error:', err);
    res.status(500).json({ error: 'Server Error', message: err.message });
  }
};

const User = require('../models/user');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

exports.register = async (req, res) => {
  console.log('Register route hit');
  console.log('Request body:', req.body);
  
  const { email, username, password, firstName, lastName, aadhar, phone, pincode, voterId } = req.body;
  
  console.log('Extracted data:', { email, username, password, firstName, lastName, aadhar, phone, pincode, voterId });

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
  // Implement login logic here
};
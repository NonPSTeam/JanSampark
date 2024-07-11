// routes/authRoutes.js
const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// POST /register
// router.post('/api/auth/register', authController.register);
router.get('/api/auth/register', (req, res) => {
    res.send('Registration endpoint is working');
  });

// POST /login
router.post('/login', authController.login);

module.exports = router;

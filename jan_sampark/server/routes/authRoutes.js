const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

router.post('/register', authController.register);
router.post('/login', authController.login);

// Optional: Add GET handlers for debugging
router.get('/register', (req, res) => {
  res.status(405).json({ message: "Registration requires a POST request" });
});

router.get('/login', (req, res) => {
  res.status(405).json({ message: "Login requires a POST request" });
});

module.exports = router;

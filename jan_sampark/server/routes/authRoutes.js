const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// Ensure that authController.register is defined and exported
router.post('/register', authController.register);
router.post('/login', authController.login);

module.exports = router;
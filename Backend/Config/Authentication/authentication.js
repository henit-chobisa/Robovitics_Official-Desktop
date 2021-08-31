const express = require('express');

const router = express.Router()

router.use('/login', require('./routes/login'));
router.use('/register', require('./routes/register'));
router.use('/token', require('./routes/token'));

module.exports = router
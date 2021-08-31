const express = require('express');

const router = express.Router()

router.use('/login', require('./routes/login'));

module.exports = router
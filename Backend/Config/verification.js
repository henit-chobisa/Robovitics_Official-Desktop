const express = require('express');
const router = express.Router();

router.use('/', require('./routes/base'));

module.exports = router
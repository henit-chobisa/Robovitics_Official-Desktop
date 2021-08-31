const express = require('express');
const router = express.Router();

router.use('/', require('./routes/base'));
router.use('/health', require('./routes/health'));

module.exports = router
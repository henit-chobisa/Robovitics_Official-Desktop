const express = require('express');
const router = express.Router()

router.use('/getUserInfo', require('./routes/getUser'));

module.exports = router;
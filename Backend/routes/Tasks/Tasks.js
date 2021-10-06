const express = require('express');
const router = express.Router();

// Post Requests
router.use('/addTask', require('./Routes/addTask'));

module.exports = router;
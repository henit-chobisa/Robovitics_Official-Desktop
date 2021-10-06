const express = require('express');
const router = express.Router();

// Post Requests
router.use('/addTask', require('./Routes/addTask'));
router.use('/addAcknowledgement', require('./Routes/addAcknowledgement'));

module.exports = router;
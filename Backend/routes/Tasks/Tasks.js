const express = require('express');
const router = express.Router();

// Post Requests
router.use('/addTask', require('./Routes/addTask'));
router.use('/addAcknowledgement', require('./Routes/addAcknowledgement'));
router.use('/addSubmission', require('./Routes/addSubmission'));
router.use('/askQuestion', require('./Routes/addQuestion'));
router.use('/addComment', require('./Routes/addComment'))

module.exports = router;
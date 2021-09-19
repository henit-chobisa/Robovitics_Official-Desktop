const express = require('express');
const router = express.Router();


// Post Routes...
router.use('/createEvent', require('./Routes/createEvent'));
router.use('/addImage', require('./Routes/addimage'));
router.use('/addContribution', require('./Routes/addContribution'));
router.use('/addInstagramPost', require('./Routes/addInstagramPost'));
router.use('/getUserContributions', require('./Routes/getUserContributions'));


// Get events ..
router.use('/allEvents',require('./Routes/getallevents'));
router.use('/getEvent', require('./Routes/getAnEvent'));

module.exports = router;
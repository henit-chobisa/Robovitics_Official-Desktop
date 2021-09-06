const express = require('express');
const router = express.Router();


// Post Routes...
router.use('/createEvent', require('./Events/createEvent'));
router.use('/addImage', require('./Routes/addimage'));
router.use('/addContribution', require('./Events/addContribution'));

// Get events ..
router.use('/allEvents',require('./Routes/getallevents'));
router.use('/getEvent', require('./Events/getAnEvent'));

module.exports = router;
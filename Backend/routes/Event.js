const express = require('express');
const router = express.Router();

router.use('/allEvents',require('./Events/getallevents'));
router.use('/createEvent', require('./Events/createEvent'));
router.use('/addImage', require('./Events/addimage'));
router.use('/addContribution', require('./Events/addContribution'));

module.exports = router;
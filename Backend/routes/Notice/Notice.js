const express = require("express")
const router = express.Router();

// Post Requests
router.use('/createNotice', require('./Routes/createNotice'));
router.use('/createAcknow', require("./Routes/createAcknowledgement"));
router.use('/addConcent', require('./Routes/addConcent'));
router.use('/addUpvote', require('./Routes/addUpvote'));
router.use('/addDownvotes', require('./Routes/addDownvotes'));

// Get Requests
router.use('/getNotice', require('./Routes/getNotice'));
router.use('/getAllNotices', require('./Routes/getAllNotice'));
router.use('/getDiscussions', require('./Routes/getAllDiscussions'));

module.exports = router;
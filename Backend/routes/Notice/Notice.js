const express = require("express")
const router = express.Router();

router.use('/createNotice', require('./Routes/createNotice'));
router.use('/createAcknow', require("./Routes/createAcknowledgement"));
router.use('/getNotice', require('./Routes/getNotice'));
router.use('/getAllNotices', require('./Routes/getAllNotice'));

module.exports = router;
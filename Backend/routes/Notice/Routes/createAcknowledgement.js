const express = require("express");
const NoticeModel = require("../../../models/Notice/NoticeModel");
const router = express.Router();

router.post('/', async (req, res) => {
    const { noticeID, userBID } = req.body;
    const notice = await NoticeModel.findById(noticeID);
    await notice.addAcknowledgement(userBID);
    res.send("Added");
})

module.exports = router;
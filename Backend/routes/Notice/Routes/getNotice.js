const express = require("express")
const router = express.Router();
const url = require("url");
const NoticeModel = require("../../../models/Notice/NoticeModel");

router.get('/', async (req, res) => {
    var query = url.parse(req.url, true).query;
    const noticeID = query.noticeID;
    const notice = NoticeModel.findById(noticeID).populate(Discussions);
    if (notice == null){
        res.sendStatus(300);
    }
    else {
        res.json(notice);
    }
})

module.exports = router;
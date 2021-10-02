const express = require('express');
const NoticeModel = require('../../../models/Notice/NoticeModel');
const router = express.Router();
const url = require("url");

router.get('/', async (req, res) => {
    var query = url.parse(req.url, true).query;
    const noticeID = query.noticeID;
    const notice = await NoticeModel.findById(noticeID).populate('Discussions').populate({path : 'Discussions', populate : 'userInfo'});
    console.log(notice['Discussions']);
    res.json(notice['Discussions']);
})

module.exports = router;
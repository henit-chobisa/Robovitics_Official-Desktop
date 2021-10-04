const express = require('express');
const NoticeModel = require('../../../models/Notice/NoticeModel');
const router = express.Router();
const url = require("url");

router.get('/', async (req, res) => {
    var query = url.parse(req.url, true).query;
    const noticeID = query.noticeID;
    const notice = await NoticeModel.findById(noticeID).populate('Concents');
    res.json(notice['Concents']);
})

module.exports = router;
const express = require('express');
const NoticeModel = require('../../../models/Notice/NoticeModel');
const Concent = require('../../../models/Notice/ConcentModel');
const Router = express.Router();

Router.post('/', async(req, res) => {
    const { noticeID, concent } = req.body;
    const notice = await NoticeModel.findById(noticeID);
    const Upvotes = 0;
    const Downvotes = 0;
    const conc = new Concent({ Concent : concent, Upvotes : Upvotes, Downvotes : Downvotes});
    notice.Concents.push(conc);
    await conc.save();
    await notice.save();
    res.send("Concent Added");
})

module.exports = Router;
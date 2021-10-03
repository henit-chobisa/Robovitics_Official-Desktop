const express = require('express');
const NoticeModel = require('../../../models/Notice/NoticeModel');
const Router = express.Router();

Router.post('/', async (req, res) => {
    const {noticeID, concentID} = req.body;
    const concent = await NoticeModel.findById(noticeID).select({Concents : {$elemMatch : {"_id" : concentID}}});
    const currentUpvotes = concent['Concents'][0]['Upvotes'];
    concent['Concents'][0]['Upvotes'] = currentUpvotes + 1;
    concent.save();
    res.json("done");
})

module.exports = Router;
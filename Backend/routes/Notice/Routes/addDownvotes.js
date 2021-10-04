const express = require('express');
const NoticeModel = require('../../../models/Notice/NoticeModel');
const Router = express.Router();

Router.post('/', async (req, res) => {
    const {noticeID, concentID} = req.body;
    const concent = await NoticeModel.findById(noticeID).select({Concents : {$elemMatch : {"_id" : concentID}}});
    const currentUpvotes = concent['Concents'][0]['Downvotes'];
    concent['Concents'][0]['Downvotes'] = currentUpvotes + 1;
    concent['Concents'][0].UpvotedBy.push(UserID);
    concent.save();
    res.json("done");
})

module.exports = Router;
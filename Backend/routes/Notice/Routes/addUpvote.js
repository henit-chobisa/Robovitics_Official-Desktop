const express = require('express');
const Concent = require('../../../models/Notice/ConcentModel');
const NoticeModel = require('../../../models/Notice/NoticeModel');
const Router = express.Router();

Router.post('/', async (req, res) => {
    const {concentID, UserID} = req.body;
    const concent = await Concent.findById(concentID);
    concent.addUpvote(UserID);
    concent.save();
    res.json("Done");
})

module.exports = Router;
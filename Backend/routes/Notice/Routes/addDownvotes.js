const express = require('express');
const NoticeModel = require('../../../models/Notice/NoticeModel');
const Router = express.Router();
const Concent = require('../../../models/Notice/ConcentModel');

Router.post('/', async (req, res) => {
    const {concentID, UserID} = req.body;
    const concent = await Concent.findById(concentID);
    concent.addDownvote(UserID);
    concent.save();
    res.json("Done");
})

module.exports = Router;
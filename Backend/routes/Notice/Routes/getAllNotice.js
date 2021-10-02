const express = require("express");
const NoticeModel = require("../../../models/Notice/NoticeModel");
const router = express.Router();

router.get('/', async (req, res) => {
    const notices = await NoticeModel.find().populate('Discussions').populate({path : 'Discussions', populate : 'userInfo'});
    console.log(notices);
    res.json(notices);
})

module.exports = router;
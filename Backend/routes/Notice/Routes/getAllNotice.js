const express = require("express");
const NoticeModel = require("../../../models/Notice/NoticeModel");
const router = express.Router();

router.get('/', async (req, res) => {
    const notices = await NoticeModel.find().populate('Discussions');
    console.log(notices);
    res.json(notices);
})

module.exports = router;
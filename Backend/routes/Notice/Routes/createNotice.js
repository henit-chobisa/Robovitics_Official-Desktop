const express = require("express");
const NoticeModel = require("../../../models/Notice/NoticeModel");
const router = express.Router();
const moment = require("moment");

router.post('/', async (req, res) => {
    const {title, description, docLink} = req.body;
    var notice = await NoticeModel.findOne({docLink});
    const timeStamp = moment().format();
    if (notice == null){
        notice = new NoticeModel({title, description, docLink, timeStamp});
        notice.save();
        res.json("Notice Added");
    }
    else {
        res.send(400);
    }
})

module.exports = router;
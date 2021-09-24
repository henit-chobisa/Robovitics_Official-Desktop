const express = require("express");
const NoticeModel = require("../../../models/Notice/NoticeModel");
const router = express.Router();

router.post('/', async (req, res) => {
    const {title, description, docLink} = req.body;
    const notice = NoticeModel.findOne({docLink});
    if (notice == null){
        notice = new NoticeModel([title, description, docLink])
    }
    else {
        res.send(300);
    }
})

module.exports = router;
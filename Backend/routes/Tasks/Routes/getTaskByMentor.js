const express = require('express');
const router = express.Router();
const url = require("url");
const taskSchema = require('../../../models/Tasks/Tasks');

router.get('/', async (req, res) => {
    var query = url.parse(req.url, true).query;
    const mentorID = query.mentorID;
    const tasks = await taskSchema.find({mentor : mentorID}).populate('mentor qna discussions submissions').populate({path : 'qna', populate : 'comments raisedBy'}).populate({path : "discussions", populate :"userInfo"}).populate({path : 'submissions', populate : "SubmittedBy"});
    res.json(tasks);
});

module.exports = router;
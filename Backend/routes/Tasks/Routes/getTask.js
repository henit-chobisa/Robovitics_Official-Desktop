const express = require('express');
const router = express.Router();
const url = require("url");
const taskSchema = require('../../../models/Tasks/Tasks');

router.get('/', async (req, res) => {
    var query = url.parse(req.url, true).query;
    const userID = query.userID;
    const tasks = await taskSchema.find({assignedTo : { $eq: userID }}).populate('mentor qna discussions submissions assignedTo').populate({path : 'qna', populate : 'comments raisedBy'}).populate({path : "discussions", populate :"userInfo"}).populate({path : 'submissions', populate : "SubmittedBy"}).exec();
    res.json(tasks);
});

const express = require("express");
const taskSchema = require("../../../models/Tasks/Tasks");
const router = express.Router();
const moment = require('moment');

router.post('/', async (req, res) => {
    const { title, description, lastDate, referencingDocumentLink, bannerLink, mentor, assignedTo, core, isTeamTask, pointsAlloted } = req.body;
    const assignedDate  = moment().format().toString();
    const task = new taskSchema({title, description, lastDate, referencingDocumentLink, bannerLink, mentor, assignedTo, core, isTeamTask, pointsAlloted, assignedDate});
    await task.save();
    res.json(task);
});

module.exports = router;
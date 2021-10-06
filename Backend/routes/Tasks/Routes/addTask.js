const express = require("express");
const taskSchema = require("../../../models/Tasks/Tasks");
const router = express.Router();

router.post('/', async (req, res) => {
    const { title, description, lastDate, referencingDocumentLink, bannerLink, mentor, assignedTo, core, isTeamTask, pointsAlloted } = req.body;

    const task = new taskSchema({title, description, lastDate, referencingDocumentLink, bannerLink, mentor, assignedTo, core, isTeamTask, pointsAlloted});
    await task.save();
    res.json(task);
});

module.exports = router;
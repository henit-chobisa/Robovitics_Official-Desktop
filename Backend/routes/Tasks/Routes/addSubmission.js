const express = require('express');
const taskSchema = require('../../../models/Tasks/Tasks');
const router = express.Router();

router.post('/', async (req, res) => {
    const {taskID, userID, comment, docLink} = req.body;
    console.log("")
    const task = await taskSchema.findById(taskID);
    task.addSubmission(userID, comment, docLink);
    task.save();
    res.json(task);
})

module.exports = router;
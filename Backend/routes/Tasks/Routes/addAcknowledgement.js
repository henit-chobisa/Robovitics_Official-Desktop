const express = require('express');
const taskSchema = require('../../../models/Tasks/Tasks');
const router = express.Router();

router.post('/', async (req, res) => {
    const {taskID, userID } = req.body;
    const task = await taskSchema.findById(taskID);
    task.addAcknowledgement(userID);
    await task.save();
    res.json(task);
});

module.exports = router;
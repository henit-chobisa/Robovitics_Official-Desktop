const express = require('express');
const taskSchema = require('../../../models/Tasks/Tasks');
const router = express.Router();

router.post('/', async (req, res) => {
    const {taskID, question, userID} = req.body;
    const task = await taskSchema.findById(taskID);
    var id = await task.addQuestion(question, userID);
    await task.save();
    res.json(id);
})

module.exports = router;
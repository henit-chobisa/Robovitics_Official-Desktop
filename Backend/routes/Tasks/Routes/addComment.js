const express = require('express');
const qna = require('../../../models/Tasks/qnaModel');
const router = express.Router();

router.post('/', async (req, res) => {
    const { questionID, comment, userID } = req.body;
    const question = await qna.findById(questionID);
    question.addComment(comment, userID);
    await question.save();
    res.send(question);
})

module.exports = router;

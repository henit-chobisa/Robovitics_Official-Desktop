const mongoose = require('mongoose');
const moment = require("moment");
const comment = require('./CommentModel');

const qnaSchema = mongoose.Schema({
    TaskID : {type : mongoose.Schema.Types.ObjectId, ref : "Task"},
    question : String,
    comments : [{type : mongoose.Schema.Types.ObjectId, ref : "Comment"}],
    raisedBy : {type : mongoose.Schema.Types.ObjectId, ref : "UserB"},
    timeStamp : moment().format()
});

qnaSchema.methods.addComment = async function(comment, userID){
    const comment = new comment({comment : comment, commentedBy : userID});
    this.comments.push(comment);
    await comment.save();
}

const qna = mongoose.model("QNA", qnaSchema);
module.exports = qna;
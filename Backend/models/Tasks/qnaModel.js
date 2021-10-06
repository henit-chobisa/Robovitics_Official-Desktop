const mongoose = require('mongoose');
const moment = require("moment");
const comment = require('./CommentModel');
const { Timestamp } = require('bson');

const qnaSchema = mongoose.Schema({
    TaskID : {type : mongoose.Schema.Types.ObjectId, ref : "Task"},
    question : String,
    comments : [{type : mongoose.Schema.Types.ObjectId, ref : "Comment"}],
    raisedBy : {type : mongoose.Schema.Types.ObjectId, ref : "UserB"},
    timeStamp : String
});

qnaSchema.methods.addComment = async function(comment, userID){
    const timeStamp = moment().format().toString();
    const com = new comment({comment : comment, 
        commentedBy : userID, timeStamp : timeStamp});
    this.comments.push(com);
    await comment.save();
}

const qna = mongoose.model("QNA", qnaSchema);
module.exports = qna;
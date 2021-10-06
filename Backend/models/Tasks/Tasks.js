const mongoose = require('mongoose');
const moment = require("moment");
const Submission = require('./Submission');
const DiscussionModel = require('../DiscussionModel');
const qna = require('./qnaModel');

const TaskSchema = mongoose.Schema({
    title : String,
    description : String,
    assignedDate : String,
    lastDate : String,
    refrencingDocumentLink : String,
    bannerLink : String,
    mentor : {type : mongoose.Schema.Types.ObjectId, ref : "UserB"},
    acknowledgedBy : [{type : mongoose.Schema.Types.ObjectId, ref : "UserB"}],
    qna : [{type : mongoose.Schema.Types.ObjectId, ref : "QNA"}],
    assignedTo : [{type : mongoose.Schema.Types.ObjectId, ref : "UserB"}],
    core : String,
    isCompleted : false,
    isTeamTask : Boolean,
    discussions : [{type : mongoose.Schema.Types.ObjectId, ref : "DiscussionModel"}],
    submissions : [{type : mongoose.Schema.Types.ObjectId, ref : "Submission"}],
    pointsAlloted : Number,

}, { collection : "Tasks"});

TaskSchema.methods.changeMentor = async function(userID){
    this.mentor = userID;
}

TaskSchema.methods.addSubmission = async function(UserID, Comment, docLink){
    const Submission = new Submission({SubmittedBy : UserID, Comment : Comment, docLink : docLink, SubmittedOn : moment().format(), isVerified : false});
    this.submissions.push(Submission);
    await Submission.save();
};

TaskSchema.methods.addDiscussion = async function(userID, payload, messageType){
    const Discussion = new DiscussionModel({userInfo : userID, payload : payload, messageType : messageType, timeStamp : moment().format()});
    this.discussions.push(Discussion);
    await Discussion.save();
}

TaskSchema.addAcknowledgement = async function(userID){
    this.acknowledgedBy.push(userID);
}

TaskSchema.methods.updateLastDate = async function(lastDate){
    this.lastDate = lastDate;
}
TaskSchema.methods.completed = async function(){
    this.isCompleted = true;
}

TaskSchema.methods.addQuestion = async function(question, userID){
    const timeStamp = moment().format().toString()
    const ques = new qna({TaskID : this._id, question : question, raisedBy : userID, timeStamp : timeStamp});
    this.qna.push(ques);
    await question.save();
};

const taskSchema = mongoose.model("Task", TaskSchema);
module.exports = taskSchema;
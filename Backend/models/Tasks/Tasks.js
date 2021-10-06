const mongoose = require('mongoose');
const moment = require("moment");

const TaskSchema = mongoose.Schema({
    title : String,
    description : String,
    assignedDate : moment().format(),
    lastDate : String,
    refrencingDocumentLink : String,
    mentor : {type : mongoose.Schema.Types.ObjectId, ref : "UserB"},
    acknowledgedBy : [{type : mongoose.Schema.Types.ObjectId, ref : "UserB"}],
    qna : [{String : [String]}],
    assignedTo : [{type : mongoose.Schema.Types.ObjectId, ref : "UserB"}],
    isCompleted : false,
    isTeamTask : Boolean,
    discussions : [{type : mongoose.Schema.Types.ObjectId, ref : "DiscussionModel"}],
    submissions : [{type : mongoose.Schema.Types.ObjectId, ref : "Submission"}],
    pointsAlloted : Number,

}, { collection : "Tasks"}),

const taskSchema = mongoose.model("Task", TaskSchema);
module.exports = taskSchema;
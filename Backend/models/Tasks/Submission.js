const mongoose = require('mongoose');

const SubmissionSchema = mongoose.Schema({
    TaskID : {type : mongoose.Schema.Types.ObjectId, ref : "Task"},
    SubmittedBy : {type : mongoose.Schema.Types.ObjectId, ref : "UserB"},
    Comment : String,
    docLink : String,
    SubmittedOn : String,
    isVerified : Boolean,
}, { collection : "Submissions"});

const Submission = mongoose.model("Submission", SubmissionSchema);
module.exports = Submission;
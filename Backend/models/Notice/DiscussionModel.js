const mongoose = require("mongoose");

const discussionModel = mongoose.Schema({
    userInfo : {type : mongoose.Schema.Types.ObjectId, ref : "UserB"},
    payload : String,
    messageType : String,
    timeStamp : moment().toString()
});

module.exports = mongoose.model("DiscussionModel", discussionModel);
const mongoose = require("mongoose");
const moment = require("moment");

const discussionModel = mongoose.Schema({
    userInfo : {type : mongoose.Schema.Types.ObjectId, ref : "UserB"},
    payload : String,
    messageType : String,
    timeStamp : String
});
const Model = mongoose.model("DiscussionModel", discussionModel)
module.exports = Model;
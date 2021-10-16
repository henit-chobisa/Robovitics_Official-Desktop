const mongoose = require('mongoose');
const moment = require("moment");
const userBasicSchema = require('../UserBasicModel');

const commentSchema = mongoose.Schema({
    comment : String,
    timeStamp : String,
    commentedBy : userBasicSchema.schema,
})

const comment = mongoose.model("Comment", commentSchema);
module.exports = comment;
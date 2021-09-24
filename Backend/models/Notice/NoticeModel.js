const mongoose = require('mongoose');
const moment = require("moment")
const userB = require('../UserBasicModel');
const userBasicSchema = require('../UserBasicModel');
const DiscussionModel = require('./DiscussionModel');

const NoticeModel = new mongoose.Schema({
    title : String,
    description : String,
    docLink : String,
    timeStamp : String,
    AcknowledgeBy : [userB.schema],
    Discussions : [{type : mongoose.Schema.Types.ObjectId, ref : "DiscussionModel"}]
}, {collection : 'Notices'})t

NoticeModel.methods.addDiscussion = async function(userBID, payload, messageType) {
    const userInfo = await userBasicSchema.findById(userBID);
    const timeStamp = moment().toString();
    const discussion = new DiscussionModel({userInfo, payload, messageType, timeStamp});
    this.Discussions.push(discussion);
    discussion.save();
}

NoticeModel.methods.addAcknowledgement = async function(userBID){
    const userInfo = await userBasicSchema.findById(userBID);
    this.AcknowledgeBy.push(userInfo);
}

module.exports = mongoose.model('NoticeModel', NoticeModel);
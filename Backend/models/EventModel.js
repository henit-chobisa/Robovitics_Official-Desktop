
const mongoose = require('mongoose');
const registrationModel = require('./registrationModel');
const User = require('./User');

const EventSchema = new mongoose.Schema({
    eventTitle : String,
    eventDescription : String,
    eventTime : Date,
    instagramReach : Number,
    instagramTarget : Number,
    facebookTarget : Number,
    facebookReach : Number,
    linkedInTarget : Number,
    linkedInReach : Number,
    registrationTarget : Number,
    totalRegistrations : Number,
    topContributor : { type : mongoose.Schema.Types.ObjectId, ref : "User"},
    eventLogo : String,
    eventImages : [String],
    platformLink : String,
    registrations : [{ type : mongoose.Schema.Types.ObjectId, ref : "registrationModel"}],
    contributors : [{ type : mongoose.Schema.Types.ObjectId, ref : "User"}],
}, {collection : "Events"});

EventSchema.methods.addTopContributor = function(topContributor){
    this.topContributor = topContributor;
}

EventSchema.methods.addEventImages = function(link){
    this.eventImages.push(link);
}

EventSchema.methods.addContributor = function(userID){
    top.contributors.push(userID);
}

EventSchema.methods.addRegistration = async function(attendeeName, contributor, platform){
    const eventID = this._id
    const registration = new registrationModel({eventID, attendeeName, contributor, platform});
    await registration.save();
    this.registrations.push(registration._id);
    this.totalRegistrations = this.registrations.length;
}

EventSchema.methods.updateReaches = function(instaReach,facebookReach, linkedinReach){
    this.instaReach = instaReach;
    this.facebookReach = facebookReach;
    this.linkedInReach = linkedinReach;
}

EventSchema.methods.updateEventTime = function(time) {
    this.eventTime = time;
}

const roboEvent = mongoose.model('roboEvent', EventSchema);
module.exports = roboEvent;
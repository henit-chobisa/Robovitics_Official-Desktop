
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
    eventLogo : String,
    eventImages : [String],
    platformLink : String,
    registrations : [registrationModel.schema],
    topContributor : { type : mongoose.Schema.Types.ObjectId, ref : "User"},
    contributors : [{ type : mongoose.Schema.Types.ObjectId, ref : "User"}],
}, {collection : "Events"});

EventSchema.methods.updateTopContributor = function(){
    var currentTopContributor;
    var count;
    const maxCount = 0;
    for (let i = 0; i < this.registrations.length; i++) {
        count = 1;
        for (let j = i+1; j < this.registrations.length; j++) {
            if (this.registrations[j].contributor == this.registrations[i].contributor){
                count++;
                if(count > maxCount){
                    currentTopContributor = this.registrations[j].contributor;
                }
            }            
        }
    }
    this.topContributor = currentTopContributor;
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
    var findContri = await this.contributors.includes(contributor);
    if (findContri == false){
        this.contributors.push(contributor);
    }
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
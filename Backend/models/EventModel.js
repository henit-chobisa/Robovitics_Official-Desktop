
const mongoose = require('mongoose');
const contributionModel = require('./contributionModel');
const instaPost = require('./postModel');
const registrationModel = require('./registrationModel');
const User = require('./User');
const Instagram = require('instagram-web-api')
const username = "bug_sigabrt";
const password = "111.Dinesh";

const EventSchema = new mongoose.Schema({
    // Event Details
    eventTitle : String,
    eventDescription : String,
    eventTime : Date,
    eventLogo : String,
    eventImages : [String],
    platformLink : String,

    // Instagram Reach and details
    instagramReach : Number,
    instagramTarget : Number,
    instagramPosts : [instaPost.schema],

    // Facebook Reach and Targets
    facebookTarget : Number,
    facebookReach : Number,

    // Linkedin reach and targets
    linkedInTarget : Number,
    linkedInReach : Number,

    // Registratuon Details
    registrationPoints : Number,
    registrationTarget : Number,
    totalRegistrations : Number,
    topContributor : { type : mongoose.Schema.Types.ObjectId, ref : "User"},
    registrations : [{ type : mongoose.Schema.Types.ObjectId, ref : "registrationModel"}],
    contributors : [{ type : mongoose.Schema.Types.ObjectId, ref : "User"}],

}, {collection : "Events"});

// For updating top contributor
EventSchema.methods.addTopContributor = function(topContributor){
    this.topContributor = topContributor;
}

// Adding event images
EventSchema.methods.addEventImages = function(link){
    this.eventImages.push(link);
}

// Adding top contributor
EventSchema.methods.addContributor = function(userID){
    top.contributors.push(userID);
}

EventSchema.methods.addInstapost = function(shortCode){
    const client = new Instagram({ username, password })
    await client.login();
    const media = await client.getMediaByShortcode({shortcode : shortCode});
    const photoURL = media['display_url']
    const likes = media['edge_media_preview_like']['count'];
    const post = new instaPost({shortCode, photoURL, likes});
    this.instagramPosts.push(post);
}

// Adding new registration detail
// will create a registration, will create a contribution -> contribution will update user points and add a contribution, registration is one-one to the event.
EventSchema.methods.addRegistration = async function(attendeeName, contributor, platform){
    const eventID = this._id
    const registration = new registrationModel({eventID, attendeeName, contributor, platform});
    await registration.save();
    const registrationID = registration._id;
    let contribution = new contributionModel({eventID,contributor,points, registrationID});
    const user = await User.findById(contributor);
    const totalpoints = user.points + this.registrationPoints;
    await contribution.save();
    user.updatePoints(totalpoints);
    user.contributions.push(contribution._id);
    await user.save();
    this.registrations.push(registration._id);
    this.totalRegistrations = this.registrations.length;
}

// Updates reacehes on the profile
EventSchema.methods.updateReaches = function(instaReach,facebookReach, linkedinReach){
    this.instaReach = instaReach;
    this.facebookReach = facebookReach;
    this.linkedInReach = linkedinReach;
}

// updates event timings
EventSchema.methods.updateEventTime = function(time) {
    this.eventTime = time;
}

const roboEvent = mongoose.model('roboEvent', EventSchema);
module.exports = roboEvent;
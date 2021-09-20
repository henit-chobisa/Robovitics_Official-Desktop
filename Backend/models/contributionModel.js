const mongoose = require('mongoose');

const contributionModelSchema = new mongoose.Schema({
    eventName : String,
    eventDescription : String,
    eventLogo : String,
    type : String,
    eventID : {type : mongoose.Schema.Types.ObjectId, ref : "roboEvent"},
    contributorID : {type : mongoose.Schema.Types.ObjectId, ref : "User"},
    points : Number,
    registrationDetails : {type : mongoose.Schema.Types.ObjectId, ref : "registrationModel"},
}, {collection : "Contributions"});

const contributionModel = mongoose.model('contributionModel', contributionModelSchema);
module.exports = contributionModel;
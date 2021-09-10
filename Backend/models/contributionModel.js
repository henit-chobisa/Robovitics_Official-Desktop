const mongoose = require('mongoose');

const contributionModelSchema = new mongoose.Schema({
    eventID : {type : mongoose.Schema.Types.ObjectId, ref : "Event"},
    contributorID : {type : mongoose.Schema.Types.ObjectId, ref : "User"},
    points : Number,
    registrationDetails : [{type : mongoose.Schema.Types.ObjectId, ref : "registrationModel"}],
}, {collection : "Contributions"});

const contributionModel = mongoose.model('contributionModel', contributionModelSchema);
module.exports = contributionModel;
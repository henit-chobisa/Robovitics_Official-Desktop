const mongoose = require('mongoose');

const contributionModelSchema = new mongoose.Schema({
    contributorID : {type : mongoose.Schema.Types.ObjectId, ref : "User"},
    contributions : Number,
    registrationDetails : [{type : mongoose.Schema.Types.ObjectId, ref : "registrationModel"}],
}, {collection : "Contributions"});

const contributionModel = mongoose.model('contributionModel', contributionModelSchema);
module.exports = contributionModel;
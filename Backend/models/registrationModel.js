const mongoose = require('mongoose');

const registrationModelSchema = new mongoose.Schema({
    contributorName : String,
    contributorImage : String,
    contributorCore : String,
    contributorYOJ : String,
    EventID : {type : mongoose.Schema.Types.ObjectId, ref : "roboEvent"},
    attendeeName : String,
    contributor : {type : mongoose.Schema.Types.ObjectId, ref : "User"},
    platform : String,
}, {collection : "Registrations"});

const registrationModel = mongoose.model('registrationModel', registrationModelSchema);

module.exports = registrationModel;
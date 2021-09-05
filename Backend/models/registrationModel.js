const mongoose = require('mongoose');

const registrationModelSchema = new mongoose.Schema({
    EventID : {type : mongoose.Schema.Types.ObjectId, ref : "roboEvent"},
    attendeeName : String,
    contributor : {type : mongoose.Schema.Types.ObjectId, ref : "User"},
    Platform : String,
}, {collection : "Registrations"});

const registrationModel = mongoose.model('registrationModel', registrationModelSchema);

module.exports = registrationModel;
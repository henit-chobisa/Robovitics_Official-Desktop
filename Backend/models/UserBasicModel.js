const mongoose = require('mongoose');
const userBasic = mongoose.Schema({
    userID : String,
    userName : String,
    photoURL : String,
    email : String,
    core : String,
});

const userBasicSchema = mongoose.model('UserB', userBasic);
module.exports = userBasicSchema;
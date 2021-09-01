const mongoose = require('mongoose');
const jwt = require('jsonwebtoken');
const ReferenceUser = require('./referenceUserModel');
const User = require('./User');

const referenceTokenSchema = mongoose.Schema({
    referenceToken : String
}, { collection : "ReferenceTokens"})

referenceTokenSchema.methods.generateToken = function(userID, referenceUserID){
    try {
        var currentUser = await User.findById(userID);
        var referUser = await ReferenceUser.findById(referenceUserID);
        if (currentUser.core != "Board"){
            console.log("User is not eligible for generating reference token");
            return -1;
        }
        else if (referUser == null){
            return -2;
        }
        else {
            generatedreferenceToken = jwt.sign({ refererID : userID, referenceUserID : referenceUserID }, process.env.referenceTokenSecret);
            this.referenceToken = generatedreferenceToken;
            return 1;
        }
    }
    catch(err){
        console.log(err)
        return -10;
    }
};

const referenceToken = mongoose.model('ReferenceToken', referenceTokenSchema);
module.exports = referenceToken;






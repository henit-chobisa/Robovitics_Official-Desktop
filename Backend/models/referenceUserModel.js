const mongoose = require('mongoose');
const crypto = require('crypto');

const referenceUserModel = new mongoose.Schema({
    email: String,
    hash: String,
    salt: String,
    firstName: String,
    lastName: String,
    photoURL: String,
    department: String,
    phoneNumber: { type: String, maxlength: 13, minlength: 13 },
    designation: String,
    core : String,
    yearOfJoining: String,
}, {collection : "ReferenceUser"});

referenceUserModel.methods.setPassword = function(password){
    try {
        this.salt = crypto.randomBytes(32).toString('hex');
        this.hash = crypto.pbkdf2Sync(password, this.salt, 10000, 512, 'sha512').toString('hex');
        return 1;
    }
    catch(err){
        throw err;
    }
};

const ReferenceUser = mongoose.model('ReferenceUser', referenceUserModel);
module.exports = ReferenceUser;
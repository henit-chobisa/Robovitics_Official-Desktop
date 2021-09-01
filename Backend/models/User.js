const mongoose = require('mongoose');
const crypto = require('crypto');
const jwt = require('jsonwebtoken');
const TokenBlock = require('./tokens');

const UserSchema = new mongoose.Schema({
    email: String,
    hash: String,
    salt: String,
    firstName: String,
    lastName: String,
    photoURL: String,
    department: String,
    phoneNumber: { type: String, maxlength: 13, minlength: 13 },
    role: String,
    yearOfJoining: String,
    tokenBlock: { type: mongoose.Schema.Types.ObjectId, ref: "TokenBlock" }
}, { collection: 'Users' });

UserSchema.methods.setPassword = function (password) {
    try {
        this.salt = crypto.randomBytes(32).toString('hex');
        this.hash = crypto.pbkdf2Sync(password, this.salt, 10000, 512, 'sha512').toString('hex');
    }
    catch (err) {
        console.log(err);
    }
};

UserSchema.methods.updatePhotoURL = function (photoURL) {
    try {
        this.photoURL = photoURL;
    }
    catch (e) {
        console.log(e);
    }
};

UserSchema.methods.updateRole = function (role) {
    try { this.role = role }
    catch (e) { console.log(e) }
};

UserSchema.methods.updatePhoneNumber = function (phoneNumber) {
    try {
        this.phoneNumber = phoneNumber;
        return true;
    }
    catch (err) {
        console.log(err);
        return false;
    }
}

UserSchema.methods.updateEmail = function (email) {
    this.email = email;
}

UserSchema.methods.updatePassword = function (oldPassword, newPassword) {
    const passVerification = this.validatePassword(oldPassword);
    if (passVerification == true) {
        this.setPassword(newPassword);
        return true;
    }
    else {
        return false;
    }
};


UserSchema.methods.validatePassword = function (password) {
    try {
        const hash = crypto.pbkdf2Sync(password, this.salt, 10000, 512, 'sha512').toString('hex');
        return this.hash == hash;
    }
    catch (err) {
        console.log(err);
    }
};

UserSchema.methods.generateJWT = function () {
    const today = new Date();
    const expirationDate = new Date(today);
    expirationDate.getDate(today.getTime() + 60);
    const accessToken = jwt.sign({ email: this.email, id: this._id, exp: parseInt(expirationDate.getTime() / 1000, 10) }, process.env.accessTokenSecret);
    const refreshToken = jwt.sign({ email: this.email, id: this._id, exp: parseInt(expirationDate.getTime() / 100, 10) }, process.env.refreshTokenSecret);
    const tokenBlock = new TokenBlock({ accessToken, refreshToken });
    this.tokenBlock = tokenBlock._id;
    tokenBlock.save();
    return tokenBlock;
};

UserSchema.methods.toAuthJSON = function () {
    return {
        _id: this.id,
        email: this.email,
        token: this.generateJWT(),
    };
};

const User = mongoose.model('User', UserSchema);
module.exports = User;


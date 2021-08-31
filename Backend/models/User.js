const mongoose = require('mongoose');
const crypto = require('crypto');
const jwt = require('jsonwebtoken');
const TokenBlock = require('./tokens');

const UserSchema = new mongoose.Schema({
    email : String,
    hash : String,
    salt : String,
    tokenBlock : {type : mongoose.Schema.Types.ObjectId, ref : "TokenBlock"}
}, {collection : 'Users'});

UserSchema.methods.show = function(){
    console.log(this.email, this.password);
};

UserSchema.methods.createUser = function(email, password){
    this.email = email,
    this.setPassword(password)
    return this;
}

UserSchema.methods.setPassword = function(password){
    try{
        this.salt = crypto.randomBytes(32).toString('hex');
        this.hash = crypto.pbkdf2Sync(password, this.salt, 10000, 512, 'sha512').toString('hex');
    }
    catch(err){
        console.log(err);
    }
}

UserSchema.methods.validatePassword = function(password){
    try{
        const hash = crypto.pbkdf2Sync(password, this.salt, 10000, 512,'sha512').toString('hex');
        return this.hash == hash;
    }
    catch(err){
        console.log(err);
    }
};

UserSchema.methods.generateJWT = function(){
    const today = new Date();
    const expirationDate = new Date(today);
    expirationDate.getDate(today.getTime() + 60);
    const accessToken = jwt.sign({email : this.email, id : this._id, exp : parseInt(expirationDate.getTime()/1000,10)}, process.env.accessTokenSecret);
    const refreshToken = jwt.sign({email : this.email, id : this._id, exp : parseInt(expirationDate.getTime()/100,10)}, process.env.refreshTokenSecret);
    const tokenBlock = new TokenBlock({accessToken, refreshToken});
    this.tokenBlock = tokenBlock._id;
    tokenBlock.save();
    return tokenBlock;
};

UserSchema.methods.toAuthJSON = function(){
    return {
        _id : this.id,
        email : this.email,
        token : this.generateJWT(),
    };
};

const User = mongoose.model('User', UserSchema);
module.exports = User;


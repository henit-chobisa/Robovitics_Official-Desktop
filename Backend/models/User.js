const mongoose = require('mongoose');
const crypto = require('crypto');
const jwt = require('jsonwebtoken');

const UserSchema = new mongoose.Schema({
    email : String,
    hash : String,
    salt : String,

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

// UserSchema.method({
//     setPassword : function(password){
        
//     }
// })

// UserSchema.method('setPassword', function(password){
//     this.salt = crypto.randomBytes(32).toString('hex');
//     this.hash = crypto.pbkdf2(password, this.salt, 10000, 512, 'sha512').toString('hex');
// });

UserSchema.methods.validatePassword = function(password){
    const hash = crypto.pbkdf2Sync(password, this.salt, 10000, 512,'sha512').toString('hex');
    return this.hash == hash;
};

UserSchema.methods.generateJWT = function(){
    const today = new Date();
    const expirationDate = new Date(today);
    expirationDate.getDate(today.getDate() + 60);
    return jwt.sign({email : this.email, id : this._id, exp : parseInt(expirationDate.getTime()/1000,10)}, 'secret');
};

UserSchema.methods.toAuthJSON = function(){
    return {
        _id : this.id,
        email : this.email,
        token : this.generateJWT(),
    };
};

UserSchema.methods.prick = function(email){
    console.log(email)
}

const User = mongoose.model('User', UserSchema);
module.exports = User;


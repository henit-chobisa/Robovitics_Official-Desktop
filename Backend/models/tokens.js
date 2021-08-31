const jwt = require('jsonwebtoken');
const mongoose = require('mongoose');
const User = require('./User');

const tokenSchema = new mongoose.Schema({
    accessToken : String,
    refreshToken : String
}, {collection : 'Tokens'})

tokenSchema.methods.getNewToken = function(refreshToken, user){
    try
    {
        const tokenBlock = tokenSchema.findOne({refreshToken});
        if (tokenBlock == null){
            return 0
        }
        else {
            return user.toAuthJson();
        }
    }
    catch (error)
    {
        console.log(error);
    }
    
}

const TokenBlock = mongoose.model('TokenBlock', tokenSchema);
module.exports = TokenBlock;
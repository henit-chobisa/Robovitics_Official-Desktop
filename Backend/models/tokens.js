const jwt = require('jsonwebtoken');
const mongoose = require('mongoose');

const tokenSchema = new mongoose.Schema({
    accessToken : String,
    refreshToken : String
}, {collection : 'Tokens'})

tokenSchema.methods.getNewToken = function(refreshToken){
    try
    {
        const tokenBlock = tokenSchema.findOne({refreshToken});
        if (tokenBlock == null){
            return false
        }
        else {
            
        }
    }
    catch (error)
    {
        console.log(error);
    }
    
}

const TokenBlock = mongoose.model('TokenBlock', tokenSchema);
module.exports = TokenBlock;
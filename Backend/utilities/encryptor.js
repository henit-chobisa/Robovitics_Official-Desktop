const crypto = require('crypto');

const encrypt = async (password) => {
    try{
        const salt = crypto.randomBytes(16).toString('hex');
        const hash = crypto.pbkdf2Sync(password, salt, 10000, 512, 'sha512').toString('hex');
        return [salt, hash];
    }
    catch(err){
        console.log(err);
    }
}

module.exports = encrypt;
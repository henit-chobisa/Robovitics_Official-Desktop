const express = require('express');
const TokenBlock = require('../../../models/Authentication/tokens');
const User = require('../../../models/Authentication/User');
const router = express.Router();

router.post('/', async (req, res) => {
    const {email, password} = req.body;
    let user = await User.findOne({ email }).populate('tokenBlock').exec();
    console.log(user);
    if (user == null){
        res.send("Sorry, this user doesn't exist");
    }
    else {
        const validation = await user.validatePassword(password);
        if (validation == true){
            const oldAccessToken = user.tokenBlock.accessToken;
            const oldTokenBlock = await TokenBlock.findOne({oldAccessToken});
            oldTokenBlock.remove();
            await user.generateJWT();
            await user.save();
            user = await User.findOne({ email }).populate('tokenBlock').exec()
            res.json(user.fetch());
        }
        else {
            res.send("Sorry, password missmatch");
        }
    }
});

module.exports = router;
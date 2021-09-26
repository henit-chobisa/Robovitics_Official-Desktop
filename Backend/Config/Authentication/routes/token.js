const express = require('express');
const User = require('../../../models/Authentication/User');
const router = express.Router();
const dotenv = require('dotenv');
const TokenBlock = require('../../../models/Authentication/tokens');
const jwt = require('jsonwebtoken');

router.post('/', async (req, res) => {
    const { refreshToken } = req.body;
    if (!refreshToken){
        return res.sendStatus(403).send("Token Doesn't exist");
    }

    const tokenBlock = await TokenBlock.findOne({ refreshToken});
    if (tokenBlock == null){
        res.sendStatus(403).send("Sorry, this is an invali token");
    }

    jwt.verify(refreshToken, process.env.refreshTokenSecret, async (err, user) => {
        if (err){
            return res.sendStatus(307);
        }
        let email = user.email;
        let currentUser = await User.findOne({email});
        let newTokenBlock = currentUser.generateJWT();
        currentUser.save();
        tokenBlock.remove();
        res.json(newTokenBlock);
    });
});

module.exports = router;
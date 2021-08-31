const express = require('express');
const User = require('../../../models/User');
const router = express.Router();
const dotenv = require('dotenv')

router.post('/', async (req, res) => {
    const { email, password } = req.body;
    let user = await User.findOne({email});
    if (user == null){
        res.send("Sorry, this user doesn't exist");
    }
    else {
        const validation = await user.validatePassword(password);
        if (validation == true){
            res.json(user);
        }
        else {
            res.send("Sorry, password missmatch");
        }
    }
})

module.exports = router;
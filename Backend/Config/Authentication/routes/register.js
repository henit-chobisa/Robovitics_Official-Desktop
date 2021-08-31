const express = require('express');
const User = require('../../../models/User');
const router = express.Router();

router.post('/', async (req , res) => {
    const {email, password} = req.body;
    let user = await User.findOne({email});
    if (user == null){
        const user = User({email});
        await user.setPassword(password);
        user.save();
    }
    else {
        res.send("Sorry, user already exist, kindly log in");
    }
})

module.exports = router
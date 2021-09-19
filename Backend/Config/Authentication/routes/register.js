const express = require('express');
const User = require('../../../models/User');
const router = express.Router();

router.post('/', async (req , res) => {
    const { email, password , phoneNumber, firstName , lastName, photoURL, core, designation , department , yearOfJoining } = req.body;
    let user = await User.findOne({email});
    const points = 0;
    const contributions = [];
    if (user == null){
        const user = User({email, firstName , 
            core, designation,lastName , department ,phoneNumber,yearOfJoining, points, contributions, photoURL});
        await user.setPassword(password);
        const tokenBlock = await user.generateJWT();
        await user.save();
        res.json(["User Successfully registered",tokenBlock]);
    }
    else {
        res.send("Sorry, user already exist, kindly log in");
    }
})

module.exports = router
const express = require('express');
const User = require('../../../models/User');
const router = express.Router();

router.post('/', async (req , res) => {
    const { email, password , phoneNumber, firstName , lastName , department , yearOfJoining } = req.body;
    let user = await User.findOne({email});
    if (user == null){
        const user = User({email, firstName , lastName , department ,phoneNumber,yearOfJoining});
        await user.setPassword(password);
        await user.updatePhotoURL("https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png");
        const tokenBlock = await user.generateJWT();
        await user.save();
        res.json(["User Successfully registered",{ "accessID" : accessID },tokenBlock]);
    }
    else {
        res.send("Sorry, user already exist, kindly log in");
    }
})

module.exports = router
const express = require('express');
const User = require('../../../models/User');
const encryptor = require('../../../utilities/encryptor');
const router = express.Router();

router.post('/', async (req, res) => {
    const { email, password } = req.body;
    let user = await User.findOne({email});
    if (user == null){
        const user = User({email});
        await user.setPassword(password);
        user.save();
        res.send("Hello Hello");
        // console.log(password);
        // const result = await encryptor(password);
        // console.log(result[0]);
        // res.send("Sorry, there is no user like that");
    }
    else {
        
        // user = new User({email, encrytedPassword, encrytedPassword[salt]});
        // user.save();
    }
})

module.exports = router;
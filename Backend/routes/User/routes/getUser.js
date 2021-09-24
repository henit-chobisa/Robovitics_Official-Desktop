const express = require("express");
const User = require("../../../models/Authentication/User");
const router = express.Router();

router.get('/', async (req, res) => {
    const userID = req.params.userID;
    const user = await User.findById(userID);
    if (user == null){
        res.sendStatus(404);
    }
    else{
        res.json(user.fetch());
    }
});


module.exports = router;
const express = require("express");
const roboEvent = require("../../../models/EventModel");
const router = express.Router();
const User = require("../../../models/User")

router.post('/', async(req, res) => { 
    const {userID} = req.body;
    var user = await User.findById(userID).populate('contributions').exec();
    console.log(user)
    res.json(user);
});

module.exports = router;
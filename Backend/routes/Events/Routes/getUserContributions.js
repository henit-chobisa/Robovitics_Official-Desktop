const express = require("express");
const roboEvent = require("../../../models/Events/EventModel");
const router = express.Router();
const url = require('url');
const User = require("../../../models/Authentication/User")

router.get('/', async(req, res) => { 
    var url_parts = url.parse(req.url, true);
    var query = url_parts.query;
    var userID = query.userID;
    var user = await User.findById(userID).populate('contributions').exec();
    res.json(user['contributions']);
});

module.exports = router;
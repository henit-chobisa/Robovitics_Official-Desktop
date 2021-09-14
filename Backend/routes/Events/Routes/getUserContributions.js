const express = require("express");
const roboEvent = require("../../../models/EventModel");
const router = express.Router();

router.get('/', async(req, res) => { 
    const {userID} = req.body;
    var events = roboEvent.find({})
})
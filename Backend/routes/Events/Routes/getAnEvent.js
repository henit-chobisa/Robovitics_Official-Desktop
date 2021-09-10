const express = require('express');
const roboEvent = require('../../../models/EventModel');
const router = express.Router();

router.get('/', async (req, res) => {
    const {eventID} = req.params.eventID;
    var event = roboEvent.findById(eventID);
    if (event == null){
        res.sendStatus(400);
    }
    else {
        res.json(event);
    }
    
})

module.exports = router
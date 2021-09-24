const express = require('express');
const roboEvent = require('../../../models/Events/EventModel');
const router = express.Router();

router.post('/', async (req, res) => {
    const {eventID, photoURL} = req.body;
    const event = roboEvent.findById(eventID);
    if (event == null){
        res.sendStatus(404);
    } 
    else {
        event.addEventImages(photoURL);
        event.save();
    }
})

module.exports = router;
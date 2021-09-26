const express = require('express');
const roboEvent = require('../../../models/Events/EventModel');
const router = express.Router();

router.post('/', async (req, res) => {
    const {eventTitle, eventDescription, eventTime, instagramTarget, facebookTarget, linkedInTarget, registrationTarget, platformLink, registrationPoints, goals, eventImages} = req.body;
    var event = await roboEvent.findOne({eventTitle});
    if (event == null){
        event = new roboEvent({eventTitle, eventDescription,eventTime, instagramTarget, facebookTarget, linkedInTarget, registrationTarget, platformLink, registrationPoints, goals, eventImages})
        event.save();
        res.json(event);
    }
    else {
        res.sendStatus(500);
    }
})


module.exports = router;
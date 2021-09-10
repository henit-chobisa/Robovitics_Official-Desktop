const express = require('express');
const roboEvent = require('../../../models/EventModel');
const router = express.Router();

router.post('/', async (req, res) => {
    const {eventTitle, eventDescription, eventTime, instagramTarget, facebookTarget, linkedInTarget, registrationTarget, platformLink} = req.body;
    var event = await roboEvent.findOne({eventTitle});
    if (event == null){
        event = new roboEvent({eventTitle, eventDescription,eventTime, instagramTarget, facebookTarget, linkedInTarget, registrationTarget, platformLink})
        event.save();
        res.json(event);
    }
    else {
        res.sendStatus(500);
    }
})


module.exports = router;
const express = require('express');
const roboEvent = require('../../models/EventModel');
const router = express.Router();

router.post('/', async (req, res) => {
    const {eventID, attendeeName, contributor, platform} = req.body;
    const event = await roboEvent.findById(eventID);
    if (event == null){
        res.sendStatus(404);
    }
    else {
        await event.addRegistration(attendeeName, contributor, platform);
        await event.updateTopContributor();
        await event.save();
        res.send(event);
    }

})

module.exports = router;
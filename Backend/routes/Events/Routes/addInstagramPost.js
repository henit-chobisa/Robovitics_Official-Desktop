const express = require('express');
const roboEvent = require('../../../models/EventModel');
const router = express.Router();

router.post('/', async(req, res) => {
    const {eventID, shortcode} = req.body;
    const event = await roboEvent.findById(eventID);
    if (event == null){
        res.sendStatus(404);
    }
    else {
        await event.addInstapost(shortcode);
        await event.save();
        res.send("Instagram Post Added");
    }
});

module.exports = router;
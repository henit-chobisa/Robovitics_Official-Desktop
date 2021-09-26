const express = require('express');
const roboEvent = require('../../../models/Events/EventModel');

const router = express.Router();

router.get('/', async(req, res) => {
    const events = await roboEvent.find().populate('topContributor instagramPosts contributors registrations').populate({
        path : 'topContributor',
        populate : "contributions"
    }).populate({
        path : 'contributors',
        populate : "contributions"
    }).exec();
    
    // events.forEach(async (event) => {
    //     await event.populate('topContributor.contributions');
    // })
    
    if (events == null){
        res.status(400);
    }
    else {
        res.json(events);
    }
})

module.exports = router;
const express = require('express');
const roboEvent = require('../../../models/EventModel');

const router = express.Router();

router.get('/', async(req, res) => {
    const events = await roboEvent.find().populate('topContributor', 'contributors');
    if (events == null){
        res.status(400);
    }
    else {
        res.json(events);
    }
})

module.exports = router;
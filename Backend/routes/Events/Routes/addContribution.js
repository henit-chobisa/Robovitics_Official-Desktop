const express = require('express');
const roboEvent = require('../../../models/Events/EventModel');
const router = express.Router();

router.post('/', async (req, res) => {
    const {eventID, attendeeName, contributor, platform, type} = req.body;
    const event = await roboEvent.findById(eventID).populate(['registrations']);
    if (event == null){
        res.sendStatus(404);
    }
    else {
        
        const topContributor = await findTopContributor(event.registrations);
        if (!event.contributors.includes(contributor)){
            event.addContributor(contributor);
        }
        
        await event.addTopContributor(topContributor);
        await event.addRegistration(attendeeName, contributor, platform, type);
        await event.save();
        res.send(event);
    }
})

function findTopContributor(registrations){
    var topContributor, count;
    var maxcount = 0;
    for (let i = 0; i < registrations.length; i++) {
        count = 1;
        for (let j = 0; j < registrations.length; j++) {
            if (registrations[i]['contributor'] = registrations[j]['contributor']){
                count++;
                if (count > maxcount){
                    topContributor = registrations[j]['contributor']
                }
            }
        }
        
    }
    return topContributor;
}

module.exports = router;
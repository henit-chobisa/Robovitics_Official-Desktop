const express = require('express');
const registrationModel = require('../../../models/Events/registrationModel');
const router = express.Router();
const url = require('url');

router.get('/', async (req, res) => {
    var url_parts = url.parse(req.url, true);
    var query = url_parts.query;
    const registrationID = query.registrationID;
    const registration = await registrationModel.findById(registrationID);
    if (registration == null){
        res.sendStatus(400);
    }
    else {
        console.log(registration);
        res.json(registration);
    }
})

module.exports = router;
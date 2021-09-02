const express = require('express');
const ReferenceToken = require('../../../models/referenceTokenModel');
const router = express.Router();

router.post('/', async(req, res) => {
    const {userID, referenceUserID} = req.body;
    const referenceToken = new ReferenceToken();
    const response = await referenceToken.generateToken(userID, referenceUserID);
    if (response == -1) {
        res.send('You are not an eligible user to generate a refrence token');
    }
    else if (response == -2){
        res.send("Sorry, nobody applied for this referenceID");
    }
    
    else if (response == 1){
        await referenceToken.save();
        res.json(referenceToken);
    }
    else{
        console.log(response);
        res.send("Sorry, internal error");
    }
});

module.exports = router;
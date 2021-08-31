const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.json({
        "data" : "Robovitics-Official Servers running successfullly",
        "metadata" : {
            "success" : true,
            "status" : 200,
            "timeStamp" : Date()
        }});
});

module.exports = router;

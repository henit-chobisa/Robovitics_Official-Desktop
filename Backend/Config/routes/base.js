const express = require('express');
const router = express.Router();

router.get("/", (req, res) => {
    const body = {
        "data" : "Hiii there, this is Henit Chobisa and this backend is a summer project for robovitics VIT Vellore, you can access the documentation via ...",
        "metadata" : {
            "success" : true,
            "status" : res.statusCode,
            "timeStamp" : Date()
        }
    }
    res.json(body);
})

module.exports = router
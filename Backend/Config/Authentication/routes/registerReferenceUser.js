const express = require('express');
const ReferenceUser = require('../../../models/Authentication/referenceUserModel');
const router = express.Router();

router.post('/', async(req, res) => {
    const { email, password, firstName, lastName, photoURL, department,phoneNumber,designation, core, yearOfJoining } = req.body;

    const referenceUser = new ReferenceUser({email, firstName, lastName, photoURL, department, designation, core, yearOfJoining, phoneNumber});
    const response = await referenceUser.setPassword(password);
    if (response == 1){
        referenceUser.save();
    }
    res.json({'status' : "User Added"})
})

module.exports = router;
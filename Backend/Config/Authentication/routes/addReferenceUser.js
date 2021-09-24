const User = require('../../../models/User')
const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const ReferenceToken = require('../../../models/Authentication/referenceTokenModel');
const ReferenceUser = require('../../../models/referenceUserModel');

router.post('/', async(req, res) => {
    const { referenceTokenID } = req.body
    const getterReferenceToken = await ReferenceToken.findById(referenceTokenID);
    if (getterReferenceToken == null){
        res.status(404);
        res.json({
            'status' : "Sorry no token generated like that"});
    }
    else {
        jwt.verify(getterReferenceToken.referenceToken, process.env.referenceTokenSecret, async(err, result) => {
            if (err){
                console.log(err);
                return res.sendStatus(403);
            }
            let referenceUserID = result.referenceUserID;
            const referenceUser = await ReferenceUser.findById(referenceUserID);
            const email = referenceUser.email;
            const firstName = referenceUser.firstName;
            const lastName = referenceUser.lastName;
            const department = referenceUser.department;
            const yearOfJoining = referenceUser.yearOfJoining;
            const salt = referenceUser.salt;
            const hash = referenceUser.hash;
            const designation = referenceUser.designation;
            const core = referenceUser.core;
            const phoneNumber = referenceUser.phoneNumber;
            const photoURL = referenceUser.photoURL;
            const points = 0;
            const contributions = [];
            const user = new User({email, firstName, lastName, department, yearOfJoining, salt, hash, designation, core, phoneNumber, photoURL, points, contributions });
            user.generateJWT();
            await user.save();
            await getterReferenceToken.remove();
            await referenceUser.remove();
            res.json(user.fetch());
        })
    }
})

module.exports = router;


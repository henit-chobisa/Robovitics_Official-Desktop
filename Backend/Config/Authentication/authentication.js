const express = require('express');
const authenticationmiddleware = require('../../middleware/tokenverification')
const router = express.Router()

router.use('/login', require('./routes/login'));
router.use('/token', require('./routes/token'));
router.use('/registerRefUser', require('./routes/registerReferenceUser'));
router.use('/addRefUser', require('./routes/addReferenceUser'));
router.use('/getReferenceToken',authenticationmiddleware ,require('./routes/referenceToken'));
router.use('/regUser', require('./routes/register'))

module.exports = router;

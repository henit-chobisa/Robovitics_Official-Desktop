const mongoose = require('mongoose');

const concentModel = new mongoose.Schema({
    Concent : String,
    Upvotes : Number,
    Downvotes : Number,
})

const Concent = mongoose.model('Concent', concentModel);

module.exports = Concent;
const mongoose = require('mongoose');
const postModel = new mongoose.Schema({
    shortCode : String,
    likesCount : Number,
    photoURL : String,
});

const instaPost = mongoose.model('InstaPost', postModel);
module.exports = instaPost;
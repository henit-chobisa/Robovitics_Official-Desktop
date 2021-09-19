const mongoose = require('mongoose');
const goalSchema = new mongoose.Schema({
    Goal : String,
    points : Number,
}, {collection : "Goals"});

const goal = mongoose.model("Goal", goalSchema);
module.exports = goal;
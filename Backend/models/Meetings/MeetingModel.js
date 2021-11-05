const mongoose = require("mongoose");
const MeetingModel = mongoose.Schema({
  Title : String,
  Description : String,
});

const Meeting = mongoose.model(  "Meeting", MeetingModel);
module.exports = Meeting;

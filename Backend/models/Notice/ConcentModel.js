const mongoose = require('mongoose');

const concentModel = new mongoose.Schema({
    Concent : String,
    UpvotedBy : [{type : mongoose.Schema.Types.ObjectId, ref : 'UserB'}],
    DownvotedBy : [{type : mongoose.Schema.Types.ObjectId, ref : 'UserB'}],
    Upvotes : Number,
    Downvotes : Number,
});

concentModel.methods.addUpvote = async function (UserID){
    this.Upvotes = this.Upvotes + 1;
    this.UpvotedBy.push(UserID);
}
concentModel.methods.addDownvote = async function(UserID){
    this.Downvotes = this.Downvotes + 1;
    this.DownvotedBy.push(UserID);
}

const Concent = mongoose.model('Concent', concentModel);

module.exports = Concent;
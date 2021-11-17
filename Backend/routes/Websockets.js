
const express = require('express');
const DiscussionModel = require('../models/DiscussionModel');
const NoticeModel = require('../models/Notice/NoticeModel');
module.exports = function(io){
    const router = express.Router();
    io.on('connection', async function(socket) {
        console.log('connected');
        var currentRoom = socket.handshake.query.roomID;
        console.log(currentRoom);
        socket.join(currentRoom);
        var notice = await NoticeModel.findById(currentRoom);
        socket.on('text', async function(message){
            socket.in(currentRoom).emit('text', message)
            var userInfo = message['userInfo']['_id'];
            var payload = message['payload'];
            var messageType = message['messageType'];
            var timeStamp = message['timeStamp'];
            var discussion = new DiscussionModel({userInfo, payload, messageType, timeStamp});
            notice.Discussions.push(discussion);
            await notice.save();
        });
    });
    return router;
};

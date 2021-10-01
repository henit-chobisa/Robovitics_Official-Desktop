
const express = require('express');
module.exports = function(io){
    const router = express.Router();
    io.on('connection', function(socket){
        console.log('connected');
        var currentRoom = socket.handshake.query.roomID;
        console.log(currentRoom);
        socket.join(currentRoom);
        socket.on('text', function(message){
            socket.in(currentRoom).emit('text', message)
        })
        
    })
    return router;
};

const express = require('express');
module.exports = function(io){
    const router = express.Router();
    // var io = router.get('socketio');
    io.on('connection', function(socket){
        console.log('connected');
        var currentRoom = socket.handshake.query.roomID;
        console.log(currentRoom);
        socket.join(currentRoom);
        socket.on('sendMessage', message => {
            socket.emit('text', message)
        })
        socket.on('text', function(message){
            console.log(message);
        })
        socket.on('message', (msg)=>{
            socket.in(currentRoom).emit('text', msg);
        })
        
    })
    return router;
};
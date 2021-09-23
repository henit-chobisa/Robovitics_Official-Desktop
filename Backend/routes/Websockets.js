
const express = require('express');
module.exports = function(io){
    const router = express.Router();
    // var io = router.get('socketio');
    io.on('connection', function(socket){
        console.log('connected');
        console.log(socket.id)
        socket.on('broadcast', function(socket){
            io.emit('message', "hello hello")
        });
        socket.on('message', function(message){
            const data = {
                "Name" : "Robo Official",
                "Date" : "September 24th"
            }
            console.log(message);
            io.emit('broadcast', "I am ATC");
        });
        
    })
    return router;
};
const { json } = require("express");

const sockets = function(io){
    io.on('connection', function(socket){
        console.log('connected');
        socket.on('message', function(message){
            console.log(message['Name']);
            const data = {
                "Name" : "Robo Official",
                "Date" : "September 24th"
            }
            // socket.send("hey client I am ATC");
            socket.emit("message",data);
        })
    })
}

module.exports = sockets;
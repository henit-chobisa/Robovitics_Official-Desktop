const express = require('express')
const cors = require('cors');
const dotenv = require('dotenv');
dotenv.config();
const app = express();
var http = require('http');
var server = http.createServer(app);
var io = require('socket.io').listen(server);
var file1 = require('./routes/Websockets')(io);

const db = require('./Config/Database');

const User = require('./models/User');
const mongoose = require('mongoose');


const port = process.env.PORT || 1000;
app.use(express.json());
app.use(cors());
db();
app.get('/', (req, res) => {
    res.send('Hello this is robo official');
});

app.use('/api/verification', require('./Config/Verification/verification'));

app.use('/api/authentication', require('./Config/Authentication/authentication'));

app.use('/api/events', require('./routes/Events/Event'));

app.use('/api/user', require('./routes/User/user'));

// io.on('connection', function(socket){
//     console.log('connected');
// })

// server.listen(80);
// app.listen(port, () => console.log(`Deployed on port ${port}`));
server.listen(port, () => { console.log(`Deployed on port ${port}`)});

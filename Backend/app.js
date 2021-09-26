const express = require('express')
const cors = require('cors');
const dotenv = require('dotenv');
const moment = require("moment");
dotenv.config();
const app = express();
var http = require('http');
var server = http.createServer(app);
var io = require('socket.io')(server);
const db = require('./Config/Database');
db()
console.log(moment().format());
const port = process.env.PORT || 1000;
app.use(express.json());
app.use(cors());

app.use('/api/verification', require('./Config/Verification/verification'));

app.use('/api/authentication', require('./Config/Authentication/authentication'));

app.use('/api/events', require('./routes/Events/Event'));

app.use('/api/user', require('./routes/User/user'));

app.use('/api/notice', require('./routes/Notice/Notice'));

app.use(require('./routes/Websockets')(io));

server.listen(port, () => { console.log(`Deployed on port ${port}`)});
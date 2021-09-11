const express = require('express')
const cors = require('cors');
const dotenv = require('dotenv');
dotenv.config();
const db = require('./Config/Database');
const app = express();
const User = require('./models/User');
const mongoose = require('mongoose');


const port = process.env.PORT || 1000;
app.use(express.json());
app.use(cors());
db();

app.use('/api/verification', require('./Config/Verification/verification'));

app.use('/api/authentication', require('./Config/Authentication/authentication'));

app.use('/api/events', require('./routes/Events/Event'));

app.use('/api/user', require('./routes/User/user'));

app.listen(port, () => console.log(`Deployed on port ${port}`));


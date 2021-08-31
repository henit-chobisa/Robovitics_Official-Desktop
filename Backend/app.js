const express = require('express')
const cors = require('cors');
const db = require('./Config/Database');
const app = express();
const User = require('./models/User');
const { Mongoose } = require('mongoose');
const port = process.env.PORT || 1000;
app.use(express.json());
app.use(cors());


db();

app.use('/verification', require('./Config/Verification/verification'))
app.post('/addUser', async (req, res) => {
    const {email, password} = req.body
    let user = await User.findOne({ email });
    if (user == null){
        user = new User({email, password, password});
        user.save();
    }
    res.json("Ho gaya");
})

app.listen(port, () => console.log(`Deployed on port ${port}`));


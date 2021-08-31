const mongoose = require('mongoose');

const connect = async () => {
    try {
        await mongoose.connect("mongodb+srv://HenitChobisa:111.Dinesh@robovitics-official.ehj1s.mongodb.net/Robovitics-Official@HenitChobisa?retryWrites=true&w=majority",
            err => {
                if(err) throw err;
                console.log('connected to MongoDB')
            });
    }
    catch (err) {
        console.log(err)
    }
};

module.exports = connect;
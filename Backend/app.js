const express = require('express');
const cors = require('cors')
const app = express();
const port = process.env.port || 8000
app.use(cors);


app.get('/', (req, res) => {
    res.status(200);
    res.send("Everything Good!")
})

app.listen(port, () => console.log(`Deployed on port ${port}`))


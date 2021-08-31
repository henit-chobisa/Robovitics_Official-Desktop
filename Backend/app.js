const express = require('express')
const cors = require('cors');
const app = express();
const port = process.env.PORT || 1000;
app.use(express.json());
app.use(cors());

app.use('/verification', require('./Config/verification'))

app.listen(port, () => console.log(`Deployed on port ${port}`));


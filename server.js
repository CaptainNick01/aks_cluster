const express = require('express');
const moment = require('moment');

const app = express();

app.get('/time', (req, res) => {
  const time = moment().format('YYYY-MM-DD HH:mm:ss');
  res.json({ time });
});

const port = process.env.PORT;
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
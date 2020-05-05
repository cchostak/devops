var express = require('express');
var request = require('request');
var cors = require('cors');

const PORT = process.env.PORT || 3001;
const app = express();
app.use(cors());

app.get('/', function(req, res) {
  var url = 'http://localhost:3000/demo';

  request(url, { json: true }, (err, res2, body) => {
    console.log("request");
    if (err) {
      console.log(err);
      res.status(404).send(err);
    } else {
      console.log(body);

      res.json(body);
    }
  });
});

app.listen(PORT, function() {
  console.log(`Sever is listening on port ${PORT}`);
});

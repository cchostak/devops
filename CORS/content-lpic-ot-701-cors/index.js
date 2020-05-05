express = require('express');
cors = require('cors');

const PORT = process.env.PORT || 3000;
const app = express();

//app.use(cors());

app.get('/demo', function(req, res) {
  res.json(
    [
      {
        "first_name": "Bob",
        "last_name": "Dobbs"
      },
      {
        "first_name": "Jane",
        "last_name": "Doe"
      }
    ]
  );
});

app.listen(PORT, function() {
  console.log(`Sever is listening on port ${PORT}`);
});

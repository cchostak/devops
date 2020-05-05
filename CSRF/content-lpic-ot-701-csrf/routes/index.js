var csrf = require('csurf');
var express = require('express');
var bodyParser = require('body-parser');
var router = express.Router();

// setup route middlewares
var csrfProtection = csrf({ cookie: true })
var parseForm = bodyParser.urlencoded({ extended: false })

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/form', csrfProtection, function(req, res, next) {
  data = {
            title: 'CSRF Form Example',
            csrfToken: req.csrfToken()
         }
  res.render('form', data);
});

router.post('/process', parseForm, csrfProtection, function(req, res, next) {
  res.render('process');
});

module.exports = router;

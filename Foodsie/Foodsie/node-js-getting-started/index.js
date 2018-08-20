var express = require('express');
var stripe = require('stripe')('sk_test_u8yKDvKloPBx1L7nRck2LmVw');
var bodyParse = require('body-parser');
var app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended : true
}));

app.set('port', (process.env.PORT || 5000));
app.use(express.static(__dirname + '/public'));
app.set('views',__dirname + '/views');
app.set('view engine', 'ejs');


app.post('/createorder', (req, res) => {
  // reqiest body looks like this:
  // access_token
  // restaurant_id
  // address
  // order_details
          //meal dictionary: meal_id" : 1, quantitiy : 2 meal_id 2 quantity ]
  // stripe_token
  var stripe_token = req.body.stripe_token;



});

app.post('/ephermeral_keys', (req, res) => {
  var customerId = req.body.customer_id;
  var api_version = req.body.api_version;

  stripe.ephermeralKeys.create{
    {customer : customerId},
    {stripe_version : api_version}

  }.then((key) => {
    res.status(200).send(key);

  }).catch(err);
    console.log(err);
    res.status(500).end();

  });
});


app.listen(app.get('port')), function(() {
  console.log('Node app is running on port', app.get('port'))
});

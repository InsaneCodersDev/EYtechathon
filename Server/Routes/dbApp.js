const express = require('express');
const mongoose = require('mongoose');
const immunogram = require('../models/immunogram');
const Aadhar = require('../models/Aadhar');
const User = require('../models/User');
var bodyParser = require('body-parser');


// create application/json parser
var jsonParser = bodyParser.json()


const URI = 'mongodb+srv://InsaneCoders:insanecoders1234@cluster0.o1381.mongodb.net/ImmunoChain?retryWrites=true&w=majority';
const Immunogram = require('../models/immunogram');
const { ObjectId } = require('mongodb');
const { request } = require('express');
const router = express.Router();
const connectDB = async () => {
  await mongoose.connect(URI, { useUnifiedTopology: true, useNewUrlParser: true });
  console.log("Connected....");
}


connectDB();

router.get('/getposts', (req, res) => {

  Immunogram.find({}).then(posts => {
    console.warn(posts);
    res.json(posts);
  }).catch(err => console.log("Oops, Mistake hogayi" + err));
 
}
);


// router.post('/getaadhar', jsonParser,(req, res) => {
//   console.log(req.body.commentor_id);
//  Aadhar.find({"_id": ObjectId(req.body.commentor_id)}).then(data => {
//     console.log(data);
//     res.json(data);
//   }).catch(err => console.log("Oops, Mistake hogayi" + err));
 
// }

// );


router.get('/getUser', (req, res) => {

  User.find({}).then(posts => {
    console.warn(posts);
    console.warn(posts[0].comments[0]);
    res.json(posts);
  }).catch(err => console.log("Oops, Mistake hogayi" + err));
 
}

);
module.exports = router;

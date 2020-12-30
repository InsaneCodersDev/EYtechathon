const express = require('express');
const mongoose = require('mongoose');


const URI = 'mongodb+srv://InsaneCoders:insanecoders1234@cluster0.o1381.mongodb.net/ImmunoChain?retryWrites=true&w=majority';
const Immunogram = require('../models/immunogram');
const router = express.Router();
const connectDB = async () => {
  await mongoose.connect(URI, { useUnifiedTopology: true, useNewUrlParser: true });
  console.log("Connected....");
}

connectDB();

router.get('/getposts', (req, res) => {

  Immunogram.find({}).then(posts => {
    console.warn(posts);
    console.warn(posts[0].comments[0]);
    res.json(posts);
  }).catch(err => console.log("Oops, Mistake hogayi" + err));
 
}

);
module.exports = router;

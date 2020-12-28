const express = require('express');
const mongoose = require('mongoose');

const URI='mongodb+srv://InsaneCoders:insanecoders1234@cluster0.o1381.mongodb.net/ImmunoChain?retryWrites=true&w=majority';
const Immunogram =require('../models/immunogram');
const router = express.Router();
const connectDB = async () =>{
    await mongoose.connect(URI,  { useUnifiedTopology: true, useNewUrlParser:true});
    console.log("Connected....");
}




router.get('/getposts', (req, res) => {
    connectDB();
    Immunogram.find({},function(err,ImmunoGram){
      if(err) console.log(err);
      console.warn(ImmunoGram);
  });
    res.send('Hello World!');
  
  });
module.exports=router;
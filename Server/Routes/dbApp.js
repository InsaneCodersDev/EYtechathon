const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const immunogram = require('../models/immunogram');
const Aadhar = require('../models/Aadhar');
const User = require('../models/User');
const OTP = require('../models/OTP');
const Quiz = require('../models/Quiz');

var bodyParser = require('body-parser');


// create application/json parser
var jsonParser = bodyParser.json()


const URI = 'mongodb+srv://InsaneCoders:insanecoders1234@cluster0.o1381.mongodb.net/ImmunoChain?retryWrites=true&w=majority';
const Immunogram = require('../models/immunogram');
const { ObjectId } = require('mongodb');
const { request } = require('express');
const { json } = require('body-parser');
const router = express.Router();
const connectDB = async () => {
  await mongoose.connect(URI, { useUnifiedTopology: true, useNewUrlParser: true });
  console.log("Connected....");
}

connectDB();

router.get('/getposts', (req, res) => {

  Immunogram.find({}).then(posts => {
    res.json(posts);
  }).catch(err => console.log("Oops, Mistake hogayi" + err));
 
}
);

router.get('/getUser', (req, res) => {

  User.find({}).then(posts => {
    console.warn(posts);
    console.warn(posts[0].comments[0]);
    res.json(posts);
  }).catch(err => console.log("Oops, Mistake hogayi" + err));
 
});

router.get('/getQuiz',(req,res)=>{
    console.log("quiz");
    Quiz.find({},{quiz_name:1,quiz_startdate:1,quiz_enddate:1,quiz_url:1})
        .then(q=>{
          console.log(q);
          res.send(q);
        }).catch(err=>console.log(err));
});

router.post('/getQuestions',jsonParser,(req,res)=>{
  const name = req.body.name;
  console.log(name);  
  Quiz.find({quiz_name:name})
      .then(quiz=>{
        res.send(quiz);
      }).catch(err=>console.log(err));
})

router.post('/generateotp',jsonParser,(req,res)=>{
  const aadhar_number =req.body.aadhar;
  console.log(aadhar_number);
  Aadhar.findOne({aadhar_number:aadhar_number})
        .then(user=>{
          if(user==null){
            console.log("addhar number not registered");
            res.send("Aadhaar Number is Invalid");
          }else{
            var digits = '0123456789'; 
            let Otp_number = ''; 
            for (let i = 0; i < 4; i++ ) { 
            Otp_number += digits[Math.floor(Math.random() * 10)]; 
              }
            const newOtp = new OTP({
              aadhar_number: aadhar_number,
              otp: Otp_number
              });
              OTP.findOne({aadhar_number:aadhar_number})
                  .then(user=>{
                    if(user == null){
                      newOtp.save()
                      .then(u=>{
                        console.log("successfull");
                        res.send("OTP Sent to registered Number");
                      }).catch(err=>console.log(err));
                    }else{
                      console.log("OTP already Sent");
                      res.send("OTP Already Sent");
                    }
                  })
                }
        })
});

router.post('/signup',jsonParser,(req,res)=>{
  const aadhar_number =req.body.aadhar;
  const password = req.body.password;
  const otp = req.body.otp;
  console.log(password);

  OTP.findOne({aadhar_number:aadhar_number})
      .then(user=>{
        if(user != null){
          if(user.otp === otp){
            Aadhar.findOne({aadhar_number:aadhar_number})
                  .then(a=>{
                    if(a != null){
                      const newUser = new User({
                        username: a.name,
                        aadhar_no:aadhar_number,
                        password:password,
                        vaccinated:"NO",
                        score:0,
                        medical_conditions:[{
                            "Diabetic":false,
                            "Dproof_url":"NA",
                            "Pulmonary":false,
                            "Pproof_url":"NA",
                            "Heart_disease":false,
                            "Hproof_url":"NA",
                        }]
                      });
                      bcrypt.genSalt(10, (err,salt)=> {
                        bcrypt.hash(newUser.password, salt,(err,hash)=>{
                            if(err) throw err;
                             newUser.password = hash;
                             newUser.save()
                                .then(user => {
                                    console.log('done');
                                    res.send("True");
                                })
                                .catch(err => console.log(err));
                        });
                    });
                    }
                  })
          }else
          {
            console.log("Incorrect OTP");
            res.send("Invalid OTP");
          }
        }
      });
});

router.post('/login',jsonParser,(req,res)=>{
  const aadhar_no =req.body.aadhar;
  const password = req.body.password;
  console.log(password);
  console.log(aadhar_no);

    User.findOne({aadhar_no:aadhar_no})
        .then(user=>{
          if(user!=null){
            bcrypt.compare(password, user.password).then((isMatch) => {
              console.log(user.password);
              console.log(password);
              if(isMatch){
                console.log("Logged in");
                res.send("True");
              } else{
                console.log('Password incorrect');
                res.send("Password Incorrect");
              }
          }).catch((err)=>console.log(err));
          }else{
            console.log("aadhar number not registered");
            res.send("Aadhar number not registered");
          }
        })
});


router.post('/userDetails',jsonParser,(req,res)=>{
  const aadhar_no =req.body.aadhar;
  console.log(typeof(aadhar_no));

    User.findOne({aadhar_no:aadhar_no})
        .then(user=>{
          if(user!=null){
            res.send(user);
          }else{
            console.log("aadhar number not registered");
            res.send("Aadhar number not registered");
          }
        })
})
module.exports = router;

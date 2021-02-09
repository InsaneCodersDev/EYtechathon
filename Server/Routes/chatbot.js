const express = require('express');
const mongoose = require('mongoose');
const df = require('dialogflow-fulfillment');

const router = express.Router();
const VC = require('../models/VaccinationCenters');
var bodyParser = require('body-parser');
const URI = 'mongodb+srv://InsaneCoders:insanecoders1234@cluster0.o1381.mongodb.net/ImmunoChain?retryWrites=true&w=majority';
const connectDB = async () => {
  await mongoose.connect(URI, { useUnifiedTopology: true, useNewUrlParser: true });
  console.log("Connected....");
}



router.post('/', express.json(), (req, res) => {
  const agent = new df.WebhookClient({
    request: req,
    response: res
  });


  async function findCenter(agent) {
    var url="";
    var name="";
    var mindist=100000000;
    // console.log("Finding Center");
    var location = agent.context.get("location");
    var lat=location.parameters.latitude;
    var long= location.parameters.longitude;
    var hospitals = await VC.find({});
      for(var i=0;i<hospitals.length;i++){
        dist=Math.sqrt(Math.pow(hospitals[i].longitude-long,2)+Math.pow(hospitals[i].latitude-lat,2));
        // console.log("distance",dist);
        if(dist<mindist){url=hospitals[i].url; name=hospitals[i].name;
        console.log(name);}
      }
      console.log("Nearest center is "+name);
    // console.log("Hospitals:"+ hospitals);
    agent.add("Nearest center is:  "+name +"\nYou will find the directions here:- "+ url);
   

agent.add("Error");
   

  }

  function getLocationData(agent) {
    console.log(agent.parameters.longitude);
    agent.context.set("location", 100, { 'latitude': agent.parameters.latitude, 'longitude': agent.parameters.longitude });
    console.log(agent.context.get("location"));
    agent.add("Your Location is detected");

  }

  var intentMap = new Map();
  intentMap.set("GetLocation Data", getLocationData);
  intentMap.set("Vaccination Centers",findCenter);
  agent.handleRequest(intentMap);



});

module.exports = router;
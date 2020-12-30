const express = require('express');
const mongoose = require('mongoose');
const router = express.Router();
var bodyParser = require('body-parser');   // create application/json parser 
var jsonParser = bodyParser.json();


const URI = 'mongodb+srv://InsaneCoders:insanecoders1234@cluster0.o1381.mongodb.net/ImmunoChain?retryWrites=true&w=majority';
const Immunogram = require('../models/immunogram');


router.use(express.static('../Server/PostInterface'));
router.get('/', (req, res) => {
    res.sendFile('index.html', { root: "../Server/PostInterface" });
}

);


router.post('/post_interface', jsonParser, (req, res) => {
    console.log(req.body);
    res.send("Verified");
    
}
);


module.exports = router;

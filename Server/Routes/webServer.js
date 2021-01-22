const express = require('express');
const mongoose = require('mongoose');
const router = express.Router();
var bodyParser = require('body-parser');   // create application/json parser 
var jsonParser = bodyParser.json();
var session = require('express-session');


const URI = 'mongodb+srv://InsaneCoders:insanecoders1234@cluster0.o1381.mongodb.net/ImmunoChain?retryWrites=true&w=majority';
const User = require('../models/User');
const Immunogram = require('../models/immunogram');

router.use(express.static('../Server/PostInterface'));
router.get('/', (req, res) => {
    res.sendFile('index.html', { root: "../Server/PostInterface" });
}

);

router.use(session({secret:"abcd"}));

router.post('/post_interface', jsonParser, (req, res) => {
    console.log(req.body);

    User.findOne({ "username": req.body.username }).then(data => {
        console.log(req.pass, data.password);
        req.session.username=req.body.username;

        if (req.body.pass === data.password) { res.sendFile("addPost.html", { root: "../Server/PostInterface" }); }
        else { res.status(400).send(); }

    }).catch(err => console.log("Oops, Mistake hogayi" + err));
}
);

router.post('/addPost', jsonParser, (req, res) => {
    console.log(req.body.url);

    new Immunogram({
        // _id: mongoose.Schema.Types.ObjectId,
        username: req.session.username,
        post_time: new Date(Date.now()),
        image_url: req.body.url,
        caption: req.body.caption,
        no_likes: 0,
        no_dislikes: 0,
        profile_url:"https://instagram.fbom22-1.fna.fbcdn.net/v/t51.2885-19/s320x320/73457367_681556628996410_6035727685781553152_n.jpg?_nc_ht=instagram.fbom22-1.fna.fbcdn.net&_nc_ohc=JcjeP5OkT10AX8xPu27&tp=1&oh=06146332faa715222f3833e5121b7976&oe=6017E913"
    }).save().then(data => {
        console.log(data);
        res.send("File Uploaded Sucessfully");
    }).catch(err => console.log("Oops, Mistake hogayi" + err));
}
);


module.exports = router;

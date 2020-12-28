const express = require('express')
const app = express();
const port = 8000 || process.env.Port ; 
const dbAppRoute = require('./Routes/dbApp');
const chatBotRoute = require('./Routes/chatbot');

// const connectDB =require('./Routes/db');

var bodyParser=require('body-parser');
// const models = require('./models/index');
app.use(bodyParser.urlencoded({extended:true}));
// connectDB()

app.use(express.json({extended:false}));

app.use('/database',dbAppRoute);
app.use('/chatbot',chatBotRoute);
app.listen(port, () => {
  console.log(`Example app listening on port ${port}!`)
});
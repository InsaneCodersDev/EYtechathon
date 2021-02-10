const express = require('express')
const app = express();
const port = 8000 || process.env.Port ; 
const dbAppRoute = require('./Routes/dbApp');
const chatBotRoute = require('./Routes/chatbot');
const webAppRoute = require('./Routes/webServer');
// const connectDB =require('./Routes/db');

var bodyParser=require('body-parser');
// const models = require('./models/index');
app.use(bodyParser.urlencoded({extended:true}));
// connectDB()
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "*");
  if (req.method === "OPTIONS") {
    res.header("Access-Control-Allow-Methods", "PUT,POST,GET");
    return res.status(200).json({});
  }
  next();
});
app.use(express.json({extended:false}));

app.use('/database',dbAppRoute);
app.use('/chatbot',chatBotRoute);
app.use('/app',webAppRoute);
app.listen(port, () => {
  console.log(`Example app listening on port ${port}!`)
});
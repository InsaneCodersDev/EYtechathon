const express = require('express');

const router = express.Router();

router.get('/', (req, res) => {
  
    res.send('Hello From Chatbottt');
  
  });
module.exports=router;
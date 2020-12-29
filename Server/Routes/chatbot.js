const express = require('express');

const df = require('dialogflow-fulfillment');

const router = express.Router();



  router.post('/', express.json(), (req, res) => {
    const agent = new df.WebhookClient({
        request: req,
        response: res
    });

   

    var intentMap = new Map();
    intentMap.set("Ron_duel-end", handleduel_4);
    agent.handleRequest(intentMap);



});

module.exports=router;
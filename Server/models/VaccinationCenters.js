const { Int32 } = require('mongodb');
const { Timestamp } = require('mongodb');
const mongoose=require('mongoose');

let postSchema= new mongoose.Schema({
    name:String,
    latitude:String,
    longitude:String,
    url:String,
},
{collection:"Vaccination Centre"}
);
module.exports=mongoose.model('Vaccination Centre',postSchema);
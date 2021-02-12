const { Int32 } = require('mongodb');
const { Timestamp } = require('mongodb');
const mongoose=require('mongoose');
let postSchema= new mongoose.Schema({
    username:String,
    aadhar_no:String,
   password:String,
    vaccinated:String,
    score:Number,
   medical_conditions:Array,
   documents_url:Array
    

},
{collection:"User"}
);
module.exports=mongoose.model('User',postSchema);
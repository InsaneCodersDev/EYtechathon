const { Int32 } = require('mongodb');
const { Timestamp } = require('mongodb');
const mongoose=require('mongoose');
let postSchema= new mongoose.Schema({
    username:String,
    aadhar_no:String,
   password:String,
    vaccinated:String,
    score:Number,
   medical_conditions:[{
        "Diabetic":Boolean,
        "Dproof_url":String,
        "Pulmonary":Boolean,
        "Pproof_url":String,
        "Heart_disease":Boolean,
        "Hproof_url":String,
     }],
    

},
{collection:"User"}
);
module.exports=mongoose.model('User',postSchema);
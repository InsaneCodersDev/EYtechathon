const { Int32 } = require('mongodb');
const { Timestamp } = require('mongodb');
const mongoose=require('mongoose');
let postSchema= new mongoose.Schema({

    _id:mongoose.Schema.Types.ObjectId,

    image_url:String,
   name:String,
    dob:Date,
    aadhar_numer:String,
    phone: Number

 

},
{collection:"Aadhar"}
);
module.exports=mongoose.model('Aadhar',postSchema);
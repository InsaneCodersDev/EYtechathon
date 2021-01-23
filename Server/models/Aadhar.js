const { Int32 } = require('mongodb');
const { Timestamp } = require('mongodb');
const mongoose=require('mongoose');
let postSchema= new mongoose.Schema({

    _id:mongoose.Schema.Types.ObjectId,

    image_url:String,
   name:String,
    dob:Date,
<<<<<<< HEAD
    aadhar_number:String,
    phone:Number
=======
    aadhar_numer:String,
    phone: Number

>>>>>>> c11e075ef9eeaf3f41c5e76bdb0b972a8a146726
 

},
{collection:"Aadhar"}
);
module.exports=mongoose.model('Aadhar',postSchema);
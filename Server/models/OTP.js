const mongoose = require('mongoose');

const otpSchema = new mongoose.Schema({
    "aadhar_number":{
        type:String,
        required:true
    },
    "otp":{
        type:String,
        required:true
    }
},
{collection:"OTP_details"}
);

module.exports = mongoose.model('OTP_details',otpSchema);
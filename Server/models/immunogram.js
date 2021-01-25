const { Int32 } = require('mongodb');
const { Timestamp } = require('mongodb');
const mongoose=require('mongoose');
let postSchema= new mongoose.Schema({

    // _id:mongoose.Schema.Types.ObjectId,
    username:String,
    post_time:Date,
    image_url:String,
    caption:String,
    no_likes:Number,
    no_dislikes:Number,
    profile_url:String,
    type:String

},
{collection:"ImmunoGram"}
);
module.exports=mongoose.model('immunogram',postSchema);
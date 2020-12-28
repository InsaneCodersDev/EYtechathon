const { Int32 } = require('mongodb');
const { Timestamp } = require('mongodb');
const mongoose=require('mongoose');
let postSchema= new mongoose.Schema({

    _id:mongoose.Schema.Types.ObjectId,
    username:String,
    time:Date,
    image_url:String,
    caption:String,
    no_likes:Number,
    comments:[{
        "commentor_id":String,
        "comment":String,
        "comment_likes":Number,
     }],

},
{collection:"ImmunoGram"}
);
module.exports=mongoose.model('immunogram',postSchema);
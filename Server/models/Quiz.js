const mongoose = require('mongoose');

const QuizSchema = new mongoose.Schema({
    quiz_name:{type:String},
    quiz_startdate:{type:String},
    quiz_enddate:{type:String},
    quiz_url:{type:String},
    quiz_questions:[{
        question:{type:String},
        option1:{type:String},
        option2:{type:String},
        option3:{type:String},
        option4:{type:String},
        answer:{type:String},
        url:{type:String},
        description:{type:String}
    }]
});

const Quiz = mongoose.model('Quiz',QuizSchema);
module.exports = Quiz;
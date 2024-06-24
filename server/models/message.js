const mongoose=require('mongoose');

const messageSchema= mongoose.Schema({
    senderId:{
        type:String,
        required:true
    },
    message:{
        type:String,
        required:true,
    },
    clubId:{
        required:true,
        type:String,
    },
    createdAt:{
        default:Date.now,
        type:Date

    },
    name:{
        required:true,
        type:String
    }
});

const Message= mongoose.model('Message',messageSchema);
module.exports=Message;
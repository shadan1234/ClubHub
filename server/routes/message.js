const express=require("express");
const messageRouter=express.Router();
const auth=require('../middlewares/auth');
const Message = require("../models/message");


messageRouter.post('/send-message',auth,async(req,res)=>{
  try {
    const senderId=req.user;
    const  {name,clubId,message}=req.body;
    const messages=new Message({
      name,
      clubId,
      message,
      senderId,

    }) ;
    await messages.save();
    res.json(messages);
  } catch (e) {
    res.status(500).json({erorr:e.message});
  }
});

messageRouter.get('/fetch-messages/:clubId',auth,async(req,res)=>{
    try {
        const {clubId}=req.params;
        // console.log(clubId);
        const messages= await Message.find({clubId}).sort({ createdAt: -1 });
    // console.log(messages);
        res.json(messages);
    } catch (e) {
        res.status(500).json({error:e.message});
    }
});



module.exports=messageRouter;
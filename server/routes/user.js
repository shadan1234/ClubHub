const express = require("express");
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const User = require("../models/user");

const Club = require("../models/club");


userRouter.get('/api/all-clubs',async(req,res)=>{
  try {
    let clubs=await Club.find();
   
    
    res.json({clubs});
  } catch (e) {
    res.status(500).json({error:e.message});
  }
})

userRouter.get('/fetch-user-clubs',auth,async(req,res)=>{
 try {
  const singleUser = await User.findById(req.user);
  let clubs=[];
  // console.log(singleUser.name);
  for(let i=0;i<singleUser.clubs.length;i++){
    const club= await (Club.findById(singleUser.clubs[i]));
    if (club) {
      clubs.push(club);
    }
  }
  // console.log(clubs);
  res.json({clubs});
    
 } catch (e) {
  res.status(500).json({error:e.message});
 }
});


module.exports = userRouter;

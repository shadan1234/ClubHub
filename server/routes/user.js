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



module.exports = userRouter;

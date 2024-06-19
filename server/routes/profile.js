const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const profileRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

profileRouter.post("/update-profile-image", auth, async (req, res) => {
    const {imageUrl}=req.body;
     user = await User.findById(req.user);
    user.image=imageUrl;
    user = await user.save();
    
    res.json(user);
   
  });
  module.exports = profileRouter;

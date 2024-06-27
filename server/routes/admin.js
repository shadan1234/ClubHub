const express = require("express");
const adminRouter = express.Router();
const bcryptjs = require("bcryptjs");
const User=require('../models/user');
const admin = require("../middlewares/admin");
const Club = require("../models/club");

adminRouter.post("/create-club-manager", admin, async (req, res) => {
  const { nameOfClub, type, description, image, emailManager, passwordManager, nameManager,fcmToken } = req.body;

  try {
   
    const club = new Club({ nameOfClub, type, description, image });
    const savedClub = await club.save();
    const hashPassword = await bcryptjs.hash(passwordManager, 8);

    const user = new User({
      name: nameManager,
      email: emailManager,
      password: hashPassword,
      type: 'club-manager',
      clubOwned: savedClub._id,
      fcmToken
    });
    const savedUser = await user.save();

    // Step 3: Update the club with the manager's ID
    savedClub.managerId = savedUser._id;
    await savedClub.save();

    res.status(201).json({ message: 'Club and manager created successfully', club: savedClub, manager: savedUser });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = adminRouter;

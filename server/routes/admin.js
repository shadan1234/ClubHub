const express = require("express");
const adminRouter = express.Router();

const admin = require("../middlewares/admin");
const Club = require("../models/club");

adminRouter.post("/create-club", admin, async (req, res) => {
  try {
    // console.log(req);
    const { image, nameOfClub, type, description } = req.body;
    if (!image || !nameOfClub || !type || !description) {
      return res.status(400).json({ error: "All fields are required" });
    }
    let club = new Club({
      image,
      nameOfClub,
      type,
      description,
    });

    club = await club.save();
  
    res.json({ ...club._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;

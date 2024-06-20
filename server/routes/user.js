const express = require("express");
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const User = require("../models/user");
const Club = require("../models/club");
const auth = require("../middlewares/auth");
const Application = require("../models/application");
const Club = require("../models/club");


userRouter.get('/api/all-clubs',async(req,res)=>{
  try {
    let clubs=await Club.find();
   
    
    res.json({clubs});
  } catch (e) {
    res.status(500).json({error:e.message});
  }
})

// Apply for a club
userRouter.post('/api/apply', auth, async (req, res) => {
  const { clubId } = req.body;
  try {
    const application = new Application({
      userId: req.user,
      clubId,
    });
    await application.save();
    res.status(201).json(application);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get applications for a club (for club managers)
userRouter.get('/api/applications/:clubId', auth, async (req, res) => {
  const { clubId } = req.params;
  try {
    const applications = await Application.find({ clubId }).populate('userId', 'name email');
    res.status(200).json(applications);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Accept an application
userRouter.post('/api/applications/:applicationId/accept', auth, async (req, res) => {
  const { applicationId } = req.params;
  try {
    const application = await Application.findByIdAndUpdate(applicationId, { status: 'accepted' }, { new: true });
    res.status(200).json(application);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Reject an application
userRouter.post('/api/applications/:applicationId/reject', auth, async (req, res) => {
  const { applicationId } = req.params;
  try {
    const application = await Application.findByIdAndUpdate(applicationId, { status: 'rejected' }, { new: true });
    res.status(200).json(application);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});




module.exports = userRouter;

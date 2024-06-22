// routes/applicationRouter.js
const express = require('express');
const applicationRouter = express.Router();
const Application = require('../models/application');
const User = require('../models/user');
const Club = require('../models/club');
const auth = require('../middlewares/auth');
const isClubManager = require('../middlewares/club_manager');





// Submit an application
applicationRouter.post('/apply', auth, async (req, res) => {
  const { clubId, name,description,document } = req.body;
  const userId = req.user;

  try {
    const newApplication = new Application({ userId, clubId,name,description,document });
    await newApplication.save();
    res.status(201).json({ message: 'Application submitted' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get all applications for a club
applicationRouter.get('/applications/:clubId', auth, isClubManager, async (req, res) => {
  const { clubId } = req.params;

  try { 
    const applications = await Application.find({ clubId });
   
    res.status(200).json(applications);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Accept an application
applicationRouter.post('/applications/:applicationId/accept', auth, isClubManager, async (req, res) => {
  const { applicationId } = req.params;

  try {
    const application = await Application.findById(applicationId);
    application.status = 'accepted';
    let user=await User.findById(application.userId);
  
  

    if (!user.clubs.includes(application.clubId)) {
      user.clubs.push(application.clubId);
    }

    await user.save();

    await application.save();
    res.status(200).json({ message: 'Application accepted' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Reject an application
applicationRouter.post('/applications/:applicationId/reject', auth, isClubManager, async (req, res) => {
  const { applicationId } = req.params;

  try {
    const application = await Application.findById(applicationId);
    application.status = 'rejected';
    await application.save();
    res.status(200).json({ message: 'Application rejected' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = applicationRouter;

const express = require('express');
const Team = require('../models/teams');
const auth = require('../middlewares/auth');
const isClubManager = require('../middlewares/club_manager');
const User = require('../models/user');
const teamRouter = express.Router();

teamRouter.get('/fetch-all-users-of-club/:clubId', auth, isClubManager, async (req, res) => {
  const { clubId } = req.params;
  try {
    let users = await User.find();
    let ans = [];
    for (let i = 0; i < users.length; i++) {
      let user = users[i];
      for (let j = 0; j < user.clubs.length; j++) {
        if (user.clubs[j] === clubId) {
          ans.push(user);
          break;
        }
      }
    }
    res.json(ans);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

teamRouter.post('/create-team', auth, isClubManager, async (req, res) => {
  const { name, topic, description, users, clubId } = req.body;
  try {
    const team = new Team({
      name,
      topic,
      description,
      users,
      clubId,
    });
    // console.log(team);
    await team.save();
    res.json(team);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

teamRouter.get('/teams/:clubId', auth, async (req, res) => {
  const { clubId } = req.params;
  try {
    const teams = await Team.find({ clubId }).populate('users', 'name email');
    res.json(teams);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
teamRouter.get('/teams-for-member/:clubId', auth, async (req, res) => {
  const { clubId } = req.params;
  const userId=req.user;
  try {
    const teams = await Team.find({ 
      
        $and: [
          { clubId: clubId },
          { users: userId   },
        ],
      


     }).populate('users', 'name email').sort({ createdAt: -1 });;
    res.json(teams);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
module.exports = teamRouter;

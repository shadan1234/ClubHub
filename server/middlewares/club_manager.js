const jwt=require('jsonwebtoken');
const User = require('../models/user');

const isClubManager = async (req, res, next) => {
    const user = await User.findById(req.user);
    if (user && user.type === 'club-manager') {
      next();
    } else {
      res.status(403).json({ message: 'Access denied' });
    }
  };

  module.exports=isClubManager;
const mongoose = require("mongoose");

const applicationSchema = mongoose.Schema({
  userId: {
    required: true,
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
  },
  clubId: {
    required: true,
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Club',
  },
  status: {
    type: String,
    enum: ['pending', 'accepted', 'rejected'],
    default: 'pending',
  },
  appliedAt: {
    type: Date,
    default: Date.now,
  },
  name:{
    type:String,
    required:true,
  }
});

const Application = mongoose.model('Application', applicationSchema);
module.exports = Application;

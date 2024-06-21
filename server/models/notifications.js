const mongoose = require("mongoose");

const notificationSchema = new mongoose.Schema({
  recipientType: {
    type: String,
    enum: ["general", "club-specific"],
    required: true,
  },
  title: {
    required: true,
    type: String,
  },
  message: { type: String, required: true },

  clubId: { type: mongoose.Schema.Types.ObjectId, ref: "Club", required: true },
  createdAt: { type: Date, default: Date.now },
});

const Notification = mongoose.model("Notification", notificationSchema);
module.exports = Notification;

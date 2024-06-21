const express = require('express');
const Notification = require('../models/notifications');
const User = require('../models/user');
const admin = require('firebase-admin');
const auth = require('../middlewares/auth');
const isClubManager = require('../middlewares/club_manager');
const notificationRouter = express.Router();

const serviceAccount = require('../config/clubhub-c4d71-firebase-adminsdk-b5965-c959ed7bcb.json');
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://clubhub-c4d71-default-rtdb.firebaseio.com/' // replace with your database URL
});

notificationRouter.post('/send-notification', auth, isClubManager, async (req, res) => {
  const { recipientType, title, message, clubId } = req.body;

  try {
    let recipients = [];
    const listOfUsers = await User.find();

    if (recipientType === 'general') {
      recipients = listOfUsers.filter(user => user.type === 'user');
    } else if (recipientType === 'club-specific') {
      recipients = listOfUsers.filter(user => user.type === 'user' && user.clubs.includes(clubId));
    } else {
      return res.status(400).send({ success: false, message: 'Invalid recipient type or missing clubId.' });
    }

    const fcmTokens = recipients.map(user => user.fcmToken).filter(token => token);

    const notification = new Notification({
      recipientType,
      title,
      message,
      clubId,
      createdAt: new Date()
    });

    await notification.save();

    const payload = {
      notification: {
        title,
        body: message,
      },
    };

    if (fcmTokens.length > 0) {
      const response = await admin.messaging().sendMulticast({
        tokens: fcmTokens,
        notification: payload.notification,
      });

      console.log('Successfully sent message:', response);
    }

    res.status(200).send({ success: true, message: 'Notification sent successfully.' });
  } catch (error) {
    res.status(500).send({ success: false, message: error.message });
  }
});

notificationRouter.get('/fetch-notifications', auth, async (req, res) => {
  try {
    const user = await User.findById(req.user);
    if (!user) {
      return res.status(404).send({ message: 'User not found.' });
    }

    const notifications = await Notification.find({
      $or: [
        { recipientType: 'general' },
        { clubId: { $in: user.clubs } },
      ],
    }).sort({ createdAt: -1 });
// console.log(notifications);
    res.status(200).send(notifications);
  } catch (error) {
    res.status(500).send({ message: error.message });
  }
});

module.exports = notificationRouter;

const express = require('express');
const Notification = require('../models/notifications');
const User = require('../models/user');
const admin = require('firebase-admin');
const auth = require('../middlewares/auth');
const isClubManager = require('../middlewares/club_manager');
const notificationRouter = express.Router();
const Club = require('../models/club');

const serviceAccount = {
  type: process.env.FIREBASE_TYPE,
  project_id: process.env.FIREBASE_PROJECT_ID,
  private_key_id: process.env.FIREBASE_PRIVATE_KEY_ID,
  private_key: process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, '\n'),
  client_email: process.env.FIREBASE_CLIENT_EMAIL,
  client_id: process.env.FIREBASE_CLIENT_ID,
  auth_uri: process.env.FIREBASE_AUTH_URI,
  token_uri: process.env.FIREBASE_TOKEN_URI,
  auth_provider_x509_cert_url: process.env.FIREBASE_AUTH_PROVIDER_X509_CERT_URL,
  client_x509_cert_url: process.env.FIREBASE_CLIENT_X509_CERT_URL,
};

if (!serviceAccount.private_key) {
  throw new Error("FIREBASE_PRIVATE_KEY environment variable is missing or empty.");
}

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://clubhub-c4d71-default-rtdb.firebaseio.com/"
});

// Example routes (existing code)
notificationRouter.post('/send-notification', auth, isClubManager, async (req, res) => {
  const { recipientType, title, message, clubId } = req.body;
  const club = await Club.findById(clubId);
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
      createdAt: new Date(),
      image: club.image
    });

    await notification.save();

    const payload = {
      notification: {
        title,
        body: message,
      },
    };

    if (fcmTokens.length > 0) {
      const response = await admin.messaging().sendEachForMulticast({
        tokens: fcmTokens,
        notification: payload.notification,
      });

      response.responses.forEach((resp, idx) => {
        if (!resp.success) {
          console.error(`Failed to send to ${fcmTokens[idx]}:`, resp.error);
        }
      });

      console.log('Successfully sent message:', response);
    } else {
      console.log('No valid FCM tokens to send notifications to.');
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

    res.status(200).send(notifications);
  } catch (error) {
    res.status(500).send({ message: error.message });
  }
});

notificationRouter.post('/update-fcm-token', auth, async (req, res) => {
  const { fcmToken } = req.body;
  const userId = req.user;

  try {
    await User.findByIdAndUpdate(userId, { fcmToken });
    res.status(200).send('FCM token updated successfully');
  } catch (error) {
    res.status(500).send('Failed to update FCM token');
  }
});

module.exports = notificationRouter;
